from django.shortcuts import render
from django.http.response import JsonResponse
import json
import google.generativeai as genai
from dotenv import load_dotenv
from pyresparser import ResumeParser
from django.core.files.storage import FileSystemStorage
import os

load_dotenv()


genai.configure(api_key=os.environ["GEMINI_API_KEY"])

model = genai.GenerativeModel('gemini-1.5-flash')


def index(request):
    if request.method == 'POST':
        resume = request.FILES['file']
        job_description = request.POST['job-desc']

        fs = FileSystemStorage()
        filename = fs.save(resume.name, resume)
        uploaded_file_path = fs.path(filename)
        data = ResumeParser(uploaded_file_path).get_extracted_data()
        json_data = json.dumps(data)

        response = model.generate_content(f"""
    I will give you a resume that is parsed into json format and i will also provide you with a summary of the resume.
    i am going to give you the job description aswell with two new lines in between and i want you to give an advice on the resume based on the job description also give score out 0f 10 make sure to call the name on the resume occationally. here is the resume and the job description.
    RESUME => {json_data}

    JOB DESCRIPTION => {job_description}

and on your response please replace r'\n' with actual new line      
    """)
        
        context = response.text
        if os.path.exists(uploaded_file_path):
            os.remove(uploaded_file_path)
        return JsonResponse(context, safe=False)
    return render(request, 'index.html')

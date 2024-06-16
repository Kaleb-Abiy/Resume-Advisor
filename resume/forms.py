from django import forms


class DescriptionForm(forms.Form):
    job_description = forms.Textarea()


    
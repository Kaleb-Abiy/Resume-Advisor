echo "BUILD START"

# create a virtual environment named 'venv' if it doesn't already exist
python3.9 -m venv venv

# activate the virtual environment
source venv/bin/activate

pip3.9 install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.3.1/en_core_web_sm-2.3.1.tar.gz

# install all deps in the venv
pip install -r requirements.txt

# spaCy
python3.9 -m spacy download en_core_web_sm

# nltk
python3.9 -m nltk.downloader words
python3.9 -m nltk.downloader stopwords

pip3.9 install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.3.1/en_core_web_sm-2.3.1.tar.gz
# collect static files using the Python interpreter from venv
python3.9 manage.py collectstatic --noinput

echo "BUILD END"
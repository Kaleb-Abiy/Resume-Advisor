#!/usr/bin/env bash
# Exit on error
set -o errexit

echo "BUILD START"

pip install numpy==1.25

pip install -r requirements.txt

python -m nltk.downloader words
python -m nltk.downloader stopwords

# spaCy
python -m spacy download en_core_web_sm

pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.3.1/en_core_web_sm-2.3.1.tar.gz


# pip install django
# pip install pyresparser

# nltk


pip install python-dotenv 

pip install -q -U google-generativeai


python manage.py collectstatic --noinput

echo "BUILD END"
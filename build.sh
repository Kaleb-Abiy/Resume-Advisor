#!/usr/bin/env bash
# Exit on error
set -o errexit

echo "BUILD START"

# create a virtual environment named 'venv' if it doesn't already exist

# activate the virtual environment

pip install --upgrade pip

pip install django

pip install numpy==1.25


pip install nltk

# nltk
python -m nltk.downloader words
python -m nltk.downloader stopwords

pip install python-dotenv 

pip install pyresparser

# spaCy
python -m spacy download en_core_web_sm





pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.3.1/en_core_web_sm-2.3.1.tar.gz

pip install -q -U google-generativeai

pip install -r requirements.txt



python manage.py collectstatic --noinput

echo "BUILD END"
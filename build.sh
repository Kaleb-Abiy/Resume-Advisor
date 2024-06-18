#!/usr/bin/env bash
# Exit on error
set -o errexit

echo "BUILD START"

pip install django

pip install 'whitenoise[brotli]'

pip install python-dotenv

pip install gunicorn uvicorn

pip install -q -U google-generativeai

pip install pyresparser

pip install numpy==1.25

pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.3.1/en_core_web_sm-2.3.1.tar.gz

# nltk
python -m nltk.downloader words
python -m nltk.downloader stopwords

python manage.py collectstatic --noinput

echo "BUILD END"
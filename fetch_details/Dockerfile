FROM python:3.6-slim-jessie
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 fetch_details:app

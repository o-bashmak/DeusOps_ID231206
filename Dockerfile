FROM python:3-slim
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# RUN pip install -- upgrade pip

WORKDIR /app
VOLUME /media/files
COPY . .
RUN apt update && pip install -r /app/requirements.txt

CMD ["gunicorn", "-b", "0.0.0.0:8000", "filesharing.wsgi:application"]

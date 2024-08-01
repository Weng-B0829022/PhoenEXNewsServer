FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

WORKDIR /app/server

RUN python manage.py collectstatic --noinput --clear

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
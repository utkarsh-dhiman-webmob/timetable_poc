FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# System deps (optional but helpful for some libs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    pkg-config \
    libcairo2-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . /app/

# If you use static files in prod:
# RUN python projttgs/manage.py collectstatic --noinput

EXPOSE 8000

# Change "projttgs.wsgi:application" if your project name differs
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "projttgs.wsgi:application"]
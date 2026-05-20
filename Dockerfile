# Dockerfile
FROM python:3.13-slim

# Установка зависимостей системы
RUN apt-get update && apt-get install -y gcc libpq-dev

# Рабочая директория
WORKDIR /app

# Копировать зависимости
COPY requirements.txt .

# Установить зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копировать весь проект
COPY . .

# Переменные окружения
ENV PYTHONUNBUFFERED=1

# Команда запуска будет в docker-compose
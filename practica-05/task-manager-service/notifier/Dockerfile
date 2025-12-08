FROM python:3.9-slim-buster

WORKDIR /app
ENV PYTHONUNBUFFERED=1

# Instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código
COPY . .

# Ejecutar el notifier
CMD ["python", "-u", "notifier.py"]

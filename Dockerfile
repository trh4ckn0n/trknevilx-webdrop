FROM python:3.11-slim

# Dépendances système
RUN apt update && apt install -y curl systemd libffi-dev build-essential libssl-dev && \
    pip install --upgrade pip && \
    pip install flask openai pyTelegramBotAPI

# Dossier de travail
WORKDIR /app

# Copie des fichiers
COPY . /app

# Script install & lancement
RUN chmod +x install.sh && ./install.sh

# Port Flask
EXPOSE 5000

CMD ["python", "app.py"]

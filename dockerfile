FROM python:3.11-slim

# Install Docker CLI and other tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    docker.io \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy scripts
COPY secret.py start.sh ./
RUN chmod +x ./start.sh

# Default command
CMD ["./start.sh"]

FROM docker:latest

# Install Python and additional tools
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl \
    bash

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

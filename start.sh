#!/bin/bash

set -e

echo "======================================"
echo "Forgejo + Runner Docker Setup"
echo "======================================"

# Generate secrets if .env doesn't exist
if [ ! -f .env ]; then
    echo "→ Generating secrets..."
    python3 secret.py
else
    echo "→ Using existing .env file"
fi

# Load environment
export $(cat .env | grep -v '#' | xargs)

# Start Docker Compose
echo "→ Starting Forgejo and Runner services..."
docker-compose up -d

echo ""
echo "======================================"
echo "✓ Services started successfully!"
echo "======================================"
echo ""
echo "Forgejo Web UI: http://localhost:3000"
echo "SSH Git: ssh://git@localhost:222"
echo ""
echo "View logs:"
echo "  docker-compose logs -f forgejo"
echo "  docker-compose logs -f runner"
echo ""
echo "Stop services:"
echo "  docker-compose down"
echo ""

#!/usr/bin/env python3
"""Generate secrets for Forgejo and Runner setup."""

import secrets
import string
import os
from pathlib import Path

def generate_token(length=40):
    """Generate a secure random token."""
    alphabet = string.ascii_letters + string.digits
    return ''.join(secrets.choice(alphabet) for _ in range(length))

def generate_uuid():
    """Generate a UUID-like string."""
    import uuid
    return str(uuid.uuid4())

def create_env_file(env_path=".env"):
    """Create .env file with generated secrets."""
    token = generate_token()
    uuid = generate_uuid()
    secret = generate_token(32)
    
    env_content = f"""# Forgejo Configuration
FORGEJO_TOKEN={token}
FORGEJO_UUID={uuid}
FORGEJO_SECRET={secret}

# Docker Configuration
DOCKER_HOST=tcp://docker-in-docker:2375

# Runner Configuration
RUNNER_TOKEN={generate_token()}
RUNNER_UUID={generate_uuid()}
"""
    
    Path(env_path).write_text(env_content)
    print(f"✓ Generated {env_path} with secure secrets")
    print(f"  - Token: {token[:8]}...")
    print(f"  - UUID: {uuid}")

if __name__ == "__main__":
    create_env_file()

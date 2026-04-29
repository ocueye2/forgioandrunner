#!/bin/bash

# Helper script for common Forgejo + Runner tasks

case "$1" in
  logs)
    SERVICE="${2:-}"
    if [ -z "$SERVICE" ]; then
      docker-compose logs -f
    else
      docker-compose logs -f "$SERVICE"
    fi
    ;;
  
  stop)
    echo "Stopping services..."
    docker-compose down
    ;;
  
  restart)
    echo "Restarting services..."
    docker-compose restart
    ;;
  
  status)
    docker-compose ps
    ;;
  
  clean)
    echo "⚠️  This will remove all data!"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      docker-compose down -v
      echo "✓ Cleaned up all containers and volumes"
    fi
    ;;
  
  shell)
    SERVICE="${2:-forgejo}"
    docker-compose exec "$SERVICE" sh
    ;;
  
  regen-secrets)
    echo "Regenerating secrets..."
    python3 secret.py
    ;;
  
  *)
    echo "Forgejo + Runner Helper"
    echo ""
    echo "Usage: $0 {command} [options]"
    echo ""
    echo "Commands:"
    echo "  logs [service]      - View logs (optional service: forgejo, runner, docker-in-docker)"
    echo "  stop                - Stop all services"
    echo "  restart             - Restart all services"
    echo "  status              - Show service status"
    echo "  clean               - Remove all containers and volumes"
    echo "  shell [service]     - Open shell in service (default: forgejo)"
    echo "  regen-secrets       - Regenerate .env secrets"
    echo ""
    echo "Examples:"
    echo "  $0 logs runner"
    echo "  $0 shell forgejo"
    echo "  $0 restart"
    ;;
esac

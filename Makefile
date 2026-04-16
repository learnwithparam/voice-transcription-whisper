.PHONY: help setup dev backend frontend build up down logs clean restart

.DEFAULT_GOAL := help

BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m

help: ## Show this help
	@echo "$(BLUE)Local Voice Transcription with Whisper and LLM Post-Processing$(NC)"
	@echo ""
	@echo "$(GREEN)Usage:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

setup: ## Install backend and frontend dependencies
	@if [ ! -f backend/.env ]; then cp backend/.env.example backend/.env && echo "$(GREEN)✓ backend/.env created (edit it before first run)$(NC)"; fi
	@cd backend && uv sync
	@cd frontend && npm install
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

dev: setup ## Run backend and frontend together (two terminals recommended)
	@echo "$(YELLOW)Tip: run 'make backend' and 'make frontend' in separate terminals.$(NC)"
	@$(MAKE) -j 2 backend frontend

backend: ## Run only the FastAPI backend
	@cd backend && uv run uvicorn app:app --reload --host 0.0.0.0 --port 8000 --timeout-keep-alive 600

frontend: ## Run only the Vite frontend
	@cd frontend && npm run dev

build: ## Build Docker images
	docker compose build

up: ## Start containers
	docker compose up -d

down: ## Stop containers
	docker compose down

logs: ## View container logs
	docker compose logs -f

restart: down up ## Restart containers

clean: ## Remove venv, node_modules, and caches
	rm -rf backend/.venv frontend/node_modules
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@echo "$(GREEN)✓ Cleaned$(NC)"

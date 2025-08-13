# Makefile for Rails (Postgres + optional Node/Yarn) on WSL/Linux
SHELL := /usr/bin/env bash
.ONESHELL:
.DEFAULT_GOAL := help

APP := $(shell basename "$$(pwd)")
RAILS := bin/rails
BUNDLE := bundle
RUBY_REQ := $(shell cat .ruby-version 2>/dev/null || echo "")
PORT ?= 3000
HOST ?= 127.0.0.1

# ---- helpers ---------------------------------------------------------------

define check_ruby
@if [[ -n "$(RUBY_REQ)" ]]; then
  CUR="$$(ruby -e 'puts RUBY_VERSION')"
  if [[ "$$CUR" != "$(RUBY_REQ)"* ]]; then
    echo "Expected Ruby $(RUBY_REQ), got $$CUR. (rbenv global/local?)"
  fi
fi
endef

define node_install
@if [[ -f package.json ]]; then
  if command -v yarn >/dev/null 2>&1; then
    echo "Installing JS deps with yarn..."
    yarn install
  elif command -v npm >/dev/null 2>&1; then
    echo "Installing JS deps with npm..."
    npm install
  else
    echo "No Yarn/npm found; skipping JS deps."
  fi
fi
endef

define node_build
@if [[ -f package.json && -f bin/dev ]]; then
  echo "Building assets (Rails+Node)..."
  # Replace below with your actual build command if different
  yarn build || npm run build || true
fi
endef

# ---- targets ---------------------------------------------------------------

.PHONY: help
help: ## Show targets
	@awk 'BEGIN{FS":.*##"; printf "\n\033[1mTargets\033[0m\n"} /^[a-zA-Z0-9_.-]+:.*##/ {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo

.PHONY: env
env: ## Create .env from example if missing
	@if [[ -f .env ]]; then echo ".env exists"; else \
	  if [[ -f .env.example ]]; then cp .env.example .env && echo "Created .env from .env.example"; \
	  else touch .env && echo "Created empty .env"; fi; \
	fi

.PHONY: bundle
bundle: ## Install Ruby gems (vendor/bundle)
	$(call check_ruby)
	$(BUNDLE) config set path 'vendor/bundle'
	$(BUNDLE) install

.PHONY: db-create
db-create: ## Create databases
	$(RAILS) db:create

.PHONY: db-migrate
db-migrate: ## Run migrations
	$(RAILS) db:migrate

.PHONY: db-setup
db-setup: ## Create + migrate + seed (idempotent)
	$(RAILS) db:setup

.PHONY: db-reset
db-reset: ## Drop + setup from scratch
	$(RAILS) db:reset

.PHONY: assets
assets: ## Install/build Node assets if package.json present
	$(call node_install)
	$(call node_build)

.PHONY: server
server: ## Start Rails server
	$(RAILS) server -b $(HOST) -p $(PORT)

.PHONY: demo
demo: env bundle assets db-setup ## Install deps, setup DB, build assets, then start server
	@echo "Starting $(APP) on http://$(HOST):$(PORT)"
	exec $(RAILS) server -b $(HOST) -p $(PORT)

.PHONY: console
console: ## Rails console
	$(RAILS) console

.PHONY: test
test: ## Run test suite (RSpec or Minitest)
	@if [[ -f bin/rspec || -f ./spec ]]; then $(BUNDLE) exec rspec; \
	else $(RAILS) test; fi

.PHONY: lint
lint: ## Rubocop if present
	@if grep -q rubocop Gemfile 2>/dev/null; then $(BUNDLE) exec rubocop || true; else echo "Rubocop not in Gemfile"; fi

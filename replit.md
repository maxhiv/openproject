# OpenProject

## Overview
OpenProject is a web-based project management software built with Ruby on Rails (backend) and Angular (frontend). It provides project planning, task management, Agile/Scrum boards, time tracking, and more.

## Project Architecture
- **Backend**: Ruby on Rails 8.1.2 (Ruby 4.0.0)
- **Frontend**: Angular 21 (compiled and served as static assets by Rails)
- **Database**: PostgreSQL (Replit managed, accessed via DATABASE_URL)
- **Asset Pipeline**: Sprockets for Rails assets, Angular CLI for frontend build

## Key Directories
- `app/` - Rails application code (models, controllers, views, components)
- `frontend/` - Angular frontend application
- `config/` - Rails configuration
- `db/` - Database migrations and schema
- `modules/` - OpenProject plugin modules (budgets, costs, meetings, etc.)
- `public/assets/frontend/` - Compiled Angular frontend assets
- `lib/` - Library code and rake tasks

## Running the Application
- The Rails server runs on port 5000 (bound to 0.0.0.0)
- Frontend assets are precompiled (dev asset proxy is disabled via OPENPROJECT_DISABLE_DEV_ASSET_PROXY=true)
- Database migrations and seeds have been applied

## Environment Variables
- `DATABASE_URL` - PostgreSQL connection string (auto-configured)
- `RAILS_ENV` - Set to "development"
- `PORT` - 5000
- `HOST` - 0.0.0.0
- `SECRET_KEY_BASE` - Application secret key
- `OPENPROJECT_DISABLE_DEV_ASSET_PROXY` - Disables Angular dev server proxy
- `OPENPROJECT_HTTPS` - Set to "true" for Replit proxy HTTPS
- `OPENPROJECT_HOST__NAME` - Set to Replit dev domain (double underscore maps to dot in OpenProject config)
- `SILENCE_SQL_LOGS` - Reduces log noise

## Frontend Build
To rebuild frontend assets:
```bash
cd frontend && npm run build
bundle exec rails runner "OpenProject::Assets.rebuild_manifest!"
```

Before building, ensure plugins are registered:
```bash
bundle exec rake openproject:plugins:register_frontend
```

## Default Login
After seeding, use the default admin credentials: admin / admin

## Recent Changes
- 2026-02-18: Initial Replit setup
  - Configured Ruby 4.0.0, Node.js 22, PostgreSQL 16
  - Built Angular frontend assets
  - Configured database via DATABASE_URL
  - Enabled all hosts for Replit proxy compatibility
  - Set up deployment configuration
- 2026-02-18: Fixed login/CSRF and host configuration
  - Changed home_url to home_path in redirect_after_login.rb to fix OpenRedirectError
  - Disabled CSRF origin check in development (forgery_protection_origin_check = false) for Replit proxy
  - Set OPENPROJECT_HTTPS=true and OPENPROJECT_HOST__NAME to Replit dev domain
  - Updated host_name and protocol settings in database

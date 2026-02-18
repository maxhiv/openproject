# OpenProject

## Overview
OpenProject project management platform with enterprise/premium features hidden.
ISP/MSP and Construction management use case.

## Architecture
- **Backend**: Ruby on Rails 8.1.2 (Ruby 4.0.0)
- **Frontend**: Angular 21 (precompiled)
- **Database**: PostgreSQL via DATABASE_URL (Replit managed)
- **Port**: 5000 (served by Rails)

## Key Directories
- `app/` - Rails application code
- `frontend/` - Angular frontend (precompiled)
- `config/` - Rails configuration
- `db/` - Database migrations and schema
- `modules/` - OpenProject plugin modules
- `control-plane/` - Custom Control Plane app (paused, not in active use)

## Running
```bash
bundle exec rails server -b 0.0.0.0 -p 5000
```

## Environment Variables
- `DATABASE_URL` - PostgreSQL connection (Replit managed)
- `RAILS_ENV` - Rails environment
- `SECRET_KEY_BASE` - Session secret
- `OPENPROJECT_HTTPS` - HTTPS setting (false for dev)
- `OPENPROJECT_HOST__NAME` - Host name for the instance
- `OPENPROJECT_DISABLE_DEV_ASSET_PROXY` - Disable dev asset proxy
- `OPENPROJECT_EE__HIDE__BANNERS` - **Set to true** to hide enterprise/premium upgrade banners
- `SILENCE_SQL_LOGS` - Reduce SQL log noise

## Default Login
- Username: admin
- Password: admin

## Recent Changes
- 2026-02-18: Initial Replit setup for OpenProject
- 2026-02-18: Fixed OpenProject login/CSRF and host configuration
- 2026-02-18: Scaffolded Control Plane Rails API (paused)
- 2026-02-18: Reversed approach - using OpenProject directly with premium features hidden
  - Set OPENPROJECT_EE__HIDE__BANNERS=true to hide enterprise banners
  - Switched primary workflow to OpenProject on port 5000
  - Removed Control Plane workflow

## User Preferences
- Use OpenProject directly instead of separate Control Plane
- Hide all premium/enterprise features and upgrade prompts
- GCP Cloud Run deployment target

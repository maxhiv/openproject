# Control Plane + OpenProject

## Overview
Two-repo architecture for ISP/MSP and Construction management:
1. **OpenProject** (vanilla, unmodified) - Core project management at workspace root
2. **Control Plane** (custom app) - ISP/MSP + Construction + Client Portal at `control-plane/`

## Architecture

### OpenProject (Root Directory)
- **Backend**: Ruby on Rails 8.1.2 (Ruby 4.0.0)
- **Frontend**: Angular 21 (precompiled)
- **Database**: PostgreSQL via DATABASE_URL (Replit managed)
- **Port**: 5000 (served by Rails, primary workflow)

### Control Plane (`control-plane/`)
- **Backend**: Ruby on Rails 8.1.2 (Ruby 4.0.0)
- **Frontend**: Angular 21 (`control-plane/frontend/`)
- **Database**: PostgreSQL via CONTROL_PLANE_DATABASE_URL (separate database: control_plane_dev)
- **Auth**: Firebase Authentication (token verification + session cookies)
- **Integration**: OpenProject API v3 client

## Key Directories
### OpenProject
- `app/` - Rails application code
- `frontend/` - Angular frontend
- `config/` - Rails configuration
- `db/` - Database migrations and schema
- `modules/` - OpenProject plugin modules

### Control Plane
- `control-plane/app/models/` - All domain models (Organization, User, IspSite, Ticket, etc.)
- `control-plane/app/controllers/api/` - REST API controllers
- `control-plane/app/controllers/api/portal/` - Client portal endpoints
- `control-plane/app/services/` - FirebaseAuth, OpenprojectClient services
- `control-plane/frontend/src/app/` - Angular app (pages, services, components)
- `control-plane/docs/` - Feature Matrix, MVP Roadmap
- `control-plane/db/migrate/` - 15 migrations for all domain tables

## Database Schema (Control Plane)
- organizations, users, memberships, audit_logs
- control_plane_projects (links to OpenProject projects)
- isp_sites, network_assets, ip_pools (ISP/MSP module)
- tickets (with SLA, RCA fields), change_requests (with approval workflow)
- construction_packages, construction_milestones (with client approval)
- permits, procurement_items, project_snapshots

## Running the Applications
### OpenProject (current workflow)
```bash
bundle exec rails server -b 0.0.0.0 -p 5000
```
### Control Plane (separate, not currently in workflow)
```bash
cd control-plane && CONTROL_PLANE_DATABASE_URL="..." bundle exec rails server -b 0.0.0.0 -p 3100
```

## Environment Variables
### OpenProject
- `DATABASE_URL`, `RAILS_ENV`, `PORT`, `HOST`
- `SECRET_KEY_BASE`, `OPENPROJECT_HTTPS`, `OPENPROJECT_HOST__NAME`
- `OPENPROJECT_DISABLE_DEV_ASSET_PROXY`, `SILENCE_SQL_LOGS`

### Control Plane
- `CONTROL_PLANE_DATABASE_URL` - Separate PostgreSQL database
- `FIREBASE_PROJECT_ID` - Firebase Auth project ID
- `OPENPROJECT_URL` - OpenProject instance URL
- `OPENPROJECT_API_TOKEN` - API token for OpenProject integration

## Deployment
- Both apps have Dockerfiles, docker-compose.yml, cloudbuild.yaml
- `openproject-deploy/` - Vanilla OpenProject deployment config
- `control-plane/` - Control Plane deployment config
- Target: GCP Cloud Run (with GCE fallback for OpenProject)

## Default Login
- OpenProject: admin / admin
- Control Plane: Firebase Auth (dev login available in development)

## Recent Changes
- 2026-02-18: Initial Replit setup for OpenProject
- 2026-02-18: Fixed OpenProject login/CSRF and host configuration
- 2026-02-18: Scaffolded complete Control Plane Rails API
  - 15 database migrations, all models with validations and scopes
  - Firebase Auth service with JIT user provisioning
  - OpenProject API client service
  - 14 API controllers (10 main + 4 portal)
  - Angular frontend scaffold with login, dashboard, stub pages
  - Deployment files (Dockerfile, docker-compose, cloudbuild) for both repos
  - Feature Matrix and MVP Roadmap documentation

## User Preferences
- Two-repo architecture: vanilla OpenProject + custom Control Plane
- Same stack (Rails 8.1.2 + Angular 21) for both
- Firebase Authentication for Control Plane
- Session cookie auth after Firebase token exchange
- Multi-tenant via organization scoping
- Client portal with approval workflows
- GCP Cloud Run deployment target

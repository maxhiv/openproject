# Control Plane

ISP/MSP & Construction Management platform built with Rails 8 + Angular 21.
Integrates with OpenProject for project management via API.

## Stack

- **Backend**: Ruby 4.0.0, Rails 8.1.2
- **Frontend**: Angular 21
- **Database**: PostgreSQL 16
- **Auth**: Firebase Authentication
- **Integration**: OpenProject API v3

## Quick Start (Replit)

The app runs on Replit with the existing configuration.

```bash
cd control-plane
bundle exec rails db:migrate
bundle exec rails server -b 0.0.0.0 -p 5000
```

## Quick Start (Docker)

```bash
cp .env.example .env
# Edit .env with your Firebase and OpenProject settings
docker compose up -d
docker compose exec control-plane bundle exec rails db:migrate
```

App available at http://localhost:3100

## Frontend Development

```bash
cd frontend
npm install
npm start  # Serves on http://localhost:4200
```

Build for production:
```bash
cd frontend
npm run build  # Outputs to ../public/app/
```

## API Endpoints

### Authentication
- `POST /api/session` - Login with Firebase ID token
- `DELETE /api/session` - Logout
- `GET /api/me` - Current user info

### Organizations
- `GET/POST /api/organizations`
- `GET/PUT /api/organizations/:id`

### Projects (scoped to organization)
- `GET/POST /api/organizations/:org_id/projects`
- `GET/PUT/DELETE /api/organizations/:org_id/projects/:id`

### ISP/MSP
- `GET/POST/PUT/DELETE /api/isp_sites`
- `GET/POST/PUT/DELETE /api/network_assets`
- `GET/POST/PUT/DELETE /api/tickets`
- `GET/POST/PUT/DELETE /api/change_requests`

### Construction
- `GET/POST/PUT/DELETE /api/construction_packages`
- `GET/POST/PUT/DELETE /api/permits`
- `GET/POST/PUT/DELETE /api/procurement_items`

### Client Portal
- `GET /api/portal/projects`
- `GET /api/portal/milestones` + `POST /api/portal/milestones/:id/approve`
- `GET /api/portal/tickets`
- `GET /api/portal/change_requests` + `POST /api/portal/change_requests/:id/approve`

### Webhooks
- `POST /api/webhooks/openproject` - Receive OpenProject events

## Roles

| Role | Description |
|------|-------------|
| superadmin | Full system access |
| org_admin | Organization administrator |
| staff | Internal staff member |
| client_admin | Client organization admin |
| client_user | Client portal user |
| subcontractor | External contractor |
| readonly | View-only access |

## GCP Deployment

See `cloudbuild.yaml` for Cloud Build + Cloud Run pipeline.

### Required Secrets (Secret Manager)
- `control-plane-database-url`
- `control-plane-secret-key`
- `firebase-project-id`
- `openproject-url`
- `openproject-api-token`

### Deploy Commands
```bash
# Create secrets
echo -n "your-db-url" | gcloud secrets create control-plane-database-url --data-file=-
rails secret | gcloud secrets create control-plane-secret-key --data-file=-

# Build and deploy
gcloud builds submit --config=cloudbuild.yaml

# Run migrations job
gcloud run jobs create control-plane-migrate \
  --image=gcr.io/PROJECT/control-plane:latest \
  --command=bundle,exec,rails,db:migrate \
  --set-secrets=DATABASE_URL=control-plane-database-url:latest \
  --region=us-central1
```

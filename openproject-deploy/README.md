# OpenProject Deploy

Vanilla OpenProject deployment for GCP Cloud Run (or GCE fallback).

## Prerequisites

- GCP project with Cloud Run, Cloud SQL, Secret Manager enabled
- Docker installed locally (for testing)
- gcloud CLI authenticated

## Local Development

```bash
cp .env.example .env
docker compose up -d
```

OpenProject will be available at http://localhost:8080
Default login: admin / admin

## Create Integration User

1. Login to OpenProject as admin
2. Go to Administration > Users > Create user
   - Login: integration-bot
   - Email: integration@yourdomain.com
   - Role: Admin (or scoped project admin)
3. Go to My Account > Access Tokens > API
4. Generate a new API token
5. Save the token as `OPENPROJECT_API_TOKEN` secret

## GCP Deployment

### 1. Create Cloud SQL instance
```bash
gcloud sql instances create openproject-db \
  --database-version=POSTGRES_16 \
  --tier=db-f1-micro \
  --region=us-central1

gcloud sql databases create openproject --instance=openproject-db
gcloud sql users set-password postgres --instance=openproject-db --password=YOUR_PASSWORD
```

### 2. Store secrets
```bash
echo -n "postgresql://postgres:YOUR_PASSWORD@/openproject?host=/cloudsql/PROJECT:us-central1:openproject-db" | \
  gcloud secrets create openproject-database-url --data-file=-

openssl rand -hex 64 | gcloud secrets create openproject-secret-key --data-file=-
```

### 3. Deploy
```bash
gcloud builds submit --config=cloudbuild.yaml
```

## GCE Fallback

If Cloud Run is unsuitable (background jobs, long-running processes):

```bash
gcloud compute instances create-with-container openproject-vm \
  --container-image=openproject/openproject:15 \
  --machine-type=e2-medium \
  --zone=us-central1-a \
  --tags=http-server \
  --container-env=DATABASE_URL=your-cloud-sql-url
```

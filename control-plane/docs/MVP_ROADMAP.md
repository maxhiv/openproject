# MVP Roadmap

## Phase 1: MVP (Weeks 1-4)

### Goals
- Working Control Plane with Firebase Auth
- Basic multi-tenant RBAC
- ISP/MSP site + asset management
- OpenProject integration (project creation + sync)
- Deployable to Cloud Run

### Deliverables
- [x] Rails API scaffold with all models/migrations
- [x] Firebase Auth token verification + JIT user provisioning
- [x] Multi-tenant organization + membership system
- [x] ISP site CRUD API
- [x] Network asset inventory API
- [x] Ticket management API (with SLA fields)
- [x] Change request API (with approval workflow)
- [x] Construction package + milestone API
- [x] Permit + procurement tracking API
- [x] OpenProject API client service
- [x] Webhook receiver endpoint
- [x] Angular frontend scaffold (login, dashboard, stub pages)
- [x] Dockerfile + docker-compose for both repos
- [x] Cloud Build + Cloud Run deployment config
- [ ] Frontend: Functional project CRUD page
- [ ] Frontend: Functional site management page
- [ ] Frontend: Functional ticket management page
- [ ] Frontend: Firebase Auth integration (not just dev login)
- [ ] End-to-end OpenProject project sync test

### Key Decisions
- Session cookie auth (not bearer tokens for every request)
- All data scoped by organization server-side
- OpenProject project IDs stored as references, not mirrored data

---

## Phase 2: Internal Beta (Weeks 5-8)

### Goals
- Full CRUD UI for all modules
- Working client portal
- OpenProject webhook processing
- Basic reporting

### Deliverables
- [ ] Complete Angular pages for all ISP/MSP modules
- [ ] Complete Angular pages for construction modules
- [ ] Client portal: project view, milestone approval, ticket view
- [ ] Change request approval workflow (UI + email notifications)
- [ ] OpenProject webhook handling (status sync back to Control Plane)
- [ ] Basic dashboard with real stats
- [ ] Network asset search + filtering
- [ ] Ticket SLA countdown display
- [ ] User management UI (org admin)
- [ ] Audit log viewer

### Infrastructure
- [ ] Cloud SQL setup for both databases
- [ ] Secret Manager for all credentials
- [ ] CI/CD pipeline (GitHub -> Cloud Build -> Cloud Run)
- [ ] Staging environment

---

## Phase 3: Client Share (Weeks 9-12)

### Goals
- Client-ready portal
- Polish UX
- Security hardening
- Documentation

### Deliverables
- [ ] Client portal: polished UI with responsive design
- [ ] Client approval emails + notifications
- [ ] Client user self-registration flow
- [ ] Project sharing (invite clients to specific projects)
- [ ] File attachments (Cloud Storage)
- [ ] Export to PDF/CSV for reports
- [ ] Rate limiting on API
- [ ] Input validation hardening
- [ ] CORS restriction for production
- [ ] Custom domain setup

### Enterprise-like Features (Original Implementations)
- [ ] Portfolio rollup dashboard (aggregate project status across org)
- [ ] Project baseline/snapshot (capture milestone state at point in time)
- [ ] SLA compliance report (tickets resolved within SLA %)
- [ ] Schedule slip report (planned vs actual for milestones)

---

## Phase 4: Hardening (Weeks 13-16)

### Goals
- Production-ready reliability
- Performance optimization
- Advanced features

### Deliverables
- [ ] Background job processing (Solid Queue)
- [ ] Webhook retry + dead letter queue
- [ ] Database connection pooling (PgBouncer)
- [ ] Redis caching for hot data
- [ ] API pagination on all list endpoints
- [ ] Full-text search on tickets + assets
- [ ] Bulk operations (mass update tickets, assets)
- [ ] Import/export for assets (CSV upload)
- [ ] Advanced dashboards (workload heatmap, SLA trends)
- [ ] Custom forms for inspections/change requests
- [ ] Mobile-responsive ticket creation
- [ ] Uptime monitoring integration
- [ ] Automated backup verification

### Operations
- [ ] Health check endpoints
- [ ] Structured logging (JSON)
- [ ] Error tracking (Sentry or equivalent)
- [ ] Performance monitoring
- [ ] Runbook documentation
- [ ] Disaster recovery plan

---

## Architecture Decision Records

### ADR-001: Session Cookies over Bearer Tokens
**Decision**: Use Rails session cookies for auth after initial Firebase token exchange.
**Rationale**: Simpler client-side code, automatic CSRF protection, no token refresh logic in Angular.

### ADR-002: Reference-Only OpenProject Integration
**Decision**: Store only OpenProject IDs (project_id, work_package_id) in Control Plane, not mirror data.
**Rationale**: Avoids sync complexity, OpenProject is source of truth for PM data.

### ADR-003: Cloud Run First, GCE Fallback
**Decision**: Deploy to Cloud Run initially. Switch to GCE if background jobs are problematic.
**Rationale**: Cloud Run is simpler/cheaper for stateless HTTP. OpenProject's worker processes may need always-on compute.

### ADR-004: Separate Databases
**Decision**: Control Plane and OpenProject use separate PostgreSQL databases.
**Rationale**: Clean separation of concerns, independent scaling, no schema conflicts.

### ADR-005: Multi-Tenant via Organization Scoping
**Decision**: All data scoped by organization_id, enforced server-side in BaseController.
**Rationale**: Simpler than schema-per-tenant, good enough for expected tenant count (<1000).

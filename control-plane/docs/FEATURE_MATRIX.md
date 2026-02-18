# Feature Mapping Matrix

## OpenProject Community vs Control Plane Custom vs Recreated (Enterprise-like)

| Category | Feature | OpenProject Community | Control Plane Custom | Recreated (Enterprise-like) |
|----------|---------|----------------------|---------------------|---------------------------|
| **Auth** | User authentication | Basic (email/password) | Firebase Auth (Google + email) | - |
| **Auth** | Multi-tenant RBAC | Single-tenant roles | Multi-org with 7 role levels | - |
| **Auth** | Audit logging | Basic activity log | Full audit trail (login, role changes, exports) | - |
| **Projects** | Project management | Full PM suite | Lightweight project wrapper | - |
| **Projects** | Work packages/tasks | Full CRUD + workflows | References to OP work packages | - |
| **Projects** | Gantt charts | Yes (community) | Via OpenProject deep link | - |
| **Projects** | Agile boards | Yes (community) | Via OpenProject deep link | - |
| **ISP/MSP** | Site management | - | Full CRUD (geo, address, notes) | - |
| **ISP/MSP** | Network asset inventory | - | Full (circuit, switch, AP, OLT, ONT, CPE, camera, NVR) | - |
| **ISP/MSP** | IP pool/VLAN management | - | Full (network, prefix, VLAN ID, purpose) | - |
| **ISP/MSP** | Tickets/incidents | Work packages (generic) | Dedicated (SLA timers, RCA, client visibility) | - |
| **ISP/MSP** | Change requests | - | Full (maintenance windows, approvals, rollback, impact) | - |
| **Construction** | WBS/packages | Work packages | Dedicated construction packages with WBS codes | - |
| **Construction** | Milestones | Milestone work packages | Dedicated with client approval workflow | - |
| **Construction** | Permits/inspections | - | Full checklist-based tracking | - |
| **Construction** | Procurement | - | Full (vendor, lead time, delivery tracking) | - |
| **Client Portal** | Shared project view | Public projects only | Dedicated portal with scoped visibility | - |
| **Client Portal** | Milestone approvals | - | Client approval workflow | - |
| **Client Portal** | Ticket visibility | - | Client-visible flag on tickets | - |
| **Client Portal** | Change request approval | - | Client approval for maintenance windows | - |
| **Enterprise-like** | Portfolio rollups | Enterprise only | - | Custom portfolio dashboard across projects |
| **Enterprise-like** | Baselines/snapshots | Enterprise only | - | Project snapshot system (milestone/schedule capture) |
| **Enterprise-like** | Advanced dashboards | Enterprise only | - | SLA compliance, schedule slip, workload reports |
| **Enterprise-like** | Custom workflows | Enterprise only | - | Change request + inspection workflows |
| **Integration** | OpenProject API | N/A (is OpenProject) | Full API v3 client | - |
| **Integration** | Webhooks | Sends webhooks | Receives + processes OP webhooks | - |
| **Integration** | Project sync | N/A | Create OP projects from Control Plane | - |
| **Integration** | Work package sync | N/A | Create/reference OP work packages | - |

## Key Design Principles

1. **OpenProject stays vanilla** - No forking, no custom plugins
2. **Control Plane is the primary UI** - Clients use Control Plane portal, not OpenProject
3. **Enterprise-like features are original implementations** - Distinct UX from OpenProject Enterprise
4. **Data flows one direction primarily** - Control Plane -> OpenProject for project/WP creation
5. **Webhooks flow back** - OpenProject -> Control Plane for status updates

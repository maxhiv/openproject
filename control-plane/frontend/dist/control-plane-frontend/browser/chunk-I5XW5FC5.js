import {
  HttpClient,
  RouterLink,
  environment
} from "./chunk-V7KC4D6S.js";
import {
  CommonModule,
  Component,
  Injectable,
  setClassMetadata,
  ɵsetClassDebugInfo,
  ɵɵadvance,
  ɵɵdefineComponent,
  ɵɵdefineInjectable,
  ɵɵdirectiveInject,
  ɵɵelementEnd,
  ɵɵelementStart,
  ɵɵinject,
  ɵɵtext,
  ɵɵtextInterpolate
} from "./chunk-F22R2BCX.js";

// src/app/services/api.service.ts
var ApiService = class _ApiService {
  http;
  baseUrl = environment.apiUrl;
  constructor(http) {
    this.http = http;
  }
  get(path, params) {
    return this.http.get(`${this.baseUrl}${path}`, { params, withCredentials: true });
  }
  post(path, body) {
    return this.http.post(`${this.baseUrl}${path}`, body, { withCredentials: true });
  }
  put(path, body) {
    return this.http.put(`${this.baseUrl}${path}`, body, { withCredentials: true });
  }
  patch(path, body) {
    return this.http.patch(`${this.baseUrl}${path}`, body, { withCredentials: true });
  }
  delete(path) {
    return this.http.delete(`${this.baseUrl}${path}`, { withCredentials: true });
  }
  static \u0275fac = function ApiService_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _ApiService)(\u0275\u0275inject(HttpClient));
  };
  static \u0275prov = /* @__PURE__ */ \u0275\u0275defineInjectable({ token: _ApiService, factory: _ApiService.\u0275fac, providedIn: "root" });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(ApiService, [{
    type: Injectable,
    args: [{ providedIn: "root" }]
  }], () => [{ type: HttpClient }], null);
})();

// src/app/pages/dashboard/dashboard.component.ts
var DashboardComponent = class _DashboardComponent {
  api;
  stats = { projects: 0, sites: 0, openTickets: 0, assets: 0 };
  constructor(api) {
    this.api = api;
  }
  ngOnInit() {
    this.loadStats();
  }
  loadStats() {
    this.api.get("/api/organizations").subscribe({
      next: (orgs) => {
        if (orgs.length > 0) {
          const orgId = orgs[0].id;
          this.api.get(`/api/organizations/${orgId}/projects`).subscribe((p) => this.stats.projects = p.length);
        }
      },
      error: () => {
      }
    });
    this.api.get("/api/isp_sites").subscribe({ next: (s) => this.stats.sites = s.length, error: () => {
    } });
    this.api.get("/api/tickets", { status: "open" }).subscribe({ next: (t) => this.stats.openTickets = t.length, error: () => {
    } });
    this.api.get("/api/network_assets").subscribe({ next: (a) => this.stats.assets = a.length, error: () => {
    } });
  }
  static \u0275fac = function DashboardComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _DashboardComponent)(\u0275\u0275directiveInject(ApiService));
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _DashboardComponent, selectors: [["app-dashboard"]], decls: 36, vars: 4, consts: [[1, "dashboard"], [1, "stats-grid"], [1, "card", "stat-card"], [1, "stat-value"], [1, "stat-label"], [1, "quick-actions"], [1, "actions-grid"], ["routerLink", "/projects", 1, "card", "action-card"], ["routerLink", "/tickets", 1, "card", "action-card"], ["routerLink", "/sites", 1, "card", "action-card"], ["routerLink", "/construction", 1, "card", "action-card"]], template: function DashboardComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275elementStart(0, "div", 0)(1, "h1");
      \u0275\u0275text(2, "Dashboard");
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(3, "div", 1)(4, "div", 2)(5, "div", 3);
      \u0275\u0275text(6);
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(7, "div", 4);
      \u0275\u0275text(8, "Projects");
      \u0275\u0275elementEnd()();
      \u0275\u0275elementStart(9, "div", 2)(10, "div", 3);
      \u0275\u0275text(11);
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(12, "div", 4);
      \u0275\u0275text(13, "Sites");
      \u0275\u0275elementEnd()();
      \u0275\u0275elementStart(14, "div", 2)(15, "div", 3);
      \u0275\u0275text(16);
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(17, "div", 4);
      \u0275\u0275text(18, "Open Tickets");
      \u0275\u0275elementEnd()();
      \u0275\u0275elementStart(19, "div", 2)(20, "div", 3);
      \u0275\u0275text(21);
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(22, "div", 4);
      \u0275\u0275text(23, "Network Assets");
      \u0275\u0275elementEnd()()();
      \u0275\u0275elementStart(24, "div", 5)(25, "h2");
      \u0275\u0275text(26, "Quick Actions");
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(27, "div", 6)(28, "a", 7);
      \u0275\u0275text(29, "Create Project");
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(30, "a", 8);
      \u0275\u0275text(31, "New Ticket");
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(32, "a", 9);
      \u0275\u0275text(33, "Add Site");
      \u0275\u0275elementEnd();
      \u0275\u0275elementStart(34, "a", 10);
      \u0275\u0275text(35, "Construction");
      \u0275\u0275elementEnd()()()();
    }
    if (rf & 2) {
      \u0275\u0275advance(6);
      \u0275\u0275textInterpolate(ctx.stats.projects);
      \u0275\u0275advance(5);
      \u0275\u0275textInterpolate(ctx.stats.sites);
      \u0275\u0275advance(5);
      \u0275\u0275textInterpolate(ctx.stats.openTickets);
      \u0275\u0275advance(5);
      \u0275\u0275textInterpolate(ctx.stats.assets);
    }
  }, dependencies: [CommonModule, RouterLink], styles: ["\n\nh1[_ngcontent-%COMP%] {\n  margin-bottom: 24px;\n}\n.stats-grid[_ngcontent-%COMP%] {\n  display: grid;\n  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));\n  gap: 16px;\n  margin-bottom: 32px;\n}\n.stat-card[_ngcontent-%COMP%] {\n  text-align: center;\n}\n.stat-value[_ngcontent-%COMP%] {\n  font-size: 36px;\n  font-weight: 700;\n  color: var(--primary);\n}\n.stat-label[_ngcontent-%COMP%] {\n  font-size: 14px;\n  color: var(--text-secondary);\n  margin-top: 4px;\n}\n.quick-actions[_ngcontent-%COMP%]   h2[_ngcontent-%COMP%] {\n  margin-bottom: 16px;\n}\n.actions-grid[_ngcontent-%COMP%] {\n  display: grid;\n  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));\n  gap: 12px;\n}\n.action-card[_ngcontent-%COMP%] {\n  text-align: center;\n  font-weight: 500;\n  color: var(--primary);\n  cursor: pointer;\n  transition: transform 0.1s;\n}\n.action-card[_ngcontent-%COMP%]:hover {\n  transform: translateY(-2px);\n  text-decoration: none;\n  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);\n}\n/*# sourceMappingURL=dashboard.component.css.map */"] });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(DashboardComponent, [{
    type: Component,
    args: [{ selector: "app-dashboard", standalone: true, imports: [CommonModule, RouterLink], template: `
    <div class="dashboard">
      <h1>Dashboard</h1>
      <div class="stats-grid">
        <div class="card stat-card">
          <div class="stat-value">{{ stats.projects }}</div>
          <div class="stat-label">Projects</div>
        </div>
        <div class="card stat-card">
          <div class="stat-value">{{ stats.sites }}</div>
          <div class="stat-label">Sites</div>
        </div>
        <div class="card stat-card">
          <div class="stat-value">{{ stats.openTickets }}</div>
          <div class="stat-label">Open Tickets</div>
        </div>
        <div class="card stat-card">
          <div class="stat-value">{{ stats.assets }}</div>
          <div class="stat-label">Network Assets</div>
        </div>
      </div>

      <div class="quick-actions">
        <h2>Quick Actions</h2>
        <div class="actions-grid">
          <a routerLink="/projects" class="card action-card">Create Project</a>
          <a routerLink="/tickets" class="card action-card">New Ticket</a>
          <a routerLink="/sites" class="card action-card">Add Site</a>
          <a routerLink="/construction" class="card action-card">Construction</a>
        </div>
      </div>
    </div>
  `, styles: ["/* angular:styles/component:css;06a2feab838af6af6cb5b80e08c425f3bf445a618edfbc4653cce69331ec46c7;/home/runner/workspace/control-plane/frontend/src/app/pages/dashboard/dashboard.component.ts */\nh1 {\n  margin-bottom: 24px;\n}\n.stats-grid {\n  display: grid;\n  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));\n  gap: 16px;\n  margin-bottom: 32px;\n}\n.stat-card {\n  text-align: center;\n}\n.stat-value {\n  font-size: 36px;\n  font-weight: 700;\n  color: var(--primary);\n}\n.stat-label {\n  font-size: 14px;\n  color: var(--text-secondary);\n  margin-top: 4px;\n}\n.quick-actions h2 {\n  margin-bottom: 16px;\n}\n.actions-grid {\n  display: grid;\n  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));\n  gap: 12px;\n}\n.action-card {\n  text-align: center;\n  font-weight: 500;\n  color: var(--primary);\n  cursor: pointer;\n  transition: transform 0.1s;\n}\n.action-card:hover {\n  transform: translateY(-2px);\n  text-decoration: none;\n  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);\n}\n/*# sourceMappingURL=dashboard.component.css.map */\n"] }]
  }], () => [{ type: ApiService }], null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(DashboardComponent, { className: "DashboardComponent", filePath: "src/app/pages/dashboard/dashboard.component.ts", lineNumber: 55 });
})();
export {
  DashboardComponent
};
//# sourceMappingURL=chunk-I5XW5FC5.js.map

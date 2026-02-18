import {
  AuthService
} from "./chunk-YO7BNKQC.js";
import {
  RouterLink,
  RouterLinkActive,
  RouterOutlet,
  bootstrapApplication,
  provideHttpClient,
  provideRouter,
  withInterceptorsFromDi
} from "./chunk-V7KC4D6S.js";
import {
  CommonModule,
  Component,
  NgIf,
  provideZoneChangeDetection,
  setClassMetadata,
  ɵsetClassDebugInfo,
  ɵɵadvance,
  ɵɵdefineComponent,
  ɵɵdirectiveInject,
  ɵɵelement,
  ɵɵelementEnd,
  ɵɵelementStart,
  ɵɵgetCurrentView,
  ɵɵlistener,
  ɵɵnextContext,
  ɵɵproperty,
  ɵɵreference,
  ɵɵresetView,
  ɵɵrestoreView,
  ɵɵtemplate,
  ɵɵtemplateRefExtractor,
  ɵɵtext,
  ɵɵtextInterpolate
} from "./chunk-F22R2BCX.js";

// src/app/app.component.ts
function AppComponent_div_0_Template(rf, ctx) {
  if (rf & 1) {
    const _r1 = \u0275\u0275getCurrentView();
    \u0275\u0275elementStart(0, "div", 2)(1, "nav", 3)(2, "div", 4)(3, "h2");
    \u0275\u0275text(4, "Control Plane");
    \u0275\u0275elementEnd()();
    \u0275\u0275elementStart(5, "ul", 5)(6, "li")(7, "a", 6);
    \u0275\u0275text(8, "Dashboard");
    \u0275\u0275elementEnd()();
    \u0275\u0275elementStart(9, "li")(10, "a", 7);
    \u0275\u0275text(11, "Projects");
    \u0275\u0275elementEnd()();
    \u0275\u0275elementStart(12, "li")(13, "a", 8);
    \u0275\u0275text(14, "Sites");
    \u0275\u0275elementEnd()();
    \u0275\u0275elementStart(15, "li")(16, "a", 9);
    \u0275\u0275text(17, "Network Assets");
    \u0275\u0275elementEnd()();
    \u0275\u0275elementStart(18, "li")(19, "a", 10);
    \u0275\u0275text(20, "Tickets");
    \u0275\u0275elementEnd()();
    \u0275\u0275elementStart(21, "li")(22, "a", 11);
    \u0275\u0275text(23, "Construction");
    \u0275\u0275elementEnd()();
    \u0275\u0275element(24, "li", 12);
    \u0275\u0275elementStart(25, "li")(26, "a", 13);
    \u0275\u0275text(27, "Client Portal");
    \u0275\u0275elementEnd()()();
    \u0275\u0275elementStart(28, "div", 14)(29, "div", 15);
    \u0275\u0275text(30);
    \u0275\u0275elementEnd();
    \u0275\u0275elementStart(31, "button", 16);
    \u0275\u0275listener("click", function AppComponent_div_0_Template_button_click_31_listener() {
      \u0275\u0275restoreView(_r1);
      const ctx_r1 = \u0275\u0275nextContext();
      return \u0275\u0275resetView(ctx_r1.auth.logout());
    });
    \u0275\u0275text(32, "Sign Out");
    \u0275\u0275elementEnd()()();
    \u0275\u0275elementStart(33, "main", 17);
    \u0275\u0275element(34, "router-outlet");
    \u0275\u0275elementEnd()();
  }
  if (rf & 2) {
    let tmp_2_0;
    const ctx_r1 = \u0275\u0275nextContext();
    \u0275\u0275advance(30);
    \u0275\u0275textInterpolate((tmp_2_0 = ctx_r1.auth.currentUser()) == null ? null : tmp_2_0.email);
  }
}
function AppComponent_ng_template_1_Template(rf, ctx) {
  if (rf & 1) {
    \u0275\u0275element(0, "router-outlet");
  }
}
var AppComponent = class _AppComponent {
  auth;
  constructor(auth) {
    this.auth = auth;
  }
  static \u0275fac = function AppComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _AppComponent)(\u0275\u0275directiveInject(AuthService));
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _AppComponent, selectors: [["app-root"]], decls: 3, vars: 2, consts: [["loginView", ""], ["class", "app-layout", 4, "ngIf", "ngIfElse"], [1, "app-layout"], [1, "sidebar"], [1, "sidebar-header"], [1, "nav-links"], ["routerLink", "/dashboard", "routerLinkActive", "active"], ["routerLink", "/projects", "routerLinkActive", "active"], ["routerLink", "/sites", "routerLinkActive", "active"], ["routerLink", "/assets", "routerLinkActive", "active"], ["routerLink", "/tickets", "routerLinkActive", "active"], ["routerLink", "/construction", "routerLinkActive", "active"], [1, "nav-divider"], ["routerLink", "/portal", "routerLinkActive", "active"], [1, "sidebar-footer"], [1, "user-info"], [1, "btn", "btn-secondary", 3, "click"], [1, "main-content"]], template: function AppComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275template(0, AppComponent_div_0_Template, 35, 1, "div", 1)(1, AppComponent_ng_template_1_Template, 1, 0, "ng-template", null, 0, \u0275\u0275templateRefExtractor);
    }
    if (rf & 2) {
      const loginView_r3 = \u0275\u0275reference(2);
      \u0275\u0275property("ngIf", ctx.auth.isLoggedIn())("ngIfElse", loginView_r3);
    }
  }, dependencies: [CommonModule, NgIf, RouterOutlet, RouterLink, RouterLinkActive], styles: ["\n\n.app-layout[_ngcontent-%COMP%] {\n  display: flex;\n  min-height: 100vh;\n}\n.sidebar[_ngcontent-%COMP%] {\n  width: var(--sidebar-width);\n  background: #1a1a2e;\n  color: white;\n  display: flex;\n  flex-direction: column;\n  position: fixed;\n  height: 100vh;\n}\n.sidebar-header[_ngcontent-%COMP%] {\n  padding: 20px;\n  border-bottom: 1px solid rgba(255, 255, 255, 0.1);\n}\n.sidebar-header[_ngcontent-%COMP%]   h2[_ngcontent-%COMP%] {\n  font-size: 18px;\n  font-weight: 600;\n}\n.nav-links[_ngcontent-%COMP%] {\n  list-style: none;\n  padding: 12px 0;\n  flex: 1;\n}\n.nav-links[_ngcontent-%COMP%]   li[_ngcontent-%COMP%]   a[_ngcontent-%COMP%] {\n  display: block;\n  padding: 10px 20px;\n  color: rgba(255, 255, 255, 0.7);\n  font-size: 14px;\n  transition: all 0.15s;\n}\n.nav-links[_ngcontent-%COMP%]   li[_ngcontent-%COMP%]   a[_ngcontent-%COMP%]:hover, \n.nav-links[_ngcontent-%COMP%]   li[_ngcontent-%COMP%]   a.active[_ngcontent-%COMP%] {\n  color: white;\n  background: rgba(255, 255, 255, 0.1);\n  text-decoration: none;\n}\n.nav-divider[_ngcontent-%COMP%] {\n  height: 1px;\n  background: rgba(255, 255, 255, 0.1);\n  margin: 8px 20px;\n}\n.sidebar-footer[_ngcontent-%COMP%] {\n  padding: 16px 20px;\n  border-top: 1px solid rgba(255, 255, 255, 0.1);\n}\n.user-info[_ngcontent-%COMP%] {\n  font-size: 13px;\n  color: rgba(255, 255, 255, 0.6);\n  margin-bottom: 8px;\n  overflow: hidden;\n  text-overflow: ellipsis;\n}\n.main-content[_ngcontent-%COMP%] {\n  flex: 1;\n  margin-left: var(--sidebar-width);\n  padding: 24px;\n}\n/*# sourceMappingURL=app.component.css.map */"] });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(AppComponent, [{
    type: Component,
    args: [{ selector: "app-root", standalone: true, imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive], template: `
    <div class="app-layout" *ngIf="auth.isLoggedIn(); else loginView">
      <nav class="sidebar">
        <div class="sidebar-header">
          <h2>Control Plane</h2>
        </div>
        <ul class="nav-links">
          <li><a routerLink="/dashboard" routerLinkActive="active">Dashboard</a></li>
          <li><a routerLink="/projects" routerLinkActive="active">Projects</a></li>
          <li><a routerLink="/sites" routerLinkActive="active">Sites</a></li>
          <li><a routerLink="/assets" routerLinkActive="active">Network Assets</a></li>
          <li><a routerLink="/tickets" routerLinkActive="active">Tickets</a></li>
          <li><a routerLink="/construction" routerLinkActive="active">Construction</a></li>
          <li class="nav-divider"></li>
          <li><a routerLink="/portal" routerLinkActive="active">Client Portal</a></li>
        </ul>
        <div class="sidebar-footer">
          <div class="user-info">{{ auth.currentUser()?.email }}</div>
          <button class="btn btn-secondary" (click)="auth.logout()">Sign Out</button>
        </div>
      </nav>
      <main class="main-content">
        <router-outlet></router-outlet>
      </main>
    </div>
    <ng-template #loginView>
      <router-outlet></router-outlet>
    </ng-template>
  `, styles: ["/* angular:styles/component:css;676e233cb1ae52f94cb85fb10aec0b23677123479e852680452f3d6604b94ee7;/home/runner/workspace/control-plane/frontend/src/app/app.component.ts */\n.app-layout {\n  display: flex;\n  min-height: 100vh;\n}\n.sidebar {\n  width: var(--sidebar-width);\n  background: #1a1a2e;\n  color: white;\n  display: flex;\n  flex-direction: column;\n  position: fixed;\n  height: 100vh;\n}\n.sidebar-header {\n  padding: 20px;\n  border-bottom: 1px solid rgba(255, 255, 255, 0.1);\n}\n.sidebar-header h2 {\n  font-size: 18px;\n  font-weight: 600;\n}\n.nav-links {\n  list-style: none;\n  padding: 12px 0;\n  flex: 1;\n}\n.nav-links li a {\n  display: block;\n  padding: 10px 20px;\n  color: rgba(255, 255, 255, 0.7);\n  font-size: 14px;\n  transition: all 0.15s;\n}\n.nav-links li a:hover,\n.nav-links li a.active {\n  color: white;\n  background: rgba(255, 255, 255, 0.1);\n  text-decoration: none;\n}\n.nav-divider {\n  height: 1px;\n  background: rgba(255, 255, 255, 0.1);\n  margin: 8px 20px;\n}\n.sidebar-footer {\n  padding: 16px 20px;\n  border-top: 1px solid rgba(255, 255, 255, 0.1);\n}\n.user-info {\n  font-size: 13px;\n  color: rgba(255, 255, 255, 0.6);\n  margin-bottom: 8px;\n  overflow: hidden;\n  text-overflow: ellipsis;\n}\n.main-content {\n  flex: 1;\n  margin-left: var(--sidebar-width);\n  padding: 24px;\n}\n/*# sourceMappingURL=app.component.css.map */\n"] }]
  }], () => [{ type: AuthService }], null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(AppComponent, { className: "AppComponent", filePath: "src/app/app.component.ts", lineNumber: 61 });
})();

// src/app/app.routes.ts
var routes = [
  { path: "", redirectTo: "dashboard", pathMatch: "full" },
  { path: "login", loadComponent: () => import("./chunk-XHDFJ732.js").then((m) => m.LoginComponent) },
  { path: "dashboard", loadComponent: () => import("./chunk-I5XW5FC5.js").then((m) => m.DashboardComponent) },
  { path: "projects", loadComponent: () => import("./chunk-OADY73O4.js").then((m) => m.ProjectsComponent) },
  { path: "sites", loadComponent: () => import("./chunk-HR3735SM.js").then((m) => m.SitesComponent) },
  { path: "tickets", loadComponent: () => import("./chunk-MFB6HETK.js").then((m) => m.TicketsComponent) },
  { path: "assets", loadComponent: () => import("./chunk-O2Q6LITF.js").then((m) => m.NetworkAssetsComponent) },
  { path: "construction", loadComponent: () => import("./chunk-7PAEEZNM.js").then((m) => m.ConstructionComponent) },
  { path: "portal", loadComponent: () => import("./chunk-N3K6UPQX.js").then((m) => m.PortalComponent) },
  { path: "**", redirectTo: "dashboard" }
];

// src/app/app.config.ts
var appConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes),
    provideHttpClient(withInterceptorsFromDi())
  ]
};

// src/main.ts
bootstrapApplication(AppComponent, appConfig).catch((err) => console.error(err));
//# sourceMappingURL=main.js.map

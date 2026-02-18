import {
  CommonModule,
  Component,
  setClassMetadata,
  ɵsetClassDebugInfo,
  ɵɵdefineComponent,
  ɵɵdomElementEnd,
  ɵɵdomElementStart,
  ɵɵtext
} from "./chunk-F22R2BCX.js";

// src/app/pages/projects/projects.component.ts
var ProjectsComponent = class _ProjectsComponent {
  static \u0275fac = function ProjectsComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _ProjectsComponent)();
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _ProjectsComponent, selectors: [["app-projects"]], decls: 5, vars: 0, template: function ProjectsComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275domElementStart(0, "div")(1, "h1");
      \u0275\u0275text(2, "Projects");
      \u0275\u0275domElementEnd();
      \u0275\u0275domElementStart(3, "p");
      \u0275\u0275text(4, "Project management coming soon.");
      \u0275\u0275domElementEnd()();
    }
  }, dependencies: [CommonModule], encapsulation: 2 });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(ProjectsComponent, [{
    type: Component,
    args: [{
      selector: "app-projects",
      standalone: true,
      imports: [CommonModule],
      template: `<div><h1>Projects</h1><p>Project management coming soon.</p></div>`
    }]
  }], null, null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(ProjectsComponent, { className: "ProjectsComponent", filePath: "src/app/pages/projects/projects.component.ts", lineNumber: 10 });
})();
export {
  ProjectsComponent
};
//# sourceMappingURL=chunk-OADY73O4.js.map

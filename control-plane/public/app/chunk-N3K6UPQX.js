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

// src/app/pages/portal/portal.component.ts
var PortalComponent = class _PortalComponent {
  static \u0275fac = function PortalComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _PortalComponent)();
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _PortalComponent, selectors: [["app-portal"]], decls: 5, vars: 0, template: function PortalComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275domElementStart(0, "div")(1, "h1");
      \u0275\u0275text(2, "Client Portal");
      \u0275\u0275domElementEnd();
      \u0275\u0275domElementStart(3, "p");
      \u0275\u0275text(4, "Client portal view coming soon.");
      \u0275\u0275domElementEnd()();
    }
  }, dependencies: [CommonModule], encapsulation: 2 });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(PortalComponent, [{
    type: Component,
    args: [{
      selector: "app-portal",
      standalone: true,
      imports: [CommonModule],
      template: `<div><h1>Client Portal</h1><p>Client portal view coming soon.</p></div>`
    }]
  }], null, null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(PortalComponent, { className: "PortalComponent", filePath: "src/app/pages/portal/portal.component.ts", lineNumber: 10 });
})();
export {
  PortalComponent
};
//# sourceMappingURL=chunk-N3K6UPQX.js.map

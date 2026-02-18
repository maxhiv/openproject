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

// src/app/pages/sites/sites.component.ts
var SitesComponent = class _SitesComponent {
  static \u0275fac = function SitesComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _SitesComponent)();
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _SitesComponent, selectors: [["app-sites"]], decls: 5, vars: 0, template: function SitesComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275domElementStart(0, "div")(1, "h1");
      \u0275\u0275text(2, "Sites");
      \u0275\u0275domElementEnd();
      \u0275\u0275domElementStart(3, "p");
      \u0275\u0275text(4, "ISP/MSP site management coming soon.");
      \u0275\u0275domElementEnd()();
    }
  }, dependencies: [CommonModule], encapsulation: 2 });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(SitesComponent, [{
    type: Component,
    args: [{
      selector: "app-sites",
      standalone: true,
      imports: [CommonModule],
      template: `<div><h1>Sites</h1><p>ISP/MSP site management coming soon.</p></div>`
    }]
  }], null, null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(SitesComponent, { className: "SitesComponent", filePath: "src/app/pages/sites/sites.component.ts", lineNumber: 10 });
})();
export {
  SitesComponent
};
//# sourceMappingURL=chunk-HR3735SM.js.map

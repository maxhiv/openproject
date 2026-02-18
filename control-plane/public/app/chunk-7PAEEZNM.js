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

// src/app/pages/construction/construction.component.ts
var ConstructionComponent = class _ConstructionComponent {
  static \u0275fac = function ConstructionComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _ConstructionComponent)();
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _ConstructionComponent, selectors: [["app-construction"]], decls: 5, vars: 0, template: function ConstructionComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275domElementStart(0, "div")(1, "h1");
      \u0275\u0275text(2, "Construction");
      \u0275\u0275domElementEnd();
      \u0275\u0275domElementStart(3, "p");
      \u0275\u0275text(4, "Construction management coming soon.");
      \u0275\u0275domElementEnd()();
    }
  }, dependencies: [CommonModule], encapsulation: 2 });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(ConstructionComponent, [{
    type: Component,
    args: [{
      selector: "app-construction",
      standalone: true,
      imports: [CommonModule],
      template: `<div><h1>Construction</h1><p>Construction management coming soon.</p></div>`
    }]
  }], null, null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(ConstructionComponent, { className: "ConstructionComponent", filePath: "src/app/pages/construction/construction.component.ts", lineNumber: 10 });
})();
export {
  ConstructionComponent
};
//# sourceMappingURL=chunk-7PAEEZNM.js.map

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

// src/app/pages/network-assets/network-assets.component.ts
var NetworkAssetsComponent = class _NetworkAssetsComponent {
  static \u0275fac = function NetworkAssetsComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _NetworkAssetsComponent)();
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _NetworkAssetsComponent, selectors: [["app-network-assets"]], decls: 5, vars: 0, template: function NetworkAssetsComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275domElementStart(0, "div")(1, "h1");
      \u0275\u0275text(2, "Network Assets");
      \u0275\u0275domElementEnd();
      \u0275\u0275domElementStart(3, "p");
      \u0275\u0275text(4, "Network asset inventory coming soon.");
      \u0275\u0275domElementEnd()();
    }
  }, dependencies: [CommonModule], encapsulation: 2 });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(NetworkAssetsComponent, [{
    type: Component,
    args: [{
      selector: "app-network-assets",
      standalone: true,
      imports: [CommonModule],
      template: `<div><h1>Network Assets</h1><p>Network asset inventory coming soon.</p></div>`
    }]
  }], null, null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(NetworkAssetsComponent, { className: "NetworkAssetsComponent", filePath: "src/app/pages/network-assets/network-assets.component.ts", lineNumber: 10 });
})();
export {
  NetworkAssetsComponent
};
//# sourceMappingURL=chunk-O2Q6LITF.js.map

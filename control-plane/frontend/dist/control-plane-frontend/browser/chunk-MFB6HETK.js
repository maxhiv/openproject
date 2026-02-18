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

// src/app/pages/tickets/tickets.component.ts
var TicketsComponent = class _TicketsComponent {
  static \u0275fac = function TicketsComponent_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _TicketsComponent)();
  };
  static \u0275cmp = /* @__PURE__ */ \u0275\u0275defineComponent({ type: _TicketsComponent, selectors: [["app-tickets"]], decls: 5, vars: 0, template: function TicketsComponent_Template(rf, ctx) {
    if (rf & 1) {
      \u0275\u0275domElementStart(0, "div")(1, "h1");
      \u0275\u0275text(2, "Tickets");
      \u0275\u0275domElementEnd();
      \u0275\u0275domElementStart(3, "p");
      \u0275\u0275text(4, "Ticket management coming soon.");
      \u0275\u0275domElementEnd()();
    }
  }, dependencies: [CommonModule], encapsulation: 2 });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(TicketsComponent, [{
    type: Component,
    args: [{
      selector: "app-tickets",
      standalone: true,
      imports: [CommonModule],
      template: `<div><h1>Tickets</h1><p>Ticket management coming soon.</p></div>`
    }]
  }], null, null);
})();
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && \u0275setClassDebugInfo(TicketsComponent, { className: "TicketsComponent", filePath: "src/app/pages/tickets/tickets.component.ts", lineNumber: 10 });
})();
export {
  TicketsComponent
};
//# sourceMappingURL=chunk-MFB6HETK.js.map

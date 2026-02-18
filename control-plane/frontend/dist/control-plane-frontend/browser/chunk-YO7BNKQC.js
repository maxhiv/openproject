import {
  HttpClient,
  Router,
  environment
} from "./chunk-V7KC4D6S.js";
import {
  Injectable,
  __async,
  setClassMetadata,
  signal,
  ɵɵdefineInjectable,
  ɵɵinject
} from "./chunk-F22R2BCX.js";

// src/app/services/auth.service.ts
var AuthService = class _AuthService {
  http;
  router;
  currentUser = signal(null, ...ngDevMode ? [{ debugName: "currentUser" }] : []);
  _isLoggedIn = signal(false, ...ngDevMode ? [{ debugName: "_isLoggedIn" }] : []);
  constructor(http, router) {
    this.http = http;
    this.router = router;
    this.checkSession();
  }
  isLoggedIn() {
    return this._isLoggedIn();
  }
  loginWithFirebase(idToken) {
    return __async(this, null, function* () {
      try {
        const res = yield this.http.post(`${environment.apiUrl}/api/session`, {}, { headers: { Authorization: `Bearer ${idToken}` }, withCredentials: true }).toPromise();
        if (res?.user) {
          this.currentUser.set(res.user);
          this._isLoggedIn.set(true);
          this.router.navigate(["/dashboard"]);
        }
      } catch (err) {
        console.error("Login failed", err);
        throw err;
      }
    });
  }
  checkSession() {
    return __async(this, null, function* () {
      try {
        const res = yield this.http.get(`${environment.apiUrl}/api/me`, { withCredentials: true }).toPromise();
        if (res?.user) {
          this.currentUser.set(res.user);
          this._isLoggedIn.set(true);
        }
      } catch (e) {
        this._isLoggedIn.set(false);
      }
    });
  }
  logout() {
    return __async(this, null, function* () {
      try {
        yield this.http.delete(`${environment.apiUrl}/api/session`, { withCredentials: true }).toPromise();
      } catch (e) {
      }
      this.currentUser.set(null);
      this._isLoggedIn.set(false);
      this.router.navigate(["/login"]);
    });
  }
  static \u0275fac = function AuthService_Factory(__ngFactoryType__) {
    return new (__ngFactoryType__ || _AuthService)(\u0275\u0275inject(HttpClient), \u0275\u0275inject(Router));
  };
  static \u0275prov = /* @__PURE__ */ \u0275\u0275defineInjectable({ token: _AuthService, factory: _AuthService.\u0275fac, providedIn: "root" });
};
(() => {
  (typeof ngDevMode === "undefined" || ngDevMode) && setClassMetadata(AuthService, [{
    type: Injectable,
    args: [{ providedIn: "root" }]
  }], () => [{ type: HttpClient }, { type: Router }], null);
})();

export {
  AuthService
};
//# sourceMappingURL=chunk-YO7BNKQC.js.map

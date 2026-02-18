import { Injectable, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from '@env/environment';

export interface UserInfo {
  id: number;
  email: string;
  display_name: string;
  avatar_url: string | null;
  superadmin: boolean;
  memberships: { organization_id: number; organization_name: string; role: string }[];
}

@Injectable({ providedIn: 'root' })
export class AuthService {
  currentUser = signal<UserInfo | null>(null);
  private _isLoggedIn = signal(false);

  constructor(private http: HttpClient, private router: Router) {
    this.checkSession();
  }

  isLoggedIn() { return this._isLoggedIn(); }

  async loginWithFirebase(idToken: string): Promise<void> {
    try {
      const res = await this.http.post<{ user: UserInfo }>(
        `${environment.apiUrl}/api/session`,
        {},
        { headers: { Authorization: `Bearer ${idToken}` }, withCredentials: true }
      ).toPromise();
      if (res?.user) {
        this.currentUser.set(res.user);
        this._isLoggedIn.set(true);
        this.router.navigate(['/dashboard']);
      }
    } catch (err) {
      console.error('Login failed', err);
      throw err;
    }
  }

  async checkSession(): Promise<void> {
    try {
      const res = await this.http.get<{ user: UserInfo }>(
        `${environment.apiUrl}/api/me`,
        { withCredentials: true }
      ).toPromise();
      if (res?.user) {
        this.currentUser.set(res.user);
        this._isLoggedIn.set(true);
      }
    } catch {
      this._isLoggedIn.set(false);
    }
  }

  async logout(): Promise<void> {
    try {
      await this.http.delete(`${environment.apiUrl}/api/session`, { withCredentials: true }).toPromise();
    } catch {}
    this.currentUser.set(null);
    this._isLoggedIn.set(false);
    this.router.navigate(['/login']);
  }
}

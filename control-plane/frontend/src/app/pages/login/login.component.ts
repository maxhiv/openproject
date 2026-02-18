import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="login-container">
      <div class="login-card card">
        <h1>Control Plane</h1>
        <p class="subtitle">ISP/MSP & Construction Management</p>

        <div class="login-info">
          <p>Sign in with Firebase Authentication</p>
          <p class="hint">Configure FIREBASE_PROJECT_ID to enable login.</p>
        </div>

        <div class="dev-login" *ngIf="!isProduction">
          <h3>Development Login</h3>
          <div class="form-group">
            <label>Email</label>
            <input type="email" [(ngModel)]="devEmail" placeholder="admin@example.com">
          </div>
          <button class="btn btn-primary" (click)="devLogin()" [disabled]="loading">
            {{ loading ? 'Signing in...' : 'Dev Sign In' }}
          </button>
          <p class="error" *ngIf="error">{{ error }}</p>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .login-container {
      display: flex; align-items: center; justify-content: center;
      min-height: 100vh; background: var(--bg);
    }
    .login-card { max-width: 400px; width: 100%; text-align: center; }
    .login-card h1 { font-size: 28px; margin-bottom: 4px; }
    .subtitle { color: var(--text-secondary); margin-bottom: 24px; }
    .login-info { margin: 20px 0; padding: 16px; background: #f1f3f4; border-radius: 8px; }
    .hint { font-size: 13px; color: var(--text-secondary); margin-top: 8px; }
    .dev-login { margin-top: 24px; padding-top: 24px; border-top: 1px solid var(--border); text-align: left; }
    .dev-login h3 { font-size: 16px; margin-bottom: 12px; }
    .error { color: var(--danger); font-size: 13px; margin-top: 8px; }
    button { width: 100%; justify-content: center; }
  `]
})
export class LoginComponent {
  devEmail = 'admin@example.com';
  loading = false;
  error = '';
  isProduction = false;

  constructor(private auth: AuthService) {}

  async devLogin() {
    this.loading = true;
    this.error = '';
    try {
      await this.auth.loginWithFirebase('dev-token-' + this.devEmail);
    } catch (e: any) {
      this.error = e?.error?.error || 'Login failed';
    }
    this.loading = false;
  }
}

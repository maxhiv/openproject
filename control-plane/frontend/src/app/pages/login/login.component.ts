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

        <div class="dev-login">
          <h3>Sign In</h3>
          <div class="form-group">
            <label>Email</label>
            <input type="email" [(ngModel)]="devEmail" placeholder="admin@example.com">
          </div>
          <button class="btn btn-primary" (click)="devLogin()" [disabled]="loading">
            {{ loading ? 'Signing in...' : 'Sign In' }}
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
    .dev-login { margin-top: 24px; text-align: left; }
    .dev-login h3 { font-size: 16px; margin-bottom: 12px; text-align: center; }
    .error { color: var(--danger); font-size: 13px; margin-top: 8px; }
    button { width: 100%; justify-content: center; }
  `]
})
export class LoginComponent {
  devEmail = 'admin@example.com';
  loading = false;
  error = '';

  constructor(private auth: AuthService) {}

  async devLogin() {
    this.loading = true;
    this.error = '';
    try {
      await this.auth.devLogin(this.devEmail);
    } catch (e: any) {
      this.error = e?.error?.error || 'Login failed. Please try again.';
    }
    this.loading = false;
  }
}

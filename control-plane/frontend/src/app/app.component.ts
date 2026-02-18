import { Component } from '@angular/core';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';
import { AuthService } from './services/auth.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive],
  template: `
    <div class="app-layout" *ngIf="auth.isLoggedIn(); else loginView">
      <nav class="sidebar">
        <div class="sidebar-header">
          <h2>Control Plane</h2>
        </div>
        <ul class="nav-links">
          <li><a routerLink="/dashboard" routerLinkActive="active">Dashboard</a></li>
          <li><a routerLink="/projects" routerLinkActive="active">Projects</a></li>
          <li><a routerLink="/sites" routerLinkActive="active">Sites</a></li>
          <li><a routerLink="/assets" routerLinkActive="active">Network Assets</a></li>
          <li><a routerLink="/tickets" routerLinkActive="active">Tickets</a></li>
          <li><a routerLink="/construction" routerLinkActive="active">Construction</a></li>
          <li class="nav-divider"></li>
          <li><a routerLink="/portal" routerLinkActive="active">Client Portal</a></li>
        </ul>
        <div class="sidebar-footer">
          <div class="user-info">{{ auth.currentUser()?.email }}</div>
          <button class="btn btn-secondary" (click)="auth.logout()">Sign Out</button>
        </div>
      </nav>
      <main class="main-content">
        <router-outlet></router-outlet>
      </main>
    </div>
    <ng-template #loginView>
      <router-outlet></router-outlet>
    </ng-template>
  `,
  styles: [`
    .app-layout { display: flex; min-height: 100vh; }
    .sidebar {
      width: var(--sidebar-width); background: #1a1a2e; color: white;
      display: flex; flex-direction: column; position: fixed; height: 100vh;
    }
    .sidebar-header { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
    .sidebar-header h2 { font-size: 18px; font-weight: 600; }
    .nav-links { list-style: none; padding: 12px 0; flex: 1; }
    .nav-links li a {
      display: block; padding: 10px 20px; color: rgba(255,255,255,0.7);
      font-size: 14px; transition: all 0.15s;
    }
    .nav-links li a:hover, .nav-links li a.active {
      color: white; background: rgba(255,255,255,0.1); text-decoration: none;
    }
    .nav-divider { height: 1px; background: rgba(255,255,255,0.1); margin: 8px 20px; }
    .sidebar-footer { padding: 16px 20px; border-top: 1px solid rgba(255,255,255,0.1); }
    .user-info { font-size: 13px; color: rgba(255,255,255,0.6); margin-bottom: 8px; overflow: hidden; text-overflow: ellipsis; }
    .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 24px; }
  `]
})
export class AppComponent {
  constructor(public auth: AuthService) {}
}

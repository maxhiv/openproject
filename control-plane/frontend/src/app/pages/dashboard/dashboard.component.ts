import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, RouterLink],
  template: `
    <div class="dashboard">
      <h1>Dashboard</h1>
      <div class="stats-grid">
        <div class="card stat-card">
          <div class="stat-value">{{ stats.projects }}</div>
          <div class="stat-label">Projects</div>
        </div>
        <div class="card stat-card">
          <div class="stat-value">{{ stats.sites }}</div>
          <div class="stat-label">Sites</div>
        </div>
        <div class="card stat-card">
          <div class="stat-value">{{ stats.openTickets }}</div>
          <div class="stat-label">Open Tickets</div>
        </div>
        <div class="card stat-card">
          <div class="stat-value">{{ stats.assets }}</div>
          <div class="stat-label">Network Assets</div>
        </div>
      </div>

      <div class="quick-actions">
        <h2>Quick Actions</h2>
        <div class="actions-grid">
          <a routerLink="/projects" class="card action-card">Create Project</a>
          <a routerLink="/tickets" class="card action-card">New Ticket</a>
          <a routerLink="/sites" class="card action-card">Add Site</a>
          <a routerLink="/construction" class="card action-card">Construction</a>
        </div>
      </div>
    </div>
  `,
  styles: [`
    h1 { margin-bottom: 24px; }
    .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-bottom: 32px; }
    .stat-card { text-align: center; }
    .stat-value { font-size: 36px; font-weight: 700; color: var(--primary); }
    .stat-label { font-size: 14px; color: var(--text-secondary); margin-top: 4px; }
    .quick-actions h2 { margin-bottom: 16px; }
    .actions-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 12px; }
    .action-card { text-align: center; font-weight: 500; color: var(--primary); cursor: pointer; transition: transform 0.1s; }
    .action-card:hover { transform: translateY(-2px); text-decoration: none; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
  `]
})
export class DashboardComponent implements OnInit {
  stats = { projects: 0, sites: 0, openTickets: 0, assets: 0 };

  constructor(private api: ApiService) {}

  ngOnInit() {
    this.loadStats();
  }

  loadStats() {
    this.api.get<any[]>('/api/organizations').subscribe({
      next: (orgs) => {
        if (orgs.length > 0) {
          const orgId = orgs[0].id;
          this.api.get<any[]>(`/api/organizations/${orgId}/projects`).subscribe(p => this.stats.projects = p.length);
        }
      },
      error: () => {}
    });
    this.api.get<any[]>('/api/isp_sites').subscribe({ next: s => this.stats.sites = s.length, error: () => {} });
    this.api.get<any[]>('/api/tickets', { status: 'open' }).subscribe({ next: t => this.stats.openTickets = t.length, error: () => {} });
    this.api.get<any[]>('/api/network_assets').subscribe({ next: a => this.stats.assets = a.length, error: () => {} });
  }
}

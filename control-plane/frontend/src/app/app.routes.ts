import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'login', loadComponent: () => import('./pages/login/login.component').then(m => m.LoginComponent) },
  { path: 'dashboard', loadComponent: () => import('./pages/dashboard/dashboard.component').then(m => m.DashboardComponent) },
  { path: 'projects', loadComponent: () => import('./pages/projects/projects.component').then(m => m.ProjectsComponent) },
  { path: 'sites', loadComponent: () => import('./pages/sites/sites.component').then(m => m.SitesComponent) },
  { path: 'tickets', loadComponent: () => import('./pages/tickets/tickets.component').then(m => m.TicketsComponent) },
  { path: 'assets', loadComponent: () => import('./pages/network-assets/network-assets.component').then(m => m.NetworkAssetsComponent) },
  { path: 'construction', loadComponent: () => import('./pages/construction/construction.component').then(m => m.ConstructionComponent) },
  { path: 'portal', loadComponent: () => import('./pages/portal/portal.component').then(m => m.PortalComponent) },
  { path: '**', redirectTo: 'dashboard' }
];

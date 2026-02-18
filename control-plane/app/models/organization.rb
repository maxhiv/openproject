class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :control_plane_projects, dependent: :destroy
  has_many :isp_sites, dependent: :destroy
  has_many :network_assets, dependent: :destroy
  has_many :ip_pools, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :change_requests, dependent: :destroy
  has_many :construction_packages, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :procurement_items, dependent: :destroy
  has_many :audit_logs, dependent: :destroy
  has_many :project_snapshots, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/ }

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    self.slug ||= name&.parameterize
  end
end

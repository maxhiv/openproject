class ControlPlaneProject < ApplicationRecord
  belongs_to :organization
  has_many :isp_sites, dependent: :nullify
  has_many :tickets, dependent: :destroy
  has_many :change_requests, dependent: :destroy
  has_many :construction_packages, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :procurement_items, dependent: :destroy
  has_many :construction_milestones, through: :construction_packages
  has_many :project_snapshots, dependent: :destroy

  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/ }

  before_validation :generate_identifier, on: :create

  def synced_with_openproject?
    openproject_project_id.present?
  end

  private

  def generate_identifier
    self.identifier ||= name&.parameterize
  end
end

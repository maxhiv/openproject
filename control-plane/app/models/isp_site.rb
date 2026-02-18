class IspSite < ApplicationRecord
  belongs_to :organization
  belongs_to :control_plane_project, optional: true
  has_many :network_assets, dependent: :destroy
  has_many :ip_pools, dependent: :destroy
  has_many :tickets, dependent: :nullify

  validates :name, presence: true
end

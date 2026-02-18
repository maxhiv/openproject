class ConstructionPackage < ApplicationRecord
  STATUSES = %w[planning active on_hold completed cancelled].freeze

  belongs_to :organization
  belongs_to :control_plane_project
  has_many :construction_milestones, dependent: :destroy
  has_many :procurement_items, dependent: :nullify

  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }
end

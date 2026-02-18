class ProcurementItem < ApplicationRecord
  STATUSES = %w[pending quoted ordered shipped delivered installed cancelled].freeze

  belongs_to :organization
  belongs_to :control_plane_project, optional: true
  belongs_to :construction_package, optional: true

  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }
end

class Permit < ApplicationRecord
  STATUSES = %w[pending submitted under_review approved denied expired].freeze

  belongs_to :organization
  belongs_to :control_plane_project

  validates :permit_type, presence: true
  validates :status, inclusion: { in: STATUSES }
end

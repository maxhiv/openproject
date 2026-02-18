class ConstructionMilestone < ApplicationRecord
  STATUSES = %w[pending in_progress completed approved rejected].freeze

  belongs_to :construction_package
  belongs_to :organization
  belongs_to :approved_by, class_name: "User", optional: true

  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }

  scope :client_visible, -> { where(client_visible: true) }
  scope :pending_approval, -> { where(requires_client_approval: true, status: "completed", client_approved_at: nil) }
end

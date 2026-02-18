class ChangeRequest < ApplicationRecord
  STATUSES = %w[draft pending_approval approved rejected in_progress completed cancelled].freeze

  belongs_to :organization
  belongs_to :control_plane_project, optional: true
  belongs_to :requester, class_name: "User", optional: true
  belongs_to :approver, class_name: "User", optional: true

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }

  scope :pending, -> { where(status: "pending_approval") }
  scope :active, -> { where(status: %w[approved in_progress]) }
end

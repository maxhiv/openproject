class Ticket < ApplicationRecord
  STATUSES = %w[open in_progress waiting_on_client waiting_on_vendor resolved closed].freeze
  PRIORITIES = %w[low normal high critical].freeze

  belongs_to :organization
  belongs_to :control_plane_project, optional: true
  belongs_to :isp_site, optional: true
  belongs_to :reporter, class_name: "User", optional: true
  belongs_to :assignee, class_name: "User", optional: true

  validates :subject, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  scope :client_visible, -> { where(client_visible: true) }
  scope :open_tickets, -> { where(status: %w[open in_progress waiting_on_client waiting_on_vendor]) }
  scope :sla_breached, -> { where("sla_due_at < ? AND status NOT IN (?)", Time.current, %w[resolved closed]) }
end

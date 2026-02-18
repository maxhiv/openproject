class Membership < ApplicationRecord
  ROLES = %w[org_admin staff client_admin client_user subcontractor readonly].freeze

  belongs_to :user
  belongs_to :organization

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :organization_id }

  scope :active, -> { where(active: true) }
end

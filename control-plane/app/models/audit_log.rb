class AuditLog < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :organization, optional: true

  validates :action, presence: true
end

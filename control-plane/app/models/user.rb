class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :audit_logs, dependent: :nullify

  validates :firebase_uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def superadmin?
    superadmin
  end

  def role_in(organization)
    memberships.find_by(organization: organization)&.role
  end

  def member_of?(organization)
    memberships.exists?(organization: organization, active: true)
  end
end

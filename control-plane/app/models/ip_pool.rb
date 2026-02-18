class IpPool < ApplicationRecord
  belongs_to :organization
  belongs_to :isp_site, optional: true

  validates :name, presence: true
  validates :network, presence: true
  validates :prefix_length, presence: true, numericality: { in: 1..128 }
end

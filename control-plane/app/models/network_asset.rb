class NetworkAsset < ApplicationRecord
  ASSET_TYPES = %w[circuit switch ap olt ont cpe camera nvr router firewall server ups pdu other].freeze

  belongs_to :organization
  belongs_to :isp_site, optional: true

  validates :asset_type, presence: true, inclusion: { in: ASSET_TYPES }
end

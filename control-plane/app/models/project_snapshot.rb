class ProjectSnapshot < ApplicationRecord
  belongs_to :control_plane_project
  belongs_to :organization
  belongs_to :user, optional: true
end

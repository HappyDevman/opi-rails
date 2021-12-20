class Cable < ApplicationRecord
  belongs_to :device

  validates :cable_id, presence: true
end

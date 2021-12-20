class Device < ApplicationRecord
  has_many :cables, dependent: :destroy

  validates :device_id, presence: true
end

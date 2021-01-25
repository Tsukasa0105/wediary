# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :map
  has_many :photos, dependent: :destroy
  has_many :pay_records, dependent: :destroy

  validates :name, presence: true
  validates :start_time, presence: true

  mount_uploader :image, ImageUploader
end

class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :map
  has_many :photos, dependent: :destroy 
  has_many :pay_records, dependent: :destroy 
  
  mount_uploader :image, ImageUploader
  
end

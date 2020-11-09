class Photo < ApplicationRecord
  belongs_to :group
  belongs_to :event
  mount_uploaders :images, ImageUploader
  serialize :images
end

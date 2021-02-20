# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :group
  belongs_to :event
  
  mount_uploader :image, ImageUploader
  serialize :image
  
  def self.create_photos_by(photo_params)
  
  # そもそも一枚も上がってきてない時のためのvalidate
    return false if photo_params[:images].nil?
  
  # 途中でエラった時にRollbackするようにTransaction
    Photo.transaction do 
      photo_params[:images].each do |image|
        new_photo = Photo.new(group_id: photo_params[:group_id], event_id: photo_params[:event_id], image: image)
        return false unless new_photo.save!
      end
    end
  
    true
  end
end

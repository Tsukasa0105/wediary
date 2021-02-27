# frozen_string_literal: true

class ChangeDatatypeImageOfPhotos < ActiveRecord::Migration[5.2]
  def change
    change_column :photos, :images, :text
  end
end

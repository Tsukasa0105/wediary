# frozen_string_literal: true

class RenameColumnImgToPhotos < ActiveRecord::Migration[5.2]
  def change
    rename_column :photos, :image, :img
  end
end

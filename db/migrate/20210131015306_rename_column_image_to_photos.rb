# frozen_string_literal: true

class RenameColumnImageToPhotos < ActiveRecord::Migration[5.2]
  def change
    rename_column :photos, :img, :image
  end
end

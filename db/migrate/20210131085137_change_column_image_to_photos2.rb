# frozen_string_literal: true

class ChangeColumnImageToPhotos2 < ActiveRecord::Migration[5.2]
  def change
    change_column :photos, :image, :text
  end
end

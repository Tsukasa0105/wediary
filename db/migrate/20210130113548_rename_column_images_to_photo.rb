# frozen_string_literal: true

class RenameColumnImagesToPhoto < ActiveRecord::Migration[5.2]
  def change
    rename_column :photos, :images, :image
  end
end

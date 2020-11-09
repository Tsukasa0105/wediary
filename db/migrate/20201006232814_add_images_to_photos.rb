class AddImagesToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :images, :string
  end
end

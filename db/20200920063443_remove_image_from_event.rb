class RemoveImageFromEvent < ActiveRecord::Migration[5.2]
  def up
    remove_column :events, :image
  end

  def down
    add_column :events, :name
  end
end

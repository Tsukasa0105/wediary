class AddGroupIdToMap < ActiveRecord::Migration[5.2]
  def change
    add_column :maps, :group_id, :string
  end
end

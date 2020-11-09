class AddKeyToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :key, :string 
  end
end

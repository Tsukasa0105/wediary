class RemoveCheckedFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :checked
    add_column :notifications, :checked, :boolean, default: false, null: false
  end
end

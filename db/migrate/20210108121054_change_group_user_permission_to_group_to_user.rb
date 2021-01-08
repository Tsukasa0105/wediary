class ChangeGroupUserPermissionToGroupToUser < ActiveRecord::Migration[5.2]
  def change
    rename_table :group_user_permissions, :group_to_users
  end
end

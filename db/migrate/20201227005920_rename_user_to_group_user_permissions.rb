class RenameUserToGroupUserPermissions < ActiveRecord::Migration[5.2]
  def change
    add_reference :group_user_permissions, :invited_user, foreign_key: { to_table: :users }
    add_reference :group_user_permissions, :inviting_group, foreign_key: { to_table: :groups }
  end
end

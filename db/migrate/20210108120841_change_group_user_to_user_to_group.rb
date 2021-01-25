# frozen_string_literal: true

class ChangeGroupUserToUserToGroup < ActiveRecord::Migration[5.2]
  def change
    rename_table :group_users, :user_to_groups
  end
end

# frozen_string_literal: true

class CreateGroupUserPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :group_user_permissions do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end

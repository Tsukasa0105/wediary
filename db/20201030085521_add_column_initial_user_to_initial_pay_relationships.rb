# frozen_string_literal: true

class AddColumnInitialUserToInitialPayRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :initial_pay_relationships, :initial_user_id, :string
  end
end

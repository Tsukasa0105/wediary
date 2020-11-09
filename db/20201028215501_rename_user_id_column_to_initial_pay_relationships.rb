class RenameUserIdColumnToInitialPayRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :initial_pay_relationships, :user_id
  end
end

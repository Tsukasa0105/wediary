class RemoveColumnPayRecordIdFromInitialPayRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :initial_pay_relationships, :pay_record_id
  end
end

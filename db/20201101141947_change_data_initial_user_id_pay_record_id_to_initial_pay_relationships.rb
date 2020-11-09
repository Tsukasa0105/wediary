class ChangeDataInitialUserIdPayRecordIdToInitialPayRelationships < ActiveRecord::Migration[5.2]
  def change
    change_column :initial_pay_relationships, :initial_user_id, :bigint
    change_column :initial_pay_relationships, :pay_record_id, :bigint
  end
end

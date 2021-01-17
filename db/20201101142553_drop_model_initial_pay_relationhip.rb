class DropModelInitialPayRelationhip < ActiveRecord::Migration[5.2]
  def change
    drop_table :initial_pay_relationships
  end
end

class CreateInitialPayRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :initial_pay_relationships do |t|
      t.references :initial_user, foreign_key: {to_table: :users }
      t.references :pay_record, foreign_key: true

      t.timestamps
    end
  end
end

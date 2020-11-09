class CreatePayRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_relationships do |t|
      t.references :user, foreign_key: true
      t.references :pay_record, foreign_key: true

      t.timestamps
    end
  end
end

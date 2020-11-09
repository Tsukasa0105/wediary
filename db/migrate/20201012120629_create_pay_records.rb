class CreatePayRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_records do |t|
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end
end

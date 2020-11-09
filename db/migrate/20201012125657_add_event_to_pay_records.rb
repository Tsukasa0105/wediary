class AddEventToPayRecords < ActiveRecord::Migration[5.2]
  def change
    add_reference :pay_records, :event, foreign_key: true
  end
end

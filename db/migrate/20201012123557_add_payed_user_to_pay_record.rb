# frozen_string_literal: true

class AddPayedUserToPayRecord < ActiveRecord::Migration[5.2]
  def change
    add_reference :pay_records, :paied_user, foreign_key: { to_table: :users }
  end
end

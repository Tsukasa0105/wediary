# frozen_string_literal: true

class AddColumnInitialPayRecordIdToInitialPayRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :initial_pay_relationships, :initial_pay_record_id, :string
  end
end

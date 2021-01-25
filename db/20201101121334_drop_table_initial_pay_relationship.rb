# frozen_string_literal: true

class DropTableInitialPayRelationship < ActiveRecord::Migration[5.2]
  def change
    drop_table :initial_pay_relationships
  end
end

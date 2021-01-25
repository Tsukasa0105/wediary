# frozen_string_literal: true

class AddKeyToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :key, :string
  end
end

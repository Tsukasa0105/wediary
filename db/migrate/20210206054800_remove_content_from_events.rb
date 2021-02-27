# frozen_string_literal: true

class RemoveContentFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :content, :string
  end
end

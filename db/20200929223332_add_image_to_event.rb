# frozen_string_literal: true

class AddImageToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :image, :string
  end
end

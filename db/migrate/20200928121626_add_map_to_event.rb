# frozen_string_literal: true

class AddMapToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :map, foreign_key: true
  end
end

# frozen_string_literal: true

class AddUserToMap < ActiveRecord::Migration[5.2]
  def change
    add_reference :maps, :user, foreign_key: true
  end
end

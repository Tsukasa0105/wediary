# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.string :image
      t.string :content

      t.timestamps
    end
  end
end

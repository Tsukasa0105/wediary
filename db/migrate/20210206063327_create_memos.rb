# frozen_string_literal: true

class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.string :title
      t.text :content
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class ChangeColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :start_date, :start_time
  end
end

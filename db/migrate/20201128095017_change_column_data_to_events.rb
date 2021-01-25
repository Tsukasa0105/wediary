# frozen_string_literal: true

class ChangeColumnDataToEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :start_time, :datetime
  end
end

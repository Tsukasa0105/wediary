class RenameEventDateColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :event_date, :start_date
  end
end

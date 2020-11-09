class AddEventToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_reference :photos, :event, foreign_key: true
  end
end

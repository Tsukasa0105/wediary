class AddColumnSituationToPayRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :pay_relationships, :situation, :string
  end
end

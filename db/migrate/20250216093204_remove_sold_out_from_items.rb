class RemoveSoldOutFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :sold_out, :boolean
  end
end

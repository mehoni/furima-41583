class AddSoldOutToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :sold_out, :boolean
  end
end

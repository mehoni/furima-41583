class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string      :title,                    null: false
      t.text       :description,               null: false
      t.integer    :price,                     null: false
      t.integer    :category_id,               null: false
      t.integer    :condition_id,              null: false
      t.integer    :shipping_cost_id,          null: false
      t.integer    :shipping_origin_id,        null: false
      t.integer    :shipping_date_estimate_id, null: false
      t.references :user,                      null: false, foreign_key: true
      t.timestamps
    end
  end
end

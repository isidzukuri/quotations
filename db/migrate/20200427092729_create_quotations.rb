class CreateQuotations < ActiveRecord::Migration[6.0]
  def change
    create_table :quotations do |t|
      t.string :language, null: true
      t.integer :page, null: true
      t.integer :percent, null: true
      t.string :url, null: true
      t.integer :user_id, null: true
      t.text :text, null: true
      t.timestamps null: false
    end
    
    add_index :quotations, :user_id
  end
end

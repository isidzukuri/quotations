class CreateScans < ActiveRecord::Migration[6.0]
  def change
    create_table :scans do |t|
      t.integer :status, null: false, default: 0
      t.integer :quotation_id, null: true
      t.string :language, null: true
      t.text :text, null: true
      t.string :log, null: true
      t.timestamps null: false
    end

    add_index :scans, :quotation_id
  end
end

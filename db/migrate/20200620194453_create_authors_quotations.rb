class CreateAuthorsQuotations < ActiveRecord::Migration[6.0]
  def change
    create_table :authors_quotations do |t|
      t.integer :author_id, null: false
      t.integer :quotation_id, null: false
    end

    add_index :authors_quotations, :quotation_id
    add_index :authors_quotations, :author_id
  end
end

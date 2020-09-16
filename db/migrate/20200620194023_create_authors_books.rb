class CreateAuthorsBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :authors_books do |t|
      t.integer :author_id, null: false
      t.integer :book_id, null: false
    end

    add_index :authors_books, :quotation_id
    add_index :authors_books, :book_id
  end
end

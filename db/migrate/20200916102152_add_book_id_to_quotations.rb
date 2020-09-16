class AddBookIdToQuotations < ActiveRecord::Migration[6.0]
  def change
    add_column :quotations, :book_id, :integer

    add_index :quotations, :book_id
  end
end

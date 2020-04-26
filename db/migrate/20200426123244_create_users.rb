class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nick_name, null: true
      t.string :first_name, null: true
      t.string :last_name, null: true
      t.timestamps null: false
    end
  end
end

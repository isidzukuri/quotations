class AddImageToScans < ActiveRecord::Migration[6.0]
  def change
    add_column :scans, :image, :string
  end
end

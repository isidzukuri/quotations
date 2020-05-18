class AddDoNotScanToScans < ActiveRecord::Migration[6.0]
  def change
    add_column :scans, :do_not_scan, :boolean, default: false
  end
end

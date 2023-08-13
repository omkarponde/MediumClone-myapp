class DropTableSaveForLater < ActiveRecord::Migration[7.0]
  def change
    drop_table :save_for_laters
  end
end

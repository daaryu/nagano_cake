class RenameLatsNameColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
     rename_column :customers, :lats_name, :last_name
  end
end

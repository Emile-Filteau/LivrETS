class AddPriceAndActivatedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :price, :float
    add_column :books, :activated, :boolean
  end
end

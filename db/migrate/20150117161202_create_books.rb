class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :edition
      t.integer :state
      t.string :email
      t.string :contact_name
      t.string :validation_code
      t.string :contact_phone

      t.timestamps
    end
  end
end

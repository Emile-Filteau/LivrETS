class AddAcronymToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :acronym, :string
  end
end

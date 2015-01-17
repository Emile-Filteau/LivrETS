class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :acronym
      t.string :name
      t.references :program, index: true

      t.timestamps
    end
  end
end

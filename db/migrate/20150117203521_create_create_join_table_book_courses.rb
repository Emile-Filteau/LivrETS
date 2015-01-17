class CreateCreateJoinTableBookCourses < ActiveRecord::Migration
  def change
    create_table :create_join_table_book_courses do |t|
      t.string :book
      t.string :course

      t.timestamps
    end
  end
end

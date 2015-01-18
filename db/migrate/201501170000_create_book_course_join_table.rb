class CreateBookCourseJoinTable < ActiveRecord::Migration
  def self.up
    create_table :books_courses, :id => false do |t|
      t.integer :book_id
      t.integer :course_id
    end

    add_index :books_courses, [:book_id, :course_id]
  end

  def self.down
    drop_table :books_courses
  end
end

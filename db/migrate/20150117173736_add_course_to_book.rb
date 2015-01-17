class AddCourseToBook < ActiveRecord::Migration
  def change
    add_reference :books, :course, index: true
  end
end

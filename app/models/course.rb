class Course < ActiveRecord::Base
  belongs_to :program
  has_many :books
end

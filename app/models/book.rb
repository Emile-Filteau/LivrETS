class Book < ActiveRecord::Base
  has_many :courses
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "250x250>" }, :default_url => "/images/:style/missing_book.svg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end

class Book < ActiveRecord::Base
  belongs_to :course
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "250x250>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end

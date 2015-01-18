class Book < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "250x250>" }, :default_url => "/images/:style/missing_book.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates :email, presence: true
  validates :name, presence: true, length: {minimum: 5}
  validates :state, presence: true, numericality: { only_integer: true, greater_than:0, less_than_or_equal_to:5 }
  validates :contact_name, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}
end

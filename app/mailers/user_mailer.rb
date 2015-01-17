class UserMailer < ActionMailer::Base
  default from: "books@etsbooks.com"

  def information_email(book)
    @book = book
    mail(to: @book.email, subject: 'ETSBook: '+@book.name)
  end
end

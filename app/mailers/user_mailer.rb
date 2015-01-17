class UserMailer < ActionMailer::Base
  default from: Rails.application.config.smtp_from

  def information_email(book)
    @book = book
    mail(to: @book.email, subject: 'ETSBook: '+@book.name)
  end
end

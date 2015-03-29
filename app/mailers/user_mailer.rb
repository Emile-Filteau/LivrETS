class UserMailer < ActionMailer::Base
  default from: Rails.application.config.smtp_from

  def information_email(book)
    @book = book
    mail(to: @book.email, subject: "LivrETS: #{@book.name}")
  end

  def contact_email(book, name, email, message)
    @book = book
    @name = name
    @email = email

    @message = message.gsub(/\r\n/, '<br />')
    mail(to: @book.email, subject: "LivrETS: #{email} vous a contacté")
  end
end

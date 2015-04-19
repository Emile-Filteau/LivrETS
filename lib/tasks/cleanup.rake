namespace :cleanup do
  desc "Cleanup all books in the system that have not been activated for 48 hours."
  task books: :environment do
    time_to_cleanup = 48.hours.ago

    books = Book.where(:activated => false).where("created_at < ?", time_to_cleanup)

    puts "Deleting #{books.length} books."
    books.destroy_all
  end

end

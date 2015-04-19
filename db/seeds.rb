require 'rake'

Rake::Task['update:programs'].invoke
Rake::Task['update:courses'].invoke

# load("db/seeds/SeedCourses.rb")
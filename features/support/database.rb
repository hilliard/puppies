require 'active_record'
require 'database_cleaner'
require 'factory_girl'

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => '../puppies/db/development.sqlite3'
)

DatabaseCleaner.strategy = :truncation, {:except => %w[puppies users]}

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end
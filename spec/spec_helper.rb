require 'rspec'
require 'pg'
require 'main_dish'

DB = PG.connect({:dbname => 'food_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM main_dishes *')
  end
end
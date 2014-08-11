require 'rspec'
require 'pg'
require 'main_dish'
require 'side_dish'


DB = PG.connect({:dbname => 'food_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM main_dishes *')
    DB.exec('DELETE FROM side_dishes *')
  end
end
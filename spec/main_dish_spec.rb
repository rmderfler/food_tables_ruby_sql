require 'spec_helper'

describe "Main_dish" do

  it "initializes main dishes with names and id numbers" do
    test_main = Main_dish.new(:main_dish => "burger")
    expect(test_main).to be_an_instance_of Main_dish
  end

  it "provides names and id numbers of main dishes" do
    test_main = Main_dish.new(:main_dish => "burger", :id => 1)
    expect(test_main.main_dish).to eq "burger"
    expect(test_main.id).to eq 1
  end

  it "starts with no dishes" do
    expect(Main_dish.all).to eq []
  end

  it "lets you save dishes to the database" do
    dish = Main_dish.new({:main_dish => "hamburger"})
    dish.save
    expect(Main_dish.all).to eq [dish]
  end

  it "is the same dish if it has the same name" do
    dish1 = Main_dish.new({:main_dish => "hamburger"})
    dish2 = Main_dish.new({:main_dish => "hamburger"})
    dish1.save
    dish2.save
    expect(dish1).to eq dish2
  end

   it "lets you search by dish and find the dish's id" do
    dish1 = Main_dish.new({:main_dish => "hamburger"})
    dish1.save
    dish2 = Main_dish.new({:main_dish => "hot dog"})
    dish2.save
    expect(Main_dish.search_by_name("hot dog")).to eq dish2.id
  end

  it "lets you change a dishes name" do
    dish1 = Main_dish.new({:main_dish => "hamburger"})
    dish1.save
    dish1.change_name("hamburger", "burger")
    expect(dish1.main_dish).to eq "burger"
  end

  
end
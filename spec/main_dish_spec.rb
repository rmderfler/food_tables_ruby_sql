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
end
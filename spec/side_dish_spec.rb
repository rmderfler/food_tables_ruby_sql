require 'spec_helper'

describe "Side_dish" do

  it "initializes side dishes with names and id numbers" do
    test_side = Side_dish.new(:side_dish => "fries")
    expect(test_side).to be_an_instance_of Side_dish
  end

  it "provides names and id numbers of side dishes" do
    test_side = Side_dish.new(:side_dish => "fries", :id => 1)
    expect(test_side.side_dish).to eq "fries"
    expect(test_side.id).to eq 1
  end


end
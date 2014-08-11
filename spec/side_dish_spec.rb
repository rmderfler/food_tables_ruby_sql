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


  it "starts with no dishes" do
    expect(Side_dish.all).to eq []
  end

  it "lets you save dishes to the database" do
    dish = Side_dish.new({:side_dish => "fries"})
    dish.save
    expect(Side_dish.all).to eq [dish]
  end

  it "is the same dish if it has the same name" do
    dish1 = Side_dish.new({:side_dish => "fries"})
    dish2 = Side_dish.new({:side_dish => "fries"})
    dish1.save
    dish2.save
    expect(dish1).to eq dish2
  end

  it "lets you search by dish and find the dish's id" do
    dish1 = Side_dish.new({:side_dish => "fries"})
    dish1.save
    dish2 = Side_dish.new({:side_dish => "onion rings"})
    dish2.save
    expect(Side_dish.search_by_name("onion rings")).to eq dish2.id
  end

  it "lets you change a dishes name" do
    dish1 = Side_dish.new({:side_dish => "fries"})
    dish1.save
    dish1.change_name("fries", "curly-fries")
    expect(dish1.side_dish).to eq "curly-fries"
  end

  it "lets you delete a dish" do
    dish1 = Side_dish.new({:side_dish => "fries"})
    dish1.save
    dish2 = Side_dish.new({:side_dish => "onion rings"})
    dish2.save
    dish3 = Side_dish.new({:side_dish => "cole slaw"})
    dish3.save
    dish2.delete_dish("onion rings")
    expect(Side_dish.all).to eq [dish1, dish3]
  end

    it "adds a main dish to a side dish" do
    main = Main_dish.new({:main_dish => "hamburger"})
    main_id = main.save
    side = Side_dish.new({:side_dish => "onion rings"})
    side_id = side.save
    side.add_main(main)
    results = DB.exec("SELECT * FROM combos WHERE main = #{main.id}")
    expect(results.first['main']).to eq main_id.to_s
  end

  describe ".search_by_main_dish" do
    it "finds all occurances of a main dish" do
      side = Side_dish.new({:side_dish => "fries"})
      side.save
      main1 = Main_dish.new({:main_dish => "hot dog"})
      main1.save
      main2 = Main_dish.new({:main_dish => "hamburger"})
      main2.save
      side.add_main(main1)
      expect(Side_dish.search_by_main_dish("hot dog")).to eq side.side_dish
    end
  end
  
end
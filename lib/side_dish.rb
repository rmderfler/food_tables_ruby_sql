class Side_dish

  attr_accessor :side_dish, :id

  def initialize attributes
    @id = attributes[:id]
    @side_dish = attributes[:side_dish]
  end

  def self.all  
    results = DB.exec("SELECT * FROM side_dishes;")
    side_dishes = []
    results.each do |result|
      side_name = result['side_dish']
      side_id = result['id'].to_i
      side_dishes << Side_dish.new({:side_dish => side_name, :id => side_id})
    end
    side_dishes
  end

  def save
    result = DB.exec("INSERT INTO side_dishes (side_dish) VALUES ('#{@side_dish}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def == (another_dish)
    self.side_dish == another_dish.side_dish 
  end

  def self.search_by_name(side)
    Side_dish.all.detect {|dish| dish.side_dish == side}.id
  end

  def change_name(old_name, new_name)
    DB.exec("UPDATE side_dishes SET side_dish = '#{new_name}' WHERE side_dish = '#{old_name}';")
    self.side_dish = new_name
  end

  def delete_dish(name)
    dish_to_delete = Side_dish.search_by_name(name)
    DB.exec("DELETE FROM side_dishes WHERE side_dish = '#{name}'")
    Side_dish.all.delete(Side_dish.all.first)
  end

   def add_main(main)
    results = DB.exec("INSERT INTO combos (main, side) VALUES (#{main.id}, #{self.id}) RETURNING id;")
    @id = results.first['id']
  end


  def self.search_by_main_dish(main)
  results = DB.exec("SELECT side_dishes.* FROM 
                    main_dishes JOIN combos on (main_dishes.id = combos.main)
                                JOIN side_dishes on (combos.side = side_dishes.id)
                    where main_dishes.main_dish = '#{main}';")
  results.first['side_dish']
end

end
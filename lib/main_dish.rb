class Main_dish

  attr_accessor :main_dish, :id

  def initialize attributes
    @id = attributes[:id]
    @main_dish = attributes[:main_dish]
  end

  def self.all  
    results = DB.exec("SELECT * FROM main_dishes;")
    main_dishes = []
    results.each do |result|
      main_name = result['main_dish']
      main_id = result['id'].to_i
      main_dishes << Main_dish.new({:main_dish => main_name, :id => main_id})
    end
    main_dishes
  end

  def save
    result = DB.exec("INSERT INTO main_dishes (main_dish) VALUES ('#{@main_dish}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def == (another_dish)
    self.main_dish == another_dish.main_dish 
  end

  def self.search_by_name(main)
    Main_dish.all.detect {|dish| dish.main_dish == main}.id
  end

   def change_name(old_name, new_name)
    DB.exec("UPDATE main_dishes SET main_dish = '#{new_name}' WHERE main_dish = '#{old_name}';")
    self.main_dish = new_name
  end

  def delete_dish(name)
    dish_to_delete = Main_dish.search_by_name(name)
    DB.exec("DELETE FROM main_dishes WHERE main_dish = '#{name}'")
    Main_dish.all.delete(Main_dish.all.first)
  end

  def add_side(side)
    results = DB.exec("INSERT INTO combos (main, side) VALUES (#{self.id}, #{side.id}) RETURNING id;")
    @id = results.first['id']
  end

  def self.search_by_side_dish(side)
    results = DB.exec("SELECT main_dishes.* FROM
                       side_dishes JOIN combos on (side_dishes.id = combos.side)
                                   JOIN main_dishes on (combos.main = main_dishes.id)
                       WHERE side_dishes.side_dish = '#{side}';")
    results.first['main_dish']
  end


end
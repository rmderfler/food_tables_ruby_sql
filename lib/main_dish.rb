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

end
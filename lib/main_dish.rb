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

end
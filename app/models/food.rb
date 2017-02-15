class Food
  attr_accessor :id, :first_ingredient, :second_ingredient, :first_spice, :first_spice_amount, :second_spice, 
    :second_spice_amount

  HEADER = {"Accept" => "application/json", 
            "X-User-Email" => ENV['API_EMAIL'], 
            "Authorization" => "Token token=#{ENV['API_KEY']}"}

  def initialize(hash)
    @id = hash["id"]
    @first_ingredient = hash["first_ingredient"]
    @second_ingredient = hash["second_ingredient"]
    @first_spice = hash["first_spice"]
    @first_spice_amount = hash["first_spice_amount"]
    @second_spice = hash["second_spice"]
    @second_spice_amount = hash["second_spiceamount"]
  end

  def self.create(input_hash)
    food_hash = Unirest.post("#{ENV['API_URL']}/foods",
                        headers: HEADER,
                        parameters:input_hash
                        ).body
    @food = Food.new(food_hash)
    
  end

  def self.find_by(input_options)
    id = input_options[:id]
    food_hash = Unirest.get("#{ENV["API_URL"]}/foods/#{id}", headers: HEADER).body
    Food.new(food_hash)    
  end

  def self.all 
    food_hashes = Unirest.get("#{ENV['API_URL']}/foods", headers: HEADER).body
    foods = []
    food_hashes.each do |food_hash|
      foods << Food.new(food_hash)
    end 
    return foods
  end

  def update(input_hash)
    food_hash = Unirest.patch("#{ENV['API_URL']}/foods/#{self.id}",
                          headers: HEADER,
                          parameters: input_hash
                          ).body 
    Food.new(food_hash)
  end

  def destroy
    Unirest.delete("#{ENV['API_URL']}/foods/#{id}", headers: HEADER).body
  end

end 
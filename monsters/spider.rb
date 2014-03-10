require './monster'

class Spider < Monster
  
  def initialize
    super
    puts "Spider initializing"
  end
      
  def self.weapons
    result = super
    result[:sting] = Weapon.new( "Sting", 0, 10, 14, 0, :attribute, :poison );
    result
  end
  
  def self.types
    result = {}
    result[:attercop] = { :name => "Attercop", :attribute_level => 4, :endurance => 12, :hate => 2, :parry => 4, :armor => 2, :shield => 0, :weapons => { :sting => 2}, :abilities => [:great_leap, :seize_victim] }
    result[:great_spider] = { :name => "Great Spider", :attribute_level => 4, :endurance => 36, :hate => 3, :parry => 5, :armor => 3, :shield => 0, :weapons => { :sting => 2}, :abilities => [:strike_fear, :seize_victim, :denizen_of_the_dark, :dreadful_spells] }
    
    result
  end
  
end

Monster.register Spider


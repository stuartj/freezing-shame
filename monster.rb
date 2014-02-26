#class Weapon
#  String  name
#  Number  damage
#  Number  edge
#  Number  injury
#end

require './opponent'

class Monster < Opponent  
  
  attr_accessor :attribute_level, :parry, :hate
  attr_accessor :max_hate, :max_endurance
    
  def initialize
    super
    puts "Monster initializing"
    @parry = 0
    @attribute_level = 1
    @hate = 1
    @special_abilities = 0 #bit mask
  end
  
  def self.weapons
    Hash.new
  end
  
  def self.armors
    Hash.new
  end
  
  
  def maxEndurance
    @max_endurance
  end
  
  
  def parry
    @parry + @shield.value
  end
  
  def reset
    super
    @hate = @max_hate
  end
  
  def tn opponent 
    if opponent.kind_of? Hero
      opponent.stance + self.parry
    else
      9 + self.parry # not sure when this would happen....
    end
  end
  
  def alive?
    return super && (wounds == 0)
  end
  
  
  def weary?
    super || (@hate == 0)
  end
  
  def damageBonus
    self.attribute_level
  end
  
end

    
    

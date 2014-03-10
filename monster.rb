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
  
  def self.register subclass
    if @@monsters == nil 
      @@monsters = new Set
    end
    @@monsters.add subclass
  end
  
  def self.createType typeSymbol, weapon=nil
    type = self.types[typeSymbol]
    m = self.new
    # create from hash; default to first weapon
    m.name = type[:name]
    m.max_hate = type[:hate]
    m.max_endurance = type[:endurance]
    m.armor = type[:armor]
    m.parry = type[:parry]
    m.shield = type[:shield]
    weaponKey = weapon ? weapon : type[:weapons].keys[0]; #default to first weapon
    m.weapon = self.weapons[weaponKey];
    m.weapon_skill = type[:weapons][weaponKey]
    m
  end
      
  def armor=(newArmor)
     if (newArmor.kind_of? Fixnum) 
       @armor = Armor.new( self.class.to_s + " Armor", newArmor, 0 )
     else
       super
     end
     @armor
   end

   def shield=(newArmor)
     if newArmor.kind_of? Fixnum
       @shield = Shield.new( self.class.to_s + " Shield", newArmor, 0)
     else 
       super
     end
     @shield
   end


   def armor
     if @armor == nil
       @armor = 0
     end
     @armor
   end

   def shield
     if @shield == nil
       @shield = 0
     end
     @shield
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
    @parry + ((@shield && @weapon.allows_shield?) ? @shield.value : 0)
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

    
    

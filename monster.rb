#class Weapon
#  String  name
#  Number  damage
#  Number  edge
#  Number  injury
#end

require './opponent'

class Monster < Opponent  
  
  @@monsters = nil
  
  attr_accessor :attribute_level, :parry, :hate, :attributes
  attr_accessor :max_hate, :max_endurance
    
  def initialize
    super
    puts "Monster initializing"
    @parry = 0
    @attribute_level = 1
    @attributes = []
    @hate = 1
    @special_abilities = 0 #bit mask
  end
  
  def self.fromParams params
    monsterClass = (Object.const_get(params[:monsterclass]));
    monsterClass.createType params[:monstertype]
  end
  
  
  def self.monsters
    @@monsters
  end
    
  def self.register subclass
    if !@@monsters 
      @@monsters = Set.new
    end
    @@monsters.add subclass
  end
  
  def initFromType typeSymbol, weapon=nil
    puts typeSymbol
    type = self.class.types[typeSymbol.to_sym]
    @name = type[:name]
    @abilities = type[:abilities]
    @attribute_level = type[:attribute_level]
    @max_hate = type[:hate]
    @max_endurance = type[:endurance]
    @armor = type[:armor]
    @parry = type[:parry]
    @shield = type[:shield]
    weaponKey = weapon ? weapon : type[:weapons].keys[0]; #default to first weapon
    self.weapon = self.weapons[weaponKey];
    @weapon_skill = type[:weapons][weaponKey]
    self
  end
  
  def self.createType typeSymbol, weapon=nil
    self.new.initFromType typeSymbol, weapon
  end
  
  def weapon=(newWeapon)
    super
    if( @weapon.type == :attribute )
      @weapon.damage = @attribute_level
    end
    weapon
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
  
  def protection
    @armor
  end
  
  
  def parry
    @parry + ((@shield && @weapon.allows_shield?) ? @shield : 0)
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
    return super && (wounds < ((@abilities.include? :great_size) ? 2 : 1))
  end
  
  
  def weary?
    super || (@hate == 0)
  end
  
  def damageBonus
    self.attribute_level
  end
  
  # special ability use
  def bewilder opponent
    opponent.conditions.add :bewildered
  end
  
  
end

    
    

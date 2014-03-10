require './dice'
require './gear'
require './weapon'

class Opponent  

  attr_accessor :dice
  attr_accessor :name, :endurance, :weapon_skill, :wounds
  attr_accessor :size # 2 == Hobbit, 3 == Man
  attr_accessor :armor, :shield, :helm
  attr_accessor :max_endurance
  attr_accessor :weapon, :weapon_skill
  attr_accessor :rweapon, :r_weapon_skill # ranged.  NYI
  #attr_accessor :weapon_name, :weapon_damage, :weapon_edge, :weapon_injury

  
  def maxEndurance
    0 # implemented by subclasses
  end

  def initialize
    puts "Opponent intializing"
    @conditions = Set.new
    @size = 3 # default size
  end
  
  def addCondition symbol
    @conditions.add symbol
  end
  
  def removeCondition symbol
    #NYI
  end
  
  def weapons
    return self.class.weapons
  end
  
  def self.weapons filter = nil
    return Hash.new
  end
  
  def self.weaponForSymbol aSymbol
    list = self.weapons
    if list.include? aSymbol 
      return list[aSymbol]
    else
      return Weapon.fist 
    end
  end
  
  def weapon=(newWeapon)
    if newWeapon.class == Weapon
      @weapon = newWeapon
    elsif newWeapon.class == Symbol
      @weapon = self.class.weaponForSymbol newWeapon
    else
      puts "Error setting weapon: sent class " + newWeapon.class.to_s
    end
    @weapon
  end
      
  def self.rewards #modifiers applied to gear
    [] #array of symbols; implemented by sub-classes
  end
  
  def self.virtues #modifiers applied to self
    [] #array of symbols; implemented by sub-classes
  end
  
  def self.gear filter = nil
    result = Hash.new
    result[:no_shield] = Shield.new("None", 0, 0)
    result[:no_helm] = Helm.new("None", 0, 0)
    result[:no_armor] = Armor.new("None", 0, 0)
    result[:leather_shirt] = Armor.new("Leather shirt", 1, 4)
    result[:leather_corslet] = Armor.new("Leather corslet", 2, 8)
    result[:mail_shirt] = Armor.new("Mail shirt", 3, 12)
    result[:coat_of_mail] = Armor.new("Coat of mail", 4, 16)
    result[:mail_hauberk] = Armor.new("Mail hauberk", 5, 20)
    result[:cap] = Helm.new("Cap of iron and leather", 1, 2)
    result[:helm] = Helm.new("Helm", 4, 6)
    result[:buckler] = Shield.new("Buckler", 1, 1)
    result[:shield] = Shield.new("Shield", 2, 2)
    result[:great_shield] = Shield.new("Great shield", 3, 3)
    return result
  end
  
  def self.shields filter = nil
    self.gear.keep_if {|k,v| v.class == Shield }
  end

  def self.helms filter = nil
    self.gear.keep_if {|k,v| v.class == Helm }
  end
  
  def self.armors filter = nil
    self.gear.keep_if {|k,v| v.class == Armor }
  end

  def self.armorForSymbol aSymbol
    list = self.armors
    if list.include? aSymbol 
      return list[aSymbol]
    else
      return Armor.none 
    end
  end
  
  def armor=(newArmor)
    if newArmor.kind_of? Armor
      @armor = newArmor
    elsif newArmor.kind_of? Symbol
      @armor = self.class.armorForSymbol newArmor
    else
      puts "Error setting armor: sent class " + newArmor.class.to_s
    end
    @armor
  end

  def shield=(newArmor)
    if newArmor.kind_of? Shield
      @shield = newArmor
    elsif newArmor.kind_of? Symbol
      @shield = self.class.armorForSymbol newArmor
    else
      puts "Error setting shield: sent class " + newArmor.class.to_s
    end
    @shield
  end
  
  def helm=(newArmor)
    if newArmor.kind_of? Helm
      @helm = newArmor
    elsif newArmor.kind_of? Symbol
      @helm = self.class.armorForSymbol newArmor
    else
      puts "Error setting helm: sent class " + newArmor.class.to_s
    end
    @heml
  end
  
  def armor
    if @armor == nil
      @armor = Armor.new("Nekked", 0, 0)
    end
    @armor
  end

  def shield
    if @shield == nil
      @shield = Shield.new("No Shield", 0, 0)
    end
    @shield
  end

  def helm
    if @helm == nil
      @helm = Helm.new("No Helm", 0, 0)
    end
    @helm
  end
    
  def maxEndurance
    self.class.enduranceBase + @body
  end
  
  def parry
    0 # implemented by subclasses
  end
  
  def wound
    @wounds += 1
  end
    
  def reset
    @wounds = 0
    @is_shield_broken = false
    @endurance = self.maxEndurance
  end
  
  def alive?
    @endurance > 0
  end

  def weary?
    (@conditions.include? :weary)
  end
  
  def weaponSkill
    self.weapon_skill
  end
  
  def damageBonus
    0 #overridden by subclass
  end
  
  def tn opponent
    0 #overridden by subclasss
  end
  
  def rollProtectionAgainst opponent
    self.dice.roll( self.protection, self.weary?, opponent.weapon.rollModifier )
    if !@dice.test weapon.injury
      self.wound
    end
  end
  
  def protection
    0 + (@armor ? @armor.value : 0) + (@helm ? @helm.value : 0)
  end
  
  def dice
    if @dice == nil
      @dice = Dice.new
    end
    @dice
  end
  
  def roll diceCount
    (self.dice).roll( diceCount, self.weary?, 0 )
  end
  
  #special events
  def smashShield
  end
  
  def disarm
  end
  
  def intimidate
  end
  
  
  
  def getHitBy opponent
    damage = opponent.weapon.damage
    opponent.dice.tengwars.times do
      damage += opponent.damageBonus
    end
    @endurance -= damage
#    puts self.name + " takes " + damage.to_s + " damage (" + @endurance.to_s + " left)"
    
    if opponent.dice.feat >= opponent.weapon.edge
      if true
#        puts "Piercing Blow!"
      end
      self.rollProtectionAgainst( opponent )
      if true
#        puts @name + " rolls " + @dice.to_s + " and is" + ((opponent.dice.test opponent.weapon.injury) ? " not" : "") + " wounded"
      end     
    end
  end
  
  def rally
  end
  
  def attack( opponent, verbose=false )
    self.roll( @weapon_skill )
    
    if verbose
#      puts self.name + " attacks " + opponent.name + " and rolls " + @dice.to_s
    end
    
    if( @dice.test( opponent.tn self ) )
      opponent.getHitBy self 
#      damage = @weapon.damage   
      #bonus damage
#      @dice.tengwars.times do
#        damage += self.damageBonus
#      end      
#      opponent.takeDamage damage
#      puts opponent.name + " takes " + damage.to_s + " damage"      
      #piercing check
#      if @dice.feat >= @weapon.edge  
#        if verbose
#          puts "Piercing blow!" 
#        end        
        
#        opponent.rollProtectionAgainst( @weapon )
  
#        if verbose
#          puts opponent.name + " rolls " + opponent.dice.to_s + " and is" + ((@dice.test @weapon.injury) ? " not" : "") + " wounded"
#        end
#      end
    end
    
    #if piercing, roll armor
    #if fail, deal with consequences (need to deal with Toughness)
  end
end



require './dice'
require './gear'
require './weapon'
require './fightrecord'

class Opponent  

  attr_accessor :dice
  attr_accessor :name, :endurance, :weapon_skill, :wounds
  attr_accessor :size # 2 == Hobbit, 3 == Man
  attr_accessor :armor, :shield, :helm
  attr_accessor :max_endurance
  attr_accessor :weapon, :weapon_skill
  attr_accessor :rweapon, :r_weapon_skill # ranged.  NYI
  #attr_accessor :weapon_name, :weapon_damage, :weapon_edge, :weapon_injury
  attr_accessor :conditions # catch-all for combat modifiers
  attr_accessor :called_shot # will next attack be called shot?

  
  def maxEndurance
    0 # implemented by subclasses
  end
  
  def initialize
    puts "Opponent intializing"
    @conditions = Set.new
    @called_shot = false
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
  
  def attackerRolledSauron
    #god this is an ugly way to do this....
  end
  
  def self.gearForSymbol aSymbol, type
    list = self.gear type, nil
    if list.include? aSymbol 
      return list[aSymbol]
    elsif (rg = self.rewardGear).keys.include? aSymbol
      return rg[aSymbol]
    else
      return list[:none] # I think this is going to break for weapon
    end
  end
  
  def weapon=(newWeapon)
    if newWeapon.class == Weapon
      @weapon = newWeapon
    elsif newWeapon.class == Symbol
      @weapon = self.class.gearForSymbol newWeapon, Weapon
    else
      puts "Error setting weapon: sent class " + newWeapon.class.to_s
    end
    @weapon
  end
  
  
  def armor=(newArmor)
    if newArmor.kind_of? Armor
      @armor = newArmor
    elsif newArmor.kind_of? Symbol
      @armor = self.class.gearForSymbol newArmor, Armor
    else
      puts "Error setting armor: sent class " + newArmor.class.to_s
    end
    @armor
  end

  def shield=(newArmor)
    if newArmor.kind_of? Shield
      @shield = newArmor
    elsif newArmor.kind_of? Symbol
      @shield = self.class.gearForSymbol newArmor, Shield
    else
      puts "Error setting shield: sent class " + newArmor.class.to_s
    end
    @shield
  end
  
  def helm=(newArmor)
    if newArmor.kind_of? Helm
      @helm = newArmor
    elsif newArmor.kind_of? Symbol
      @helm = self.class.gearForSymbol newArmor, Helm
    else
      puts "Error setting helm: sent class " + newArmor.class.to_s
    end
    @heml
  end
  
  def self.rewardGear gearList=nil
    {} # implemented by subclasses
  end
  
      
  def self.rewards #modifiers applied to gear
    {} #implemented by sub-classes
  end
  
  def self.virtues #modifiers applied to self
    {} #implemented by sub-classes
  end
  
  def self.gear filter = nil, type = nil
    {}
  end

#  def self.shields filter = nil
#    self.gear.keep_if {|k,v| v.class == Shield }
#  end
#
#  def self.helms filter = nil
#    self.gear.keep_if {|k,v| v.class == Helm }
#  end
#  
#  def self.armors filter = nil
#    self.gear.keep_if {|k,v| v.class == Armor }
#  end


  
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
  
  def wound record=nil
    @wounds += 1
    if record
      record.addEvent( self.name, :wound, @dice, self.wounds )
    end
  end
    
  def reset
    @wounds = 0
    @is_shield_broken = false
    @endurance = self.maxEndurance
    @conditions = Set.new
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
  
  def rollProtectionAgainst opponent, record
    tn = opponent.weapon.injury
    mod = (opponent.dice.gandalf? && opponent.weapon.hasQuality?( :dalish ) ? -1 : 0 )
    self.dice.roll( self.protection, self.weary?, mod )
    record.addEvent( opponent.name, :pierce, nil, nil )
    record.addEvent( self.name, :armor_check, @dice, tn )
    test = @dice.test opponent.weapon.injury
    if !test
      self.wound record
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
  
  
  
  def getHitBy opponent, record
    damage = opponent.weapon.damage
    opponent.dice.tengwars.times do
      damage += opponent.damageBonus
    end
    @endurance -= damage
    record.addEvent( self.name, :damage, nil, damage )
  end
  
  def rally

  end
  

  
  # if opponent is still alive will attack back
  def attack( opponent, record = nil, nest = 0 )
    if record == nil
      record = FightRecord.new
    end
    
#    if resultString != nil
#      resultString += "<br>" + self.name + " attacks " + opponent.name + " and rolls " + @dice.to_s
#    end

    self.roll( @weapon_skill )
    
    if( @dice.sauron? )
      opponent.attackerRolledSauron
    end
    
    tn = opponent.tn self
    
    record.addEvent( self.name, :attack, @dice.clone, tn )
            
    if( @dice.test( opponent.tn self ) )
      if( @called_shot )
        record.addEvent( self.name, :called_shot, nil, nil )
        if @dice.tengwars > 0
          opponent.getHitBy self, record 
          opponent.wound record
        end
        @called_shot = false
      else
        opponent.getHitBy self, record      
      
        if (self.weapon.hasQuality?(:kings_blade) && (self.dice.tengwars > 0))
          opponent.wound record
        elsif @dice.feat >= @weapon.edge
          opponent.rollProtectionAgainst( opponent, record )
        end
      end
    end
    
    if nest > 40 
      puts "Depth: " + nest.to_s
    end
    
    
    if( opponent.alive? )
      opponent.attack( self, record, nest+1 )
    else
      record.addEvent( opponent.name, :dies, nil )
    end
    
    record
  end
end





require './opponent'
require 'set'

class Hero < Opponent
    
  attr_accessor :body, :wits, :heart
  attr_accessor :f_body, :f_wits, :f_heart # favoured value bonus (e.g., delta, not total)
  attr_accessor :fatigue, :stance
  attr_accessor :wisdom, :valor
  attr_accessor :virtues #bitmask; generic for Virtues AND Rewards
  attr_accessor :favoured_weapon, :r_favoured_weapon
  
  @@cultures = Set.new
  
  def initialize
    super
    puts "Hero intializing"
    @body = 0
    @wits = 0
    @heart = 0
    @fatigue = 0
    @stance = 9
    @wisdom = 0
    @valor = 0
    @virtues = Set.new
  end
  
  def self.fromParams params
    heroClass = (Object.const_get(params[:culture]));
    hero = heroClass.new
    background = hero.class.backgrounds[params[:background].to_sym]
    hero.body = background[:body]
    hero.heart = background[:heart]
    hero.wits = background[:wits]
    hero.weapon = params[:weapon].to_sym
    hero.armor = params[:armor].to_sym
    hero.shield = params[:shield].to_sym
    hero.helm = params[:helm].to_sym
    hero.weapon_skill = params[:Weapon_skill].to_i
    hero.name = "Default Hero Name"
    hero
  end
  	
  
  def self.cultureName
    self.to_s
    # implemented by subclasses if different from class name
  end
  
  def self.registerCulture subclass
    @@cultures.add subclass
  end
  
  def self.cultures
    # figure out how to do this algorithmically
    @@cultures.sort{ |a,b| a.to_s <=> b.to_s }
  end
  
  
  def self.weapons filter = nil
    result = super
    result[:dagger] = Weapon.new( "Dagger", 3, 12, 12, 0, :one_handed, nil );
    result[:short_sword] = Weapon.new( "Short Sword", 5, 10, 14, 1, :one_handed, nil)
    result[:sword] = Weapon.new("Sword", 5, 10, 16, 2, :one_handed, nil)
    result[:long_sword_1] = Weapon.new("Long Sword (1H)", 5, 10, 16, 3, :one_handed, nil)
    result[:long_sword_2] = Weapon.new("Long Sword (2H)", 7, 10, 18, 3, :two_handed, nil)
    result[:spear] = Weapon.new("Spear", 5, 9, 14, 2, :versatile, nil)
    result[:great_spear] = Weapon.new("Great Spear", 9, 9, 16, 4, :two_handed, nil)
    result[:axe] = Weapon.new("Axe", 5, 12, 18, 2, :one_handed, nil)
    result[:great_axe] = Weapon.new("Great Axe", 9, 12, 20, 4, :two_handed, nil)
    result[:long_hafted_axe_1] = Weapon.new("Long-hafted Axe (1H)", 5, 12, 18, 3, :one_handed, nil)
    result[:long_hafted_axe_2] = Weapon.new("Long-hafted Axe (2H)", 7, 12, 20, 3, :two_handed, nil)
    result[:bow] = Weapon.new("Bow", 5, 10, 14, 1, :ranged, nil)
    result[:great_bow] = Weapon.new("Great bow", 7, 10, 16, 3, :ranged, nil)
    
    if filter.is_a? Array
      puts filter
      gear = self.culturalEquipment
      gear.keys.each do |key|
        puts key
        if (filter.include? key) && (culturalEquipment[key].superclass == Weapon )
          puts "Key: " + key.to_s + " found!"
          result[key] = culturalEquipment[key].new
        end
      end
    end
    
    result
  end
  

  def hasVirtue? virtue
    @virtues.include? virtue
  end
  
  def addVirtue virtue
    @virtues.add virtue
  end
  # 
  def self.enduranceBase
    0 # implemented by subclasses
  end
  
  def self.hopeBase
    0 # implemented by subclasses
  end
  
  def totalFatigue
    @fatigue + self.encumbrance
  end
  
  def encumbrance
    @armor.encumbrance + @helm.encumbrance + @shield.encumbrance + @weapon.encumbrance
  end
  
  def maxEndurance
    super + ((self.hasVirtue? :resilience) ? 2 : 0)
  end
  
  
  # testing out setter override
  def body=(new_body )
    @body = new_body
    @endurance = self.class.enduranceBase + @body
  end

  def setBody(new_body, favoured_bonus )
    @body = new_body
    @f_body = favoured_bonus
  end

  def setHeart(new_heart, favoured_bonus )
    @heart = new_heart
    @f_heart = favoured_bonus
  end
  
  def setWits(new_wits, favoured_bonus )
    @wits = new_wits
    @f_wits = favoured_bonus
  end

  def self.virtues #modifiers applied to gear
    super + [:confidence, :dour_handed, :expertise, :fell_handed, :gifted, :resilience ] 
  end
  
  def self.rewards #modifiers applied to self
    # problem....some qualities apply only to some armor items...
    # maybe compare qualities handled by item to qualities avaialble to character?
    super + [:cunning_make, :close_fitting, :reinforced, :grievous, :keen, :fell] 
  end
  
    
  
  def self.featList
    [:confidence, :dour_handed, :expertise, :fell_handed, :resilience, :cunning_make, :close_fitting, :reinforced, :grievous, :keen, :fell]
  end
  
  def damageBonus
    # @favoured_weapon ? @body + @f_body : @body
    @body
  end
  
  def reset
    super
  end
  
  def feat symbol
    # look up mask value for this symbol
    maskValue = self.maskValueFor symbol
    # check to see if this virtue or reward has already been added; exit if it has
    if @feats & maskValue > 0
      return
    end
    # apply the virtue or reward (how to get logic from subclasses?)
    self.applyFeat symbol
    # modify mask
    @virtues_rewards |= maskValue
    # now modify character or gear, when appropriate...
  end
  
 
  def self.sample
    h = Hero.new
    h.parry = 3
    h.stance = 9
    h.weapon_skill = 3
    h
  end
  
  def parry
    self.wits + (self.weapon.allows_shield? ? self.shield.value : 0 )
  end
  
  
  def tn opponent  # this is TN to get hit; opponent argument only there for monsters
    @stance + self.parry 
  end
  
  def alive?
    return super && wounds < 2
  end
  
  
  def weary?
    super || (self.totalFatigue > @endurance)
  end
  
  def attackRoll
    @dice.roll( self.weapon_skill, self.isWeary, 0 )
    return d
  end
end   




require './opponent'
require 'set'

class Hero < Opponent
    
  attr_accessor :body, :wits, :heart
  attr_accessor :f_body, :f_wits, :f_heart # favoured value bonus (e.g., delta, not total)
  attr_accessor :fatigue, :stance
  attr_accessor :wisdom, :valor
  attr_accessor :feats #bitmask; generic for Virtues AND Rewards
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
    @feats = 0
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
    @@cultures
  end
  
  
  def self.weapons
    result = super
    result[:dagger] = Weapon.new( "Dagger", 3, 12, 12, 0, nil );
    result[:short_sword] = Weapon.new( "Short Sword", 5, 10, 14, 1, nil)
    result[:sword] = Weapon.new("Sword", 5, 10, 16, 2, nil)
    result[:long_sword_1] = Weapon.new("Long Sword (1H)", 5, 10, 16, 3, nil)
    result[:long_sword_2] = Weapon.new("Long Sword (2H)", 7, 10, 18, 3, nil)
    result[:spear] = Weapon.new("Spear", 5, 9, 14, 2, nil)
    result[:great_spear] = Weapon.new("Great Spear", 9, 9, 16, 4, nil)
    result[:axe] = Weapon.new("Axe", 5, 12, 18, 2, nil)
    result[:great_axe] = Weapon.new("Great Axe", 9, 12, 20, 4, nil)
    result[:long_hafted_axe_1] = Weapon.new("Long-hafted Axe (1H)", 5, 12, 18, 3, nil)
    result[:long_hafted_axe_2] = Weapon.new("Long-hafted Axe (2H)", 7, 12, 20, 3, nil)
    result[:bow] = Weapon.new("Bow", 5, 10, 14, 1, nil)
    result[:great_bow] = Weapon.new("Great bow", 7, 10, 16, 3, nil)
    return result
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
    super + ((self.hasFeat? :resilience) ? 2 : 0)
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
  
  def maskValueFor symbol
    symbols = self.class.featList
    if !symbols.include? symbol
      return 0
    end
    return 2 ** (symbols.index symbol)
  end
  
  def hasFeat? symbol
    mask = self.maskValueFor symbol
    @feats & mask
  end
  
  def applyFeat symbol
    case symbol
    when :fell_handed
      @weapon.damage = @weapon.damage + 1
    when :dour_handed
      @r_weapon.damage = @r_weapon.damage + 1
    when :gifted
      # increases a favoured attribute by 1; NYI
    when :resilience
      # handled in maxStamina
    when :cunning_make
      # this one is tricky; needs a second argument...shit I need to give weapons attributes
    else
      return false # used for testing that all symbols are accounted for
    end
    return true # symbol argument was found
  end

  
  def self.sample
    h = Hero.new
    h.parry = 3
    h.stance = 9
    h.weapon_skill = 3
    h
  end
  
  def parry
    self.wits + self.shield.value
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


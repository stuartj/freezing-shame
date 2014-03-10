require './hero'

class DalishLongbow < Weapon
  def initialize
    self.clone Hero.weapons[:great_bow]
    @name = "Dalish Longbow"
  end
  
  def self.to_sym
    :dalish_longbow
  end
end

class SpearOfKingBladorthin < Weapon
  def initialize
    self.clone Hero.weapons[:spear]
    @name = "Spear of King Bladorthin"
  end

  def self.to_sym
    :spear_of_king_bladorthin
  end
end

class TowerShield < Shield
  def self.to_sym
    :tower_shield
  end
end

class Barding < Hero
  
  superclass.registerCulture self

  def self.enduranceBase
    22
  end
  
  def self.hopeBase
    8
  end
  
  def self.virtues #modifiers applied to self
    super + [:birthright, :fierce_shot, :kings_men, :swordmaster, :woeful_foresight ] 
  end
  
  def self.rewards #
    super + [:dalish_longbow, :spear_of_king_bladorthin, :tower_shield] 
  end
  
  
  def self.culturalEquipment
    result = {}
    [DalishLongbow, SpearOfKingBladorthin, TowerShield].each do | x |
      result[x.to_sym] = x
    end
    result
  end
  
  
  def self.backgrounds
    result = Hash.new
    result[:by_hammer_and_anvil] = {:name => "By Hammer and Anvil", :body => 5, :heart => 7, :wits => 2}
    result[:word_weaver] = {:name => "Wordweaver", :body => 4, :heart => 6, :wits => 4}
    result[:gifted_sense] = {:name => "Gifted Senses", :body => 6, :heart => 6, :wits => 2}
    result[:healing_hands] = {:name => "Healing Hands", :body => 4, :heart => 7, :wits => 3}
    result[:dragon_eyed] = {:name => "Dragon-eyed", :body => 5, :heart => 6, :wits => 3}
    result[:patient_hunter] = {:name => "Patient Hunter", :body => 5, :heart => 5, :wits => 4}
    result
  end
  
  
  
end

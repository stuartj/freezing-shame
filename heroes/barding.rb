require './hero'

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
  
  def self.rewards #modifiers applied to gear
    super + [:daling_longbow, :spear_of_king_bladorthin, :tower_shield] 
  end
  
  def self.backgrounds
    result = Hash.new
    result["By Hammer and Anvil"] = {:body => 5, :heart => 7, :wits => 2}
    result["Wordweaver"] = {:body => 4, :heart => 6, :wits => 4}
    result["Gifted Senses"] = {:body => 6, :heart => 6, :wits => 2}
    result["Healing Hands"] = {:body => 4, :heart => 7, :wits => 3}
    result["Dragon-eyed"] = {:body => 5, :heart => 6, :wits => 3}
    result["Patient Hunter"] = {:body => 5, :heart => 5, :wits => 4}
    result
  end
  
  
  
end

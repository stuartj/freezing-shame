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
    super
    #super + [:birthright, :fierce_shot, :kings_men, :swordmaster, :woeful_foresight ] 
  end
  
  def self.rewardGearData 
    [
      { :base => :great_bow, :name => "Dalish Longbow", :quality => :dalish },
      { :base => :spear, :name => "Spear of King Bladorthin", :quality => :bladorthin },
      { :base => :great_shield, :name => "Tower Shield", :quality => :tower }
      ]
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

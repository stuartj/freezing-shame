require './hero'

class GiantSlayingSpear < Weapon
  def initialize
    self.clone( Hero.weapons[:great_spear])
    @name = "Giant Slaying Spear"
  end
  
  def self.to_sym
    :giant_slaying_spear
  end
end

class NobleArmor < Armor
  def initialize
    self.clone( Hero.gear[:leather_corslet] )
    @name = "Noble Armor"
  end

  def self.to_sym
    :noble_armor
  end
end

class GreatSplittingAxe < Weapon
  def initialize
    self.clone( Hero.weapons[:great_axe] )
    @name = "Splitting Axe (Great)"
  end
  
  def self.to_sym
    :great_splitting_axe
  end
end

class SplittingAxe < Weapon
  def initialize
    self.clone (Hero.weapons[:axe] )
    @name = "Splitting Axe"
  end
  
  def self.to_sym
    :splitting_axe
  end
end


class Beorning < Hero
  
  superclass.registerCulture self
    
  def initialize
    super
    puts "Beorning initalizing"
  end
  
  def self.virtues #modifiers applied to self
    super + [:brothers_to_bears, :night_goer, :skin_coat, :great_strength, :twice_baked_honey_cakes ] 
  end
  
  def self.culturalEquipment
    result = super
    [GiantSlayingSpear, NobleArmor, GreatSplittingAxe, SplittingAxe].each do | x |
      result[x.to_sym] = x
    end
    result
  end
  
  def self.rewards #modifiers applied to gear
    super + culturalEquipment.keys 
  end
  
  def self.backgrounds
    result = Hash.new
    result[:child_of_two_folk] = {:name => "Child of Two Folk", :body => 6, :heart => 6, :wits => 2}
    result[:errand_rider] = {:name => "Errand-rider", :body => 7, :heart => 5, :wits => 2}
    result[:head_of_the_family] = {:name => "Head of the Family", :body => 6, :heart => 4, :wits => 4}
    result[:light_foot] = {:name => "Light-foot", :body => 5, :heart => 5, :wits => 4}
    result[:keeper_of_tales] = {:name => "Keeper of Tales", :body => 6, :heart => 5, :wits => 3}
    result[:voice_from_the_past] = {:name => "Voice from the Past", :body => 7, :heart => 4, :wits => 3}
    result
  end

  def weary?
    @wounds > 0 ? false : super
  end
  
  def virtuesAndRewardsList
    super + [:giant_slaying_spear, :noble_armor, :splitting_axe, :skin_coat, :great_strength]
  end
  
  def self.enduranceBase
    24
  end
  
  def self.hopeBase
    8
  end
  
  
  
  def self.spearman
    b = Beorning.new
    b.name = "Beorning Spearman"
    b.setBody 6, 3 # value after comma is favoured bonus
    b.setWits 4, 2
    b.setHeart 4, 1
    b.weapon_skill = 3
    b.weapon = :great_spear
    b.armor = :mail_shirt
    b.shield = :none
    b.helm = :none
 #   b.armor = 3
    b.stance = 6
    return b 
  end
  
end

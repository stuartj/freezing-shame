require './hero'

class Beorning < Hero
  
  superclass.registerCulture self
    
  def initialize
    super
    puts "Beorning initalizing"
  end
  
  def self.virtues #modifiers applied to self
    super + [:brothers_to_bears, :night_goer, :skin_coat, :great_strength, :twice_baked_honey_cakes ] 
  end
  
  def self.rewards #modifiers applied to gear
    super + [:giant_slaying_spear, :noble_armor, :splitting_axe] 
  end
  
  def self.backgrounds
    result = Hash.new
    result["Child of Two Folk"] = {:body => 6, :heart => 6, :wits => 2}
    result["Errand-rider"] = {:body => 7, :heart => 5, :wits => 2}
    result["Head of the Family"] = {:body => 6, :heart => 4, :wits => 4}
    result["Light-foot"] = {:body => 5, :heart => 5, :wits => 4}
    result["Keeper of Tales"] = {:body => 6, :heart => 5, :wits => 3}
    result["Voice from the Past"] = {:body => 7, :heart => 4, :wits => 3}
    result
  end
  
  
  
  def isWeary
    false
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

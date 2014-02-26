require './hero'

class Beorning < Hero
  
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

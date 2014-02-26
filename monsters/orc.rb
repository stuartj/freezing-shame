require './monster'

class Orc < Monster
  
  def initialize
    super
    puts "Orc initializing"
  end
  
  def self.weapons
    result = super
    result[:orc_axe] = Weapon.new( "Orc-axe", 5, 12, 16, 0, :sheild_smash );
    return result
  end
  
  def self.armors
    result = super
    result[:orc_armor] = Armor.new("Orc armor", 3, 0)
    return result
  end
  
  
  
  def self.chieftan
    o = Orc.new
    o.name = "Orc Chieftan"
    o.attribute_level = 5
    o.max_endurance = 20
    o.max_hate = 5
    o.parry = 4
    o.shield = :shield
    o.armor = :orc_armor
    o.helm = :none
    o.weapon = :orc_axe
    o.weapon_skill = 3
    return o
  end

end

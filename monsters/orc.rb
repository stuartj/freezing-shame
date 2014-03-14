require './monster'

class Orc < Monster
  
  def initialize
    super
    puts "Orc initializing"
  end
  
  
  def self.armors
    result = super
    result[:orc_armor] = Armor.new("Orc armor", 3, 0)
    return result
  end
  
  def self.weapons
    result = super
    result[:bent_sword] = Weapon.new( "Bent Sword", 4, 10, 12, 0, :one_handed, :disarm );
    result[:bow_of_horn] = Weapon.new( "Bow of Horn", 4, 10, 12, 0, :ranged, :poison)
    result[:broad_bladed_sword] = Weapon.new("Broad-bladed Sword", 5, 10, 14, 0, :one_handed, :poison)
    result[:broad_headed_spear] = Weapon.new("Broad-headed Spear", 5, 10, 12, 0, :one_handed, :pierce)
    result[:heavy_scimitar] = Weapon.new("Heavy Scimitar", 7, 10, 14, 0, :two_handed, :break_shield)
    result[:orc_axe] = Weapon.new( "Orc-axe", 5, 12, 16, 0, :one_handed, :break_shield );
    result[:spear] = Weapon.new("Spear", 4, 9, 12, 0, :versatile, :pierce)
    result
  end
  
  def self.types
    result = {}
    result[:chieftan] = { :name => "Orc Chieftan", :attribute_level => 5, :endurance => 20, :hate => 5, :parry => 4, :armor => 3, :shield => 3, :weapons => { :orc_axe => 3}, :abilities => [:hate_sunlight, :snake_like_speed, :horrible_strength, :commanding_voice] }
    result[:great] = { :name => "Great Orc", :attribute_level => 7, :endurance => 48, :hate => 8, :parry => 5, :armor => 4, :shield => 2, :weapons => { :heavy_scimitar => 3, :broad_headed_spear => 3, :orc_axe => 2}, :abilities => [:horrible_strength, :commanding_voice, :hideous_toughness, :great_size]}
    result[:snaga_tracker] = { :name => "Snaga Tracker", :attribute_level => 2, :endurance => 8, :hate => 2, :parry => 3, :armor => 2, :shield => 0, :weapons => { :bow_of_horn => 2, :jagged_knife => 2 }, :abilities => [:hate_sunlight, :snake_like_speed]}
    result[:black_uruk] = { :name => "Black Uruk", :attribute_level => 5, :endurance => 20, :hate => 4, :parry => 5, :armor => 2, :shield => 2, :weapons => { :broad_bladed_sword => 2, :broad_headed_spear => 2 }, :abilities => [:horrible_strength] }
    result[:messenger_of_lugburz] = { :name => "Messenger of Lugburz", :attribute_level => 4, :endurance => 18, :hate => 5, :parry => 4, :armor => 2, :weapons => { :heavy_scimitar => 2, :jagged_knife => 3}, :abilities => [:hate_sunlight, :snake_like_speed, :commanding_voice]}
    result
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

Monster.register Orc


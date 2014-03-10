#require 'sinatra'
#require 'dm-sqlite-adapter'
#require 'data_mapper'

#require './opponent'

#DataMapper::setup(:default, 'sqlite3::memory')

require './equipment'

class Weapon < Equipment
  
  attr_accessor :name, :damage, :edge, :injury, :encumbrance, :type, :called_shot_effect
  
  #need to add something about ranged or melee? and how it is being used if either?

  def initialize( name, damage, edge, injury, encumbrance, type, called_shot_effect )
    super( name, encumbrance )
    @damage = damage
    @edge = edge
    @injury = injury
    @type = type
    @called_shot_effect = called_shot_effect
  end
  
  # use this for cloning equipment
  def clone( base_weapon )
    super( base_weapon )
    @damage = base_weapon.damage
    @edge = base_weapon.edge
    @injury = base_weapon.injury
    @type = base_weapon.type
    @called_shot_effect = base_weapon.called_shot_effect
  end
  
  def rollModifier
    if( @qualities.include? :dalish_longbow)
      return -1
    end
    0
    # have to update this for different special weapons
  end
  
  def allows_shield?
    (@type == :one_handed) || (@type == :versatile)
  end
  
  def self.fist
    Weapon.new( "Unarmed", 1, 13, 0, 0, nil)
  end
  
  def damage
    (@qualities.include? :grievous) ? @damage + 2 : @damage
  end
  
  def edge
    (@qualities.include? :keen) ? [(@edge-1),10].min : @edge
  end
  
  def injury
    (@qualities.include? :fell) ? @injury + 2 : @injury
  end
end

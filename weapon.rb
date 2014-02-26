#require 'sinatra'
#require 'dm-sqlite-adapter'
#require 'data_mapper'

#require './opponent'

#DataMapper::setup(:default, 'sqlite3::memory')

require './equipment'

class Weapon < Equipment
  
  attr_accessor :name, :damage, :edge, :injury, :encumbrance, :called_shot_effect
  
  def initialize( name, damage, edge, injury, encumbrance, called_shot_effect )
    super( name, encumbrance )
    @damage = damage
    @edge = edge
    @injury = injury
    @called_shot_effect = called_shot_effect
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
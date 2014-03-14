#require 'sinatra'
#require 'dm-sqlite-adapter'
#require 'data_mapper'

#require './opponent'

#DataMapper::setup(:default, 'sqlite3::memory')

require './equipment'

class Gear < Equipment
  
  attr_accessor :value
  
  def self.none
    self.new( "None", 0, 0 )
  end
  
  def encumbrance
    (@qualities.include? :cunning_make) ? [(@encumbrance-2),0].max : @encumbrance
  end
  
  def initialize( name, value, encumbrance )
    super( name, encumbrance )
    @value = value # prot for armor and helms, parry for shields
  end
  
  # use this for cloning equipment
  def clone( base_gear )
    super( base_gear )
    @value = base_gear.value
  end
  
end

class Protection < Gear
  
  def value
    (@qualities.include? :close_fitting) ? @value + 1 : @value
  end
  
end

class Armor < Protection

end 

class Helm < Protection
  
end

class Shield < Gear
  
  attr_accessor :is_broken
  
  def is_broken=(newbroken)
    if !(@qualities.include? :reinforced) || newbroken # if it's not reinforced, or new value is true
      @is_broken=(newbroken)
    end
    @is_broken
  end
  
  def value
    if (@qualities.include? :reinforced)
      @value + 1
    elsif is_broken 
      0
    end
    @value
  end
  
  # use this for cloning equipment
  def clone( base_shield )
    super( base_shield )
    @is_broken = false
  end
  
  
  def initialize( name, value, encumbrance )
    super
    @is_broken = false
  end
end
  
  
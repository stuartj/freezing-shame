class Equipment
  
  require 'set'
  
  #ugh...Equipment.qualities works just like Opponent.feats...have to refactor at some point
  
  attr_accessor :encumbrance, :qualities, :name
  
  def initialize( name, encumbrance )
    @name = name
    @encumbrance = encumbrance
    @qualities = Set.new # ahhhh....forget bit masks and just keep an array
  end
  
  # use this for cloning equipment
  def clone( base_item )
    @name = base_item.name
    @encumbrance = base_item.encumbrance
  end
  
  
  def applyQuality( symbol ) 
    qualities.add symbol
  end    
  
  def self.to_sym
    :equipment
  end
  
end

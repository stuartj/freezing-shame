class Equipment
  
  require 'set'
  
  #ugh...Equipment.qualities works just like Opponent.feats...have to refactor at some point
  
  attr_accessor :encumbrance, :qualities, :name
  
  def initialize( name, encumbrance )
    @name = name
    @encumbrance = encumbrance
    @qualities = Set.new # ahhhh....forget bit masks and just keep an array
  end
  
  def applyQuality( symbol ) 
    qualities.add symbol
  end    
  
end

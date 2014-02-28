require './hero'

class Woodman < Hero
  
  superclass.registerCulture self

  def self.enduranceBase
    20
  end
  
  def self.hopeBase
    10
  end
  
  def self.virtues #modifiers applied to self
    super + [:a_hunters_resolve, :herbal_remedies, :hound_of_mirkwood, :natural_watchfulness, :staunching_song ] 
  end
  
  def self.rewards #modifiers applied to gear
    super + [ :bearded_axe, :feathered_armor, :shepherds_bow, :shepherds_great_bow ] 
  end
  
  
end

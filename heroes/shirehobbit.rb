require './hero'

class ShireHobbit < Hero
  
  superclass.registerCulture self

  def self.cultureName
    "Hobbit of the Shire"
  end
  
  
  def self.enduranceBase
    16
  end
  
  def self.hopeBase
    12
  end
  
  def self.virtues #modifiers applied to self
    super + [:art_of_disappearing, :brave_at_a_pinch, :fair_shot, :tough_in_the_fibre, :small_folk ] 
  end
  
  def self.rewards #modifiers applied to gear
    super + [:bow_of_the_north, :kings_blade, :lucky_armor] 
  end
  
end

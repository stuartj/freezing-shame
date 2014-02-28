require './hero'

class MirkwoodElf < Hero

  superclass.registerCulture self

  def self.cultureName
    "Elf of Mirkwood"
  end
  
  def self.enduranceBase
    22
  end
  
  def self.hopeBase
    8
  end
  
  def self.virtues #modifiers applied to self
    super + [:deadly_archery, :elvish_dreams, :shadow_bane, :the_speakers, :woodelf_magic ] 
  end
  
  def self.rewards #modifiers applied to gear
    super + [:bitter_spear, :spearmans_shield, :woodland_bow] 
  end
  
  
  
end

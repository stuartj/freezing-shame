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
  
  def self.backgrounds
    result = Hash.new
    result[:newhope] = {:name => "New Hope", :body => 5, :heart => 2, :wits => 7}
    result[:amusicallegacy] = {:name => "A Musical Legacy", :body => 5, :heart => 4, :wits => 5}
    result[:memoryofsuffering] = {:name => "Memory of Suffering", :body => 5, :heart => 3, :wits => 6}
    result[:nobleblood] = {:name => "Noble Blood", :body => 4, :heart => 4, :wits => 6}
    result[:wildatheart] = {:name => "Wild at Heart", :body => 4, :heart => 3, :wits => 7}
    result[:envoyoftheking] = {:name => "Envoy of the King", :body => 6, :heart => 2, :wits => 6}
    result
  end
  
  
end

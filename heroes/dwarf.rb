require './hero'

class Dwarf < Hero
  
  def self.weapons
     result = super
     result[:mattock] = Weapon.new( "Mattock", 8, 10, 18, 3, nil );
     return result
   end
   
   def self.enduranceBase
     28
   end

   def self.hopeBase
     6
   end
   
  
  
end

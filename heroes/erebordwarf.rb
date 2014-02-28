require './hero'

class EreborDwarf < Hero

  superclass.registerCulture self

  
  def self.cultureName
    "Dwarf of Erebor"
  end
  
  
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
   
   def self.virtues #modifiers applied to self
     super + [:broken_spells, :durins_way, :old_hatred, :ravens_of_the_mountain, :the_stiff_neck_of_dwarves ] 
   end

   def self.rewards #modifiers applied to gear
     super + [:axe_of_the_azanulbizar, :dwarf_wrought_hauberk, :helm_of_awe] 
   end
   
   
  
  
end

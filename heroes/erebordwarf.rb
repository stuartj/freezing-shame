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
   
   def self.backgrounds
     result = Hash.new
     result[:a_life_of_toil] = {:name => "A Life of Toil",:body => 6, :heart => 2, :wits => 6}
     result[:far_trader] = {:name => "Far Trader",:body => 7, :heart => 2, :wits => 5}
     result[:bitter_exile] = {:name => "Bitter Exile",:body => 7, :heart => 3, :wits => 4}
     result[:eloquent_orator] = {:name => "Eloquent Orator",:body => 5, :heart => 4, :wits => 5}
     result[:a_lesson_in_revenge] = {:name => "A Lesson in Revenge",:body => 6, :heart => 3, :wits => 5}
     result[:a_penetrating_gaze] = {:name => "A Penetrating Gaze",:body => 6, :heart => 4, :wits => 4}
     result
   end
  
  
end

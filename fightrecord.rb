require './dice'

class FightRecord
  
  attr_accessor :events
  
  def initialize
    @events = []
  end
  
  def lastDice
    i=1
    while(i <= @events.size)
      d = @events[@events.size-i][:dice]
      if d
        return d
      end
      i += 1
    end
    puts "Error: no last dice in events"
    nil
  end
      
  def self.compile array
    results = {}
    array.each do |record|
      record.events.each do |event|
        if !results[event[:player]] 
          h = {:hits=>0,:weary=>0,:attacks=>0,:wounds=>0,:armor_checks=>0,:pierces=>0,:deaths=>0}
          results[event[:player]] = h
        end
      
        stats = results[event[:player]]
      
        case event[:type]
        when :attack
          stats[:attacks] += 1
          if event[:dice].test event[:value]
            stats[:hits] += 1
          end
          if event[:dice].weary
            stats[:weary] += 1
          end
        when :pierce
          stats[:pierces] += 1
        when :armor_check
          stats[:armor_checks] += 1
        when :wound
          stats[:wounds] += 1
        when :dies
          stats[:deaths] += 1
        end
      end
    end
    results
  end
       
  
  def addEvent( player, type, dice, value=0 )
    h = { :player => player, :type => type, :dice => ( dice ? dice.clone : nil), :value => value }
    @events.push h
  end
  
  def to_html
    result = ""
    @events.each do | event |
      result += "<br>"
      if( event[:type] != :attack )
        result += "--"
      end
      
      case event[:type]
      when :attack  
        result += event[:player] + " attacks and rolls " + event[:dice].to_s
      when :pierce 
        result += "Pierce!"
      when :armor_check
        result += event[:player] + " rolls armor: " + event[:dice].to_s + " vs. " + event[:value].to_s
      when :wound
        result += event[:player] + " is <b>wounded</b> (" + event[:value].to_s + " total)"
      when :dies
        result += event[:player] + " dies."
      when :damage
        result += event[:player] + " <b>takes " + event[:value].to_s + " damage</b>."
      when :health_remaining
        result += event[:player] + " has<b> " + event[:value].to_s + " health left</b>."
      else
        result += event.to_s + " not handled."
      end
            
    end
    result
  end
  
end
class Dice
  
  attr_accessor :rolls, :feat, :weary
  
  def initialize
    self.reset
  end
  
  def reset
    @feat = 0
    @weary = false
    @rolls = []
  end
  
  def sauron?
    @feat == 11
  end
  
  def gandalf?
    @feat == 12
  end
  
  def to_s   
    returnString = "("
    
    if self.sauron?
      returnString += "S"
    elsif self.gandalf?
      returnString += "G"
    else
      returnString += @feat.to_s
    end
    returnString += "|" 
    @rolls.each do |i|
      returnString += i.to_s
    end
    returnString += ")=" 
    
    #total
    if self.gandalf?
      returnString += "A"
    elsif self.sauron?
      returnString += "F"
    else
      returnString += self.total.to_s
    end
    
    if !self.sauron?
      returnString += (["","+","++"][[self.tengwars,2].min]).to_s
    end
    
    return returnString
  end
  
  def statsTest( dice, tn, weary=false )
    wins = 0
    eyes = 0
    10000.times do |i|
      self.reset
      self.roll( dice, weary )
      puts self.to_s
      if self.sauron?
        eyes += 1
      end
      wins += ((self.test tn) ? 1 : 0)
    end
    puts "win: " + (wins / 100).to_s + "%"
    puts "Saurons: " + eyes.to_s
  end
                
  def test( tn )
    if self.sauron?
      return false
    elsif self.gandalf? || (self.total >= tn)
      return true
    else
      return false
    end
    false
  end
  
  def total
    @feat + ((@rolls.length > 0) ? @rolls.inject{|sum,x| sum + x } : 0)
  end
  
  def tengwars
    @rolls.count{ |d| d == 6 }
  end
  
  def clone
    d = Dice.new
    d.feat = @feat
    d.rolls = @rolls
    d.weary = @weary
    d
  end
  
  def roll(dice, weary=false, advantage=0)
    self.reset
    @weary = weary
    @feat = rand(12) + 1
    
#    puts "Mod :" + mod.to_s

    # options == 1 means roll feat twice take highest, options == -1 means take lowest
    if advantage != 0
      feat2 = rand(12) + 1
      puts "Feat2: " + feat2.to_s
      if advantage < 0 
        @feat = [@feat,feat2].min
      else
        @feat = [@feat,feat2].max
      end
    end
    
    
    dice.times do
      roll = rand(6) + 1
      if @weary && roll < 4
        roll = 0
      end
 
      @rolls.push roll
    end
  end
end
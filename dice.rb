class Dice
  
  attr_accessor :total, :sauron, :gandalf, :tengwars, :feat
  
  def initialize
    self.reset
  end
  
  def reset
    @gandalf = false
    @sauron = false
    @total = 0
    @feat = 0
    @tengwars = 0
    @rolls = []
  end
  
  def to_s
    
    returnString = ""
    
    if @sauron
      returnString += "S"
    elsif @gandalf
      returnString += "G"
    else
      returnString += @feat.to_s
    end
    returnString += "+(" 
    @rolls.each do |i|
      returnString += i.to_s
    end
    returnString += ")=" + @total.to_s + "|" + (["-","+","++"][[@tengwars,2].min]).to_s
    
    @tengwars.to_s
    return returnString
  end
                
  def test( tn )
    if @sauron
      return false
    elsif @gandalf || @total >= tn
      return true
    else
      return false
    end
    false
  end
  
  def roll(dice, weary=false, mod=0)
    self.reset
    @feat = rand(12) + 1
    
#    puts "Mod :" + mod.to_s

    # options == 1 means roll feat twice take highest, options == -1 means take lowest
    if mod != 0
      feat2 = rand(12) + 1
      puts "Feat2: " + feat2.to_s
      if mod < 0 
        @feat = [@feat,feat2].min
      else
        @feat = [@feat,feat2].max
      end
    end
    
#    puts "Feat: " + feat.to_s
 
    if @feat == 11
      @sauron = true
    elsif @feat == 12
      @gandalf = true
    end
    
    @total = @total + @feat
    
    dice.times do
      roll = rand(6) + 1
      @rolls.push ( weary ? 0 : roll )
#      puts roll

      if roll < 4 && weary
        roll = 0
      elsif roll == 6
        @tengwars = @tengwars + 1
      end
 
      @total = @total + roll
    end
  end
end
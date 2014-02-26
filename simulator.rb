require 'sinatra'

Dir["./monsters/*"].each {|file| require file }
Dir["./heroes/*"].each {|file| require file }


def fight( opponent1, opponent2 )
  opponent1.reset
  opponent2.reset
  
  result = {}
  
  rounds = 0
  
  while opponent1.alive? && opponent2.alive?
    rounds += 1
    opponent1.attack( opponent2, true )
    if opponent2.alive?
      opponent2.attack( opponent1, true )
    end
  end
  rounds # return the number of rounds it took
end

o = Orc.chieftan
b = Beorning.spearman

o.reset
b.reset

playerWins = 0
iterations = 100
iterations.times do | i |
  puts "\n#" + i.to_s + "\n"
  if( i % 2 == 0 )
    fight(o,b)
  else
    fight(b,o)
  end
  [o,b].each do | p |
    puts p.name + (p.alive? ? (" wins with " + (p.endurance * 100 / p.maxEndurance).to_s + "% health.") : " dies.")
  end
  if b.alive?
    playerWins+=1
  end
end

puts "Player Wins " + (playerWins * 100 / iterations).to_s + "% of the time."
  

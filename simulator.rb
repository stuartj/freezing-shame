require 'sinatra'
require 'haml'

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


get '/index' do
  @foo = "bar"
  erb :index
end

get '/' do
  @o = Orc.chieftan
  @b = Beorning.spearman

  @o.reset
  @b.reset

  playerWins = 0
  iterations = 100
  iterations.times do | i |
    "\n#" + i.to_s + "\n"
    if( i % 2 == 0 )
      fight(@o,@b)
    else
      fight(@b,@o)
    end
    [@o,@b].each do | p |
      p.name + (p.alive? ? (" wins with " + (p.endurance * 100 / p.maxEndurance).to_s + "% health.") : " dies.")
    end
    if @b.alive?
      playerWins+=1
    end
  end
  
  haml :index

#  "Player Wins " + (playerWins * 100 / iterations).to_s + "% of the time."

end

# get('/'){ haml :index }
get('/response'){  "Hello from the server" }
get('/time'){ "The time is " + Time.now.to_s }

post('/chooseculture') do
  puts "Choose culture fired!"
  params[:culture]
  #"[Foo, Bar, Baz]"
end

post('setculture') do
  params[:culture]
end

=begin 
post('/sethero') do
  hero = Object::const_get(params[:culture])
  hero.Class.to_s
  "test"
end
=end
post('/reverse'){ params[:word].reverse }

  

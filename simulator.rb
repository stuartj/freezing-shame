require 'sinatra'
# require 'sinatra/partial'
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
  iterations = 1
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

post('/setculture') do
  puts "Set culture fired!"
  puts params
  partial( :backgroundform, :layout => false, :locals => {:culture=>params[:culture], :params=>params } )
  #"[Foo, Bar, Baz]"
end

post('/setbackground') do
  puts "Set backbround fired!"
  puts "Background: " + params.to_s
  partial( :featform, :layout => false, :locals => { :background => params[:background], :culture => params[:culture], :params => params} )
end

post('/setfeats') do
  puts "Set feats fired!"
  puts "Feats: " + params.to_s
  partial( :weaponform, :layout => false, :locals => {:culture => params[:culture], :params => params} )
end

=begin 
post('/sethero') do
  hero = Object::const_get(params[:culture])
  hero.Class.to_s
  "test"
end
=end
post('/reverse'){ params[:word].reverse }

  

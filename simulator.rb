require 'rubygems'
require 'sinatra'
require 'sinatra/partial'
require 'haml'

Dir["./monsters/*"].each {|file| require file }
Dir["./heroes/*"].each {|file| require file }



def deathmatch( opponent1, opponent2, iterations )
  resultString = nil
  playerWins = 0
  stats = []
  iterations.times do | i |
    opponent1.reset
    opponent2.reset
    
#    if i==(iterations-1)
#      resultString = ""
#    end
    if( rand(2) == 1 )
      stats.push opponent1.attack( opponent2 )
    else
      stats.push opponent2.attack( opponent1 )
    end
    if opponent1.alive?
      playerWins+=1
    end
  end
#  resultString += "<p> Player wins: " + (playerWins * 100.0 / iterations).round(1).to_s + "%."
#  resultString

# if run once, return combat log as text
  if iterations == 1
    return stats.last.to_html   # turn this into a partial at some point
  end
  
  #otherwise return stats page
  partial( :stats, :locals => { :iterations => iterations, :stats => FightRecord.compile(stats)})
end

def statsToHtml compiledStats
  result = "<table padding=5 border=1>"
  result += "<tr><th>Name</th><th>Win</th><th>Hit</th><th>Weary</th><th>Prot Rolls</th><th>Resist</th></tr>"
  
  compiledStats.keys.sort.each do |key|
    entry = compiledStats[key]
    result += "<tr>"
    result += "<td>" + key.to_s + "</td>"
    h = entry[:hits]
    m = entry[:misses]
    p = entry[:pierces]
    w = entry[:wounds]
    d = entry[:deaths]
    weary = entry[:weary]
    result += "<td align=center>" + ((10000 - d) / 100).to_s + "%</td>"
    result += "<td align=center>" + (h * 100 / (h + m)).to_s + "%</td>"
    result += "<td align=center>" + (weary * 100 / (h + m)).to_s + "%</td>"
    result += "<td align=center>" + p.to_s + "</td>"
    result += "<td align=center>" + ((p - w) * 100 / p).to_s + "%</td>"
    result += "</tr>"
  end
  result += "</table>"
  result
end
  

get '/index' do
  @foo = "bar"
  erb :index
end

get '/' do
#  @b = Beorning.spearman

  haml :index

#  "Player Wins " + (playerWins * 100 / iterations).to_s + "% of the time."

end

# get('/'){ haml :index }
get('/response'){  "Hello from the server" }
get('/time'){ "The time is " + Time.now.to_s }

post('/setculture') do
  puts "Set culture fired!"
  puts params
  partial( :heroform, :layout => false, :locals => {:culture=>params["culture"], :params=>params } )
  #"[Foo, Bar, Baz]"
end

get('/monstertype') do
  puts params
  partial( :monstertype, :layout => false, :locals => {:monsterclass => params["monsterclass"]})
end

get('/backgrounds') do
  partial( :backgrounds, :layout => false, :locals => {:culture => params["culture"]})
end

get('/gear') do
  culture = ( (params.keys.include? "culture") ? params["culture"] : "Hero" )  
  rewards = ((params.keys.include? "rewards") ? params["rewards"] : [] )
  puts "Rewards: " + rewards.to_s
  partial( :gear, :layout => false, :locals => {:culture => culture, :rewards=>rewards})
end

get('/attributes') do
  partial( :attributes, :layout => false, :locals => {:attributes =>{:body => params[:body], :heart => params[:heart], :wits => params[:wits]}})
end

get('/feats') do
  partial( :feats, :layout => false, :locals => { :culture => params[:culture]})
end

post('/masterform') do
  hero = Hero.fromParams params
  monster = Monster.fromParams params
  iterations = params["iterations"].to_i
  deathmatch( hero, monster, (iterations == 1 ? 1 : 1000)  )  
end

post('/sethero') do
  puts "Set hero fired! Values:"
  params.keys.each do |key|
    puts key.to_s + "(" + key.class.to_s + ") : " + params[key]
  end
  iterations = params[:iterations].to_i
  puts "Iterations: " + iterations.to_s
  hero = Hero.fromParams params
  puts "Hero: " + hero.to_s
  deathmatch( hero, (Spider.createType :tauler, :beak), iterations )  
end




post('/setbackground') do
  puts "Set backbround fired!"
  puts "Background: " + params.to_s
  partial( :weaponform, :layout => false, :locals => { :background => params[:background], :culture => params[:culture], :params => params} )
end

post('/setfeatsandbackground') do
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

  

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Josiane")
player2 = Player.new("José")

while player1.life_points > 0 && player2.life_points > 0

    puts "\n Nos joueurs se présentent ainsi"

    player1.show_state
    player2.show_state

    puts "\n Passons à la phase d'attaque :"

    player1.attacks(player2)

    if player2.life_points <=0
        break
    end

    player2.attacks(player1)

end


binding.pry
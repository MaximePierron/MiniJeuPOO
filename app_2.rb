require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

enemies = []

def render_ascii_art
    File.readlines("ascii_art.txt") do |line|
      puts line
    end
end

def render_ascii_art_2
    File.readlines("ascii_art_2.txt") do |line|
      puts line
    end
end

puts render_ascii_art
puts render_ascii_art_2

puts "Quel est ton prénom, guerrier-re ?"
@name = gets.chomp
human_player = HumanPlayer.new(@name)

enemies << player1 = Player.new("Josiane")
enemies << player2 = Player.new("José")

puts "Tes ennemis sont #{enemies.join(' ')}"

while human_player.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)

    human_player.show_state

    puts "Quelle action veux-entreprendre ? \n a- Chercher une meilleure arme ? \n b- Chercher du heal ? \n c- Heal? \n\n Attaquer un joueur proche ? \n 0-#{player2.name} a #{player2.show_state} PV \n 1-#{player1.name} a #{player1.show_state} PV \n"
    réponse = gets.chomp
    if réponse == "a"
        action = human_player.search_weapon
    elsif réponse == "b"
        action =human_player.looks_for_heal
    elsif réponse == "c"
        action = human_player.wants_to_heal
    elsif réponse == "0"
        action = human_player.attacks(player2)
    elsif réponse =="1"
        action = human_player.attacks(player1)
    else
        puts "Commande inconnue"
    end

    puts "Les autres joueurs t'attaquent !"
    enemies.each do |player| player.attacks(human_player) if player.life_points > 0 end
end

binding.pry
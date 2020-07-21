require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def render_ascii_art_1
    File.readlines("ascii_art.txt") do |line|
        puts line
    end
end
    
def render_ascii_art_2
    File.readlines("ascii_art_2.txt") do |line|
        puts line
    end
end
    
puts render_ascii_art_1
puts render_ascii_art_2

puts "Quel est ton prénom, guerrier-re ?"
@name = gets.chomp

new_game = Game.new(@name)

while new_game.is_still_ongoing? == true
    new_game.show_players
    new_game.menu
    réponse = gets.chomp
    new_game.menu_choice(réponse)
    new_game.enemies_attack
end
new_game.end


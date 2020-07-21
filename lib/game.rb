class Game
    attr_accessor :human_player, :enemies
    @enemies= []
    @enemy = []

    def initialize(human_player_name)
        
        @human_player = HumanPlayer.new(human_player_name)
        bot1 = Player.new("Bot1")
        bot2 = Player.new("Bot2")
        bot3 = Player.new("Bot3")
        bot4 = Player.new("Bot4")
        @enemies = [bot1, bot2, bot3, bot4]
        puts "Tes ennemis sont : \n\n"
        for item in @enemies
            puts item.name
        end
    end

    def kill_player(player)
        @enemies = @enemies - player
    end

    def is_still_ongoing?
        if @enemies.length > 0 && human_player.life_points >0
            return true
        else false
        end
    end

    def show_players
        human_player.show_state
        puts "\nEnnemis restants : #{@enemies.length}\n"
    end

    def menu
        @enemy = @enemies.sample(2)
        puts "\nTu as deux ennemis proches #{@enemy}.\n"

        puts "\nQuelle action veux-entreprendre ? \n a- Chercher une meilleure arme ? \n b- Chercher du heal ? \n c- Heal? 
        \n\nAttaquer un joueur proche ? \n 0-#{@enemy[0].name} avec ses #{@enemy[0].show_state} PV \n 1-#{@enemy[1].name} avec ses #{@enemy[1].show_state} PV \n"
    end

    def menu_choice(réponse)
        if réponse == "a"
            action = human_player.search_weapon
        elsif réponse == "b"
            action =human_player.looks_for_heal
        elsif réponse == "c"
            action = human_player.wants_to_heal
        elsif réponse == "0"
            action = human_player.attacks(@enemy[0])
            if @enemy[0].life_points <=0
                kill_player(@enemy[0])
            end
        elsif réponse =="1"
            action = human_player.attacks(@enemy[1])
            if @enemy[1].life_points <=0
                kill_player(@enemy[1])
            end
        else
            puts "Commande inconnue"
        end
    end

    def enemies_attack
        puts "\nLes autres joueurs t'attaquent !\n"
        @enemies.each do |player| player.attacks(human_player) if player.life_points > 0 end
    end

    def end
        if @enemies.length == 0 && human_player.life_points >0
            puts "\nBravo champion !\n"
        else
            puts "\nTu vaus pas un kopek loser !\n"
        end
    end
end



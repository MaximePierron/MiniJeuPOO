class Game
    attr_accessor :human_player, :enemies_in_sight  
    @enemy = []
    @enemies_in_sight= []

    def initialize(human_player_name)
        @players_left = 10
        @human_player = HumanPlayer.new(human_player_name)
        puts "\nTes ennemis sont au nombre de #{@players_left}\n\n"
    end

    def kill_player(player)
        @enemies_in_sight = @enemies_in_sight - player
        @players_left = @players_left - 1 
    end

    def is_still_ongoing?
        if @players_left > 0 && human_player.life_points >0
            return true
        else false
        end
    end

    def new_players_in_sight
        
        if defined?(@enemies_in_sight) == nil

            puts "\nEncore aucun ennemi en vue\n"
            dice = rand(1..6)
            if dice == 1
                puts "\nPas de nouvel ennemi en vue\n"
            elsif dice >= 2 && dice <= 4
                new_enemy = Player.new("Bot#{rand(1..100)}")
                puts "\nUn nouvel ennemi #{new_enemy.name} en vue !\n"
                @enemies_in_sight=[new_enemy]
            else
                new_enemy1 = Player.new("Bot#{rand(100..200)}")
                new_enemy2 = Player.new("Bot#{rand(200..300)}")
                @enemies_in_sight = [new_enemy1, new_enemy2]
                puts "\nDeux nouveaux ennemis #{new_enemy1.name} et #{new_enemy2.name} en vue !\n"
            end

        elsif @enemies_in_sight.length == @players_left
            puts "\nTous les ennemis sont en vue\n"
        else
            dice = rand(1..6)
            if dice == 1
                puts "\nPas de nouvel ennemi en vue\n"
            elsif dice >= 2 && dice <= 4                
                new_enemy = Player.new("Bot#{rand(1..100)}")
                puts "\nUn nouvel ennemi #{new_enemy.name} en vue !\n"
                @enemies_in_sight.push(new_enemy)
            else
                new_enemy1 = Player.new("Bot#{rand(100..200)}")
                @enemies_in_sight.push(new_enemy1)
                new_enemy2 = Player.new("Bot#{rand(200..300)}")
                @enemies_in_sight.push(new_enemy2)
                puts "\nDeux nouveaux ennemis #{new_enemy1.name} et #{new_enemy2.name} en vue !\n"
            end
        end
    end



    def show_players
        human_player.show_state
        puts "\nEnnemis restants : #{@players_left}\n"
        if defined?(@enemies_in_sight) == nil
            puts "\nTu n'as pas d'ennemis en vue.\n"
        else
            puts "\nEnnemis en vue: #{@enemies_in_sight.length}\n"
        end

    end

    def menu
        if defined?(@enemies_in_sight) == nil
            puts "\nTu n'as pas d'ennemis proches.\n"
            puts "\nQuelle action veux-entreprendre ? \n a- Chercher une meilleure arme ? \n b- Chercher du heal ? \n c- Heal?\n"
        else
            @enemy = @enemies_in_sight.sample(2)
            if @enemies_in_sight.length <= 1
                puts "\nTu as #{@enemies_in_sight.length} ennemi proche .\n"

                puts "\nQuelle action veux-entreprendre ? \n a- Chercher une meilleure arme ? \n b- Chercher du heal ? \n c- Heal? 
                \n\nAttaquer un joueur proche ? \n 0-#{@enemy[0].name} avec ses #{@enemy[0].show_state} PV \n"
            else           
                puts "\nTu as #{@enemies_in_sight.length} ennemis proches .\n"

                puts "\nQuelle action veux-entreprendre ? \n a- Chercher une meilleure arme ? \n b- Chercher du heal ? \n c- Heal? 
                \n\nAttaquer un joueur proche ? \n 0-#{@enemy[0].name} avec ses #{@enemy[0].show_state} PV \n 1-#{@enemy[1].name} avec ses #{@enemy[1].show_state} PV \n"
            end
        end
    end

    def menu_choice(réponse)
        if defined?(@enemies_in_sight) == nil        
            if réponse == "a"
                action = human_player.search_weapon
            elsif réponse == "b"
                action =human_player.looks_for_heal
            elsif réponse == "c"
                action = human_player.wants_to_heal
            else
                puts "Commande inconnue"
            end
        elsif @enemies_in_sight.length <= 1
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
            else
                puts "Commande inconnue"
            end
        else     
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
    end

    def enemies_attack
        if defined?(@enemies_in_sight) == nil
            puts "\nTu es tranquil pour ce tour! Pas d'ennemis en vue!\n"
        else
            puts "\nLes autres joueurs t'attaquent !\n"
            @enemies_in_sight.each do |player| player.attacks(human_player) if player.life_points > 0 end
        end
    end

    def end
        if @players_left == 0 && human_player.life_points >0
            puts "\nBravo champion !\n"
        else
            puts "\nTu vaus pas un kopek loser !\n"
        end
    end
end



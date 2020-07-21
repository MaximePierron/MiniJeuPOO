class Player
    attr_accessor :name, :life_points
    
    def initialize(player_name, player_life_points = 25) #on part de ça, le bot a un nol et des PV
        @name = player_name
        @life_points = player_life_points
    end

    def show_state
        puts "\n#{self.name} possède encore #{self.life_points} PV \n"
        return self.life_points
    end

    def gets_damage(damage)
        self.life_points = self.life_points - damage.to_i 
        if self.life_points <=0
            puts "\n#{self.name} is dead \n"
        end
    end

    def compute_damage
        return rand(1..6)
    end

    def attacks(player)

        puts "\n#{self.name} attaque #{player.name} \n"

        attack_force = compute_damage
        

        if attack_force <=3
            puts "\nCe n'est pas très efficace, #{player.name} perd #{attack_force} PV \n"
        else
            puts "\nC'est très efficace, #{player.name} perd #{attack_force} PV \n"
        end
        player.gets_damage(attack_force)

    end
end

class HumanPlayer < Player #hérite de player
    attr_accessor :weapon_level

    def initialize(player_name, player_life_points = 100, weapon_level = 1) #on définit un perso jouable avec son nom, ses PV et son arme
        @weapon_level = weapon_level

        super(player_name, player_life_points) #fait appel au initialize de la classe Player
    end

    def show_state
        puts "\n#{self.name} possède #{self.life_points} PV et une arme de niveau #{self.weapon_level} \n"
        return self.life_points, self.weapon_level
    end

    def compute_damage
        rand(1..6) * @weapon_level
    end

    def search_weapon #action de chercher une arme et de remplacer la nôtre si meilleure
        dice = rand(1..6)
        puts "\nTu as trouvé une arme de niveau #{dice} \n"
        if dice > self.weapon_level
            puts "\nGG champion, cette arme est meilleure que la tienne, tu la prends ! \n"
            self.weapon_level = dice
            puts "\n#{self.name} possède maintenant une arme de niveau #{weapon_level} \n"
        else
            puts "\nPas d'bol, cette arme ne vaut pas mieux que la tienne ! C'est pour dire ! \n"
            puts "\n#{self.name} possède toujours une arme de niveau #{weapon_level} \n"
        end
    end

    def looks_for_heal #cherche du heal et trouve en accord avec une valeur de dé
        dice = rand(1..6)
        @heal_found = 0
        if dice == 1
            puts "\nDommage, tout ça pour rien ! \n"
            @heal_found = 0
        elsif dice >= 2 && dice <=4
            puts "\nGG tu as trouvé une trousse de soin de 25 PV \n"
            @heal_found = 25
        else
            puts "\nIncroyable, une trousse de soin de 50 PV \n"
            @heal_found = 50
        end
        return @heal_found
    end

    def wants_to_heal #tu veux te heal
        if defined?(@heal_found) == nil #tu n'as encore jamais été chercher de heal
            puts "\nTu n'as pas encore été chercher de heal, veux-le faire ? Y/N\n" #te propose d'aller en chercher
            if gets.chomp == "Y"
                self.looks_for_heal
            end
        elsif @heal_found == 0 
            puts "\nTu n'as pas de heal, veux-tu aller en chercher de nouveau ? Y/N \n" #t'avais cherché mais t'avais rien trouvé tu veux y retourner ?
            if gets.chomp == "Y"
                self.looks_for_heal
            end
        else
            puts "\nTu as un heal de #{@heal_found} PV, veux-tu l'utiliser ? Y/N \n"
            if gets.chomp == "Y"
                self.life_points = self.life_points + @heal_found
                @heal_found = 0
                if self.life_points > 100
                    self.life_points = 100
                end
                puts "\nLa santé de #{self.name} est maintenant de #{self.life_points} PV.\n"
            end
        end
    end


end
class Player
    attr_accessor :name, :life_points
    
    def initialize(player_name, player_life_points = 50)
        @name = player_name
        @life_points = player_life_points
    end

    def show_state
        puts "#{self.name} possède encore #{self.life_points} PV"
        return self.life_points
    end

    def gets_damage(damage)
        self.life_points = self.life_points - damage.to_i
        if self.life_points <=0
            puts "#{self.name} is dead"
        end
    end

    def compute_damage
        return rand(1..6)
    end

    def attacks(player)

        puts "#{self.name} attaque #{player.name}"

        attack_force = compute_damage
        

        if attack_force <=3
            puts "Ce n'est pas très efficace, #{player.name} perd #{attack_force} PV"
        else
            puts "C'est très efficace, #{player.name} perd #{attack_force} PV"
        end
        player.gets_damage(attack_force)

    end
end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(player_name, player_life_points = 100, weapon_level = 1)
        @weapon_level = weapon_level # j'ai rajouté cette ligne

        super(player_name, player_life_points) #fait appel au initialize de la classe Event
    end

    def show_state
        puts "#{self.name} possède #{self.life_points} PV et une arme de niveau #{self.weapon_level}"
        return self.life_points, self.weapon_level
    end

    def compute_damage
        rand(1..6) * @weapon_level
    end

    def search_weapon
        dice = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{dice}"
        if dice > self.weapon_level
            puts "GG champion, cette arme est meilleure que la tienne, tu la prends !"
            self.weapon_level = dice
            puts "#{self.name} possède maintenant une arme de niveau #{weapon_level}"
        else
            puts "Pas d'bol, cette arme ne vaut pas mieux que la tienne ! C'est pour dire !"
            puts "#{self.name} possède toujours une arme de niveau #{weapon_level}"
        end
    end

    def looks_for_heal
        heal_found = 0
        if dice == 1
            puts "Dommage, tout ça pour rien !"
            heal_found = 0
            return heal_found
        elsif dice >= 2 && dice <=4
            puts "GG tu as trouvé une trousse de soin de 25 PV"
            heal_found = 25
            return heal_found
        else
            puts "Incroyable, une trousse de soin de 50 PV"
            heal_found = 50
            return heal_found
        end
    end

    def wants_to_heal
        if heal_found == 0
            puts "Tu n'as pas de heal, veux-tu aller en chercher ? Y/N"
            if gets.chomp == "Y"
                self.looks_for_heal
            end
        else
            puts "Tu as un heal de #{heal_found} PV, veux-tu l'utiliser ? Y/N"
            if gets.chomp == "Y"
                self.life_points = self.life_points + heal_found
                if self.life_points > 100
                    self.life_points = 100
                end
            end
        end
    end


end
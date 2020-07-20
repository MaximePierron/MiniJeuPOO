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
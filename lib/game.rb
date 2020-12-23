class Game

  def generate_secret_word
    dictionary = File.open('5desk.txt', 'r').readlines

    legal_words = []

    dictionary.each do |line|
      line = line.chomp
      if line.length >= 5 && line.length <= 12
        legal_words << line
      end
    end

    legal_words.sample
  end

end

g = Game.new

g.generate_secret_word
class Game
  TURN_LIMIT = 6

  def initialize()
    @secret_word = generate_secret_word
    @guessed_letters = []
  end

  def start_game
    puts @secret_word

    display = Array.new(@secret_word.length)
    display.fill('_')
    p display
  end

  def valid_guess?(guess)
    ('a'..'z').include?(guess) && !guesses.include?(guess)
  end

  def make_guess
    puts 'Enter a letter to guess from the secret word'
    guess = gets.chomp
  end

  def generate_secret_word
    dictionary = File.open('5desk.txt', 'r').readlines
    legal_words = []

    dictionary.each do |line|
      word = line.chomp
      if word.length >= 5 && word.length <= 12
        legal_words << line
      end
    end

    legal_words.sample.chomp
  end
end

g = Game.new

g.start_game
class Game
  GUESS_LIMIT = 6

  def initialize()
    @secret_word = generate_secret_word
    @guessed_letters = []
  end

  def start_game
    puts @secret_word
    incorrect_count = 0

    display = Array.new(@secret_word.length)
    display.fill('_')
    p display
    puts "Guesses Left: #{GUESS_LIMIT - incorrect_count}"

    until incorrect_count == GUESS_LIMIT do
      puts 'Already guessed letters'
      p @guessed_letters
      puts
      player_guess = make_guess
      check_guess(player_guess)
    end
  end

  def valid_guess?(player_guess)
    ('a'..'z').include?(player_guess) && !@guessed_letters.include?(player_guess) 
  end

  def legal_word?(word)
    word.length >= 5 && word.length <= 12
  end

  def make_guess
    puts 'Enter a letter to guess from the secret word'
    guess = gets.chomp

    until valid_guess?(guess) do
      puts 'Please enter a letter that you have not guessed before.'
      guess = gets.chomp
    end

    @guessed_letters << guess

    guess
  end

  def check_guess(player_guess, display)
    @secret_word.chars.each_with_index do |char, index|
      puts "#{char} #{index}" if char.downcase == player_guess 
    end
  end

  def generate_secret_word
    dictionary = File.open('5desk.txt', 'r').readlines
    legal_words = []

    dictionary.each do |line|
      word = line.chomp
      if legal_word?(word)
        legal_words << word
      end
    end

    legal_words.sample
  end
end

g = Game.new

g.start_game
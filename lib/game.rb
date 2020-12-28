class Game
  GUESS_LIMIT = 6

  def initialize()
    @secret_word = generate_secret_word
    @guessed_letters = []
    @incorrect_count = 0
    @correct_letters = Array.new(@secret_word.length).fill('_')
  end

  def start_game

    until @incorrect_count == GUESS_LIMIT do
      system "clear"
    
      p @correct_letters

      puts "Guesses Left: #{GUESS_LIMIT - @incorrect_count}"
      puts 'Already guessed letters'
      p @guessed_letters
      puts
      player_guess = make_guess

      if check_guess(player_guess, @correct_letters)
        puts 'Correct Guess'
      else
        puts 'Incorrect Guess!'
        @incorrect_count += 1
      end

      if win?
        puts 'Congratulations! You win!'
        break
      end
    end

    puts "Correct Word: #{@secret_word}"
  end

  def valid_guess?(player_guess)
    ('a'..'z').include?(player_guess) && !@guessed_letters.include?(player_guess) 
  end

  def legal_word?(word)
    word.length >= 5 && word.length <= 12
  end

  def win?
    @correct_letters.join == @secret_word
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
    letter_found = false
    @secret_word.chars.each_with_index do |char, index|
      if char.downcase == player_guess
        display[index] = char
        letter_found = true
      end
    end

    p display

    letter_found
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
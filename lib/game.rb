# frozen_string_literal: true

require 'yaml'

class Game
  GUESS_LIMIT = 8
  attr_accessor :secret_word, :guessed_letters, :incorrect_count, :correct_letters

  def initialize
    @secret_word = generate_secret_word
    @guessed_letters = []
    @incorrect_count = 0
    @correct_letters = Array.new(@secret_word.length).fill('_')
  end

  def to_yaml
    YAML.dump({
                secret_word: @secret_word,
                guessed_letters: @guessed_letters,
                incorrect_count: @incorrect_count,
                correct_letters: @correct_letters
              })
  end

  def from_yaml(string)
    data = YAML.safe_load string
    p data
    @secret_word = data[:secret_word]
    @guessed_letters = data[:guessed_letters]
    @incorrect_count = data[:incorrect_count]
    @correct_letters = data[:correct_letters]
    self
  end

  # Driver for basic game logic.
  def start_game
    until @incorrect_count == GUESS_LIMIT
      system 'clear'

      puts "Secret Word: #{@correct_letters}"

      puts "Guesses Left: #{GUESS_LIMIT - @incorrect_count}"
      puts "Already guessed letters: #{@guessed_letters}"
      puts
      player_guess = make_guess

      @incorrect_count += 1 unless check_guess(player_guess, @correct_letters)

      if win?
        puts 'Congratulations! You win!'
        break
      end
    end

    puts "Correct Word: #{@secret_word}"
  end

  # Check if the guess is an unguessed letter.
  def valid_guess?(player_guess)
    ('a'..'z').include?(player_guess) && !@guessed_letters.include?(player_guess)
  end

  # Filter for length of words in the games dictionary.
  def legal_word?(word)
    word.length >= 5 && word.length <= 12
  end

  # Check if user has found the secret word.
  def win?
    @correct_letters.join == @secret_word
  end

  # Get user input.
  def make_guess
    puts 'Enter a letter to guess from the secret word'
    puts 'Enter "save" to save and exit.'
    guess = gets.chomp

    if guess == 'save'
      save_game
      exit
    end

    # Loop until valid input
    until valid_guess?(guess)
      puts 'Please enter a letter that you have not guessed before.'
      guess = gets.chomp
    end

    @guessed_letters << guess
    guess
  end

  # Display all letters in secret word that were guessed.
  # Returns true if any letter is guessed (including multiple).
  # Returns false if no letters are found.
  def check_guess(player_guess, display)
    letter_found = false
    @secret_word.chars.each_with_index do |char, index|
      if char.downcase == player_guess
        display[index] = char
        letter_found = true
      end
    end
    letter_found
  end

  # Opens file and creates dictionary, filtering out
  # any illegal wrods.
  def generate_secret_word
    dictionary = File.open('5desk.txt', 'r').readlines
    legal_words = []

    dictionary.each do |line|
      word = line.chomp
      legal_words << word if legal_word?(word)
    end

    legal_words.sample
  end

  def save_game
    puts 'Saving...'
    File.open('saves/save.yml', 'w') { |file| file.write(to_yaml) }
  end
end

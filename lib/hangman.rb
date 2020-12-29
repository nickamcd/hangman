require_relative 'game'

class Hangman
  puts 'HANGMAN'
  puts
  puts '(1) New Game'
  puts '(2) Load Game'
  puts '(3) Quit'

  choice = gets.chomp

  g = Game.new

  if choice == '1'
    g.start_game
  elsif choice == '2'
    g = g.from_yaml(File.open('save.yml', 'r'))
    g.start_game
  else choice == '3'
    exit
  end
end
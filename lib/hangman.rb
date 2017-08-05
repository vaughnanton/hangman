require 'yaml'

class Hangman

  def initialize(dictionary)
    @gameover = false
    @wrong_guesses = 0
    @dictionary = dictionary
    @letters_guessed = []
    @current_word = ""
    @word = get_word
  end

  def game_loop
    while !@gameover
      game_status
      guess = get_guess
      guess.upcase == guess_outcome
      @gameover = game_over
      save
    end
    if @wrong_guesses >= 10
      puts "\n\n Max guesses, you lose!"
    else
      puts "\n\n Congratulations, you win!"
    end
  end

  def get_word
		words = []
		chosen_word = ""

		file = File.open(@dictionary).each { |word|
			words << word
		}
		file.close

		loop do
			chosen_word = words[rand(words.length)]
			break if chosen_word.length > 5 && chosen_word.length <= 13
		end

		(chosen_word.length-1).times{@current_word += "*"}

		return chosen_word.upcase
	end

  def game_status
    puts "\nThe current word is: #{@current_word}\n"
    puts @wrong_guesses
    puts "\nLetters you have guessed: #{@letters_guessed.join(", ")}"
    puts "You have #{10-@wrong_guesses} guesses left"
  end

  def get_guess
    guess = ""
    loop do
      print "Guess a letter: "
      guess = gets.chomp
      valid_guess = validity_check(guess)
      break if valid_guess
    end
    return guess
  end

  def validity_check(guess)
    if @letters_guessed.include?(guess.upcase)
      return false
    elsif guess.length != 1
      return false
    elsif guess.match(/^[[:alpha:]]$/)
      @letters_guessed << guess.upcase
      return true
    else
      return false
    end
  end

  def guess_outcome
    if @word.include?(@letters_guessed[-1])
      for i in 0..@word.length-1
        if @letters_guessed[-1] == @word[i]
          @current_word[i] = @word[i]
        end
      end
    else
      @wrong_guesses += 1
    end
  end

  def game_over
    if @wrong_guesses >= 10
      @gameover = true
    elsif
      for i in 0..@current_word.length
        if @current_word[i] == "*"
          return false
        end
      end
    end
    return true
  end

end

def load
  if File.exists?("saves/save_file.yaml")
    content = File.open("saves/save_file.yaml", "r") { |file| file.read }
    YAML.load(content)
  else
    puts "e r r o r - There is no saved file!"
  end
end

def save
  Dir.mkdir("saves") unless Dir.exist? "saves"
  filename = "saves/save_file.yaml"
  File.open(filename, "w") do |file|
    file.puts YAML.dump(self)
  end
end

to_load = ""
loop do
  print "Do you want to load prior game? (Y/N) : "
  to_load = gets.chomp
  break if to_load.upcase == "Y" || to_load.upcase == "N"
  puts "Incorrect input!"
end


game = to_load.upcase == "Y" ? load : Hangman.new("dictionary.txt")
game.game_loop if File.exists?("saves/save_file.yaml") || to_load.upcase == "N"

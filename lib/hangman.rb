class Hangman

  def initialize
    @gameover = false
    @wrong_guesses = 0
    @letters_guessed = []
    @current_word = ""
    @word = get_word
  end

  def game_loop
    while !@gameover
      print_status
      guess = get_guess
      guess.upcase == guess_outcome
      @gamover = game_over
      save_game
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
    file = File.open("dictionary.txt").each do |line|
      if line.length >= 5 && line.length <= 12
        words << line
    end
    chosen_word = words.sample.upcase
  end

  def print_status
    puts "\nThe current word is: #{@current_word}\n"
    puts @view[@wrong_guesses]
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
    elsif guess.match(/^[[:alpha]]$/)
      @letters_guessed << guess.upacase
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
    else
      for i in 0..@current_word.length
        if @current_word[i] == "*"
          return false
        end
      end
    end
    return true
  end

end
end


Hangman.new

class Hangman
#when you initialize the this is what happens
  def initialize
    @word = ""
    @guess = []
    @false_letters = [""]
    @win = false
    @loss = false
    @turns_remaining = 10
    get_word
    game_loop
  end

#option to open a saved game
  def get_word
    words = []
    chosen_word = ""

    File.open("dictionary.txt").each do |line|
      words << line
    end

    chosen_word = words.rand
    puts chosen_word
  end

  def game_loop
  end


end
#method randomly select a word between 5-12 characters

#method show current guesses : A B C D
#method ask player to guess (case insensitive) or save game
  #if save game, save and exit
  #elsif guess continue below
#method say wehtehr right or wrong
#method show _ _ A _ _ A _ word
#method say how many guesses left
  #if out of guesses player loses

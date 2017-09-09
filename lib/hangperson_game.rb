class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(attempt)
    if /[a-z]/i.match(attempt)==nil
      raise ArgumentError.new("Invalud guess " + attempt.to_s + '.')
    else
      attempt = attempt.downcase
      if @guesses.include? attempt or @wrong_guesses.include? attempt
        false
      elsif @word.include? attempt
        @guesses += attempt
        true
      else
        @wrong_guesses += attempt
        true
      end
    end
  end
  
  def word_with_guesses
    display = '-'*@word.length
    for i in 0...@word.length do
      if @guesses.include? @word[i]
        display[i] = @word[i]
      end
      i+=1
    end
    display
  end

  def check_win_or_lose
    if @word==self.word_with_guesses
      :win
    elsif @wrong_guesses.length==7
      :lose
    else
      :play
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError, 'Guess cannot be nil or empty' if letter.nil? || letter.empty?
    raise ArgumentError, 'Guess must be an alphabetic character' unless letter =~ /^[a-zA-Z]$/

    letter = letter.downcase

    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.downcase.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    true
  end

  def word_with_guesses
    return '-' * @word.length if @guesses.empty?

    @word.chars.map { |c| @guesses.include?(c.downcase) ? c : '-' }.join
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if !@word.empty? && !word_with_guesses.include?('-')

    :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://esaas-randomword-27a759b6224d.herokuapp.com/RandomWord') 
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http| 
      return http.post(uri, "").body
    end
  end
end
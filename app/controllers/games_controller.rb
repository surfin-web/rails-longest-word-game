require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split('')
    @included = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }

    url = "https://dictionary.lewagon.com/#{@word}"
    response = URI.parse(url).read
    json = JSON.parse(response)
    @english_word = json["found"]

    @score = (@included && @english_word) ? @word.length : 0

    session[:grand_total] ||= 0
    session[:grand_total] += @score
    @grand_total = session[:grand_total]
  end
end

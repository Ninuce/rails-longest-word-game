require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)].upcase }
    @letters_str = @letters.join("")
  end

  def score
    @grid = params[:grid]
    @word = params[:word]
    @word_arr = @word.upcase.split("")
    @grid_raw = @grid

    #validate if all letters are in the grid,incl dupe letters
    @word_arr.each do |e|
      if !@grid_raw.include?(e)
        @var = "not in the grid"
        return "x"
      end
      @grid_raw.slice!(@grid_raw.index(e))
    end

    #check if an English word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = open(url).read
    final = JSON.parse(response)

    #if json is found, print well done, if not found, say it is not a n english word
    if final["found"] == true
      @var = "Well done!"
    else
      @var = "Not an English word"
    end
  end
end

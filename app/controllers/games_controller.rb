require 'open-uri'

# games controller
class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    # params[:letters] é uma string com espaços entre as letras, então substitui
    # os espaços por nada e separa as letras em uma array:
    letters = params[:letters].gsub(' ', '').chars
    @letters_list = params[:letters].gsub(' ', ', ')
    @word = params[:word].upcase
    exist = true
    word_letters = params[:word].chars
    word_letters.each do |letter|
      index = letters.index(letter.upcase)
      index.nil? ? exist = false : letters.delete_at(index)
    end
    @message = if exist
                 response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
                 json = JSON.parse(response.read)
                 json['found'] ? 1 : 2
               end
  end
end

require 'json'
require 'open-uri'

class GamesController < ApplicationController
    def new
        @alphabets = ('A'..'Z').to_a
        @letters = @alphabets.sample(9)
    end

    def score 
        @letters = params[:letters]
        @letters_string = @letters.gsub(' ', '')
        @answer = params[:answer].upcase
        url = "https://wagon-dictionary.herokuapp.com/#{@answer.downcase.strip}"
        @heruko = open(url).read
        @word = JSON.parse(@heruko)
    end
end

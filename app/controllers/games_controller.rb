require 'json'
require 'open-uri'

class GamesController < ApplicationController
    def new
        @alphabets = ('A'..'Z').to_a
        @letters = @alphabets.sample(9)
        if session[:score] == nil 
            session[:score] = 0
        end
    end

    def score 
        # variables
        @letters = params[:letters]
        @letters_string = @letters.gsub(' ', '')
        @answer = params[:answer].upcase

        # parsing json
        url = "https://wagon-dictionary.herokuapp.com/#{@answer.downcase.strip}"
        @heruko = open(url).read
        @word = JSON.parse(@heruko)

        # display results
        if (@answer.split('').all?(/[#{@letters_string}]/)) == false
          @not_in_array = true
        elsif @word["found"] == false
          @not_true_word = true
        else
          @score = @answer.split('').size
          session[:score] += @score
          @correct_word = true
        end   
    end
end

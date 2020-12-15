require 'json'

#hi all

#hi there

#hi again

class Game

  attr_accessor :word, :board, :attempts


  def initialize
    @word = []
    @attempts = 1
    @board
    @code_cells
    @guess_cells
    self.load_game
  end  


  def data
    puts @word
    puts @attempts
    puts @board
  end  


  def pick_word
    vocabulary = File.open("vocabulary.txt")
    words = File.read("vocabulary.txt").split    
    
    until @word.length <= 12 && @word.length >= 5 
      @word = words.sample.downcase.split("")
    end   
    
    @board = Array.new(@word.length, '_')

    @code_cells = Array.new(@word.length, '')

    wrd = ''

    (0..@code_cells.length).step do |i|
      wrd += " #{@word[i]} "
    end
  end  


  def field_play
    field = ''
    (0..@board.length - 1).step do |i|
       field += "  #{@board[i]}"
    end
    puts field
  end  

    
  def compare
    self.field_play

    until @attempts >= 10 || @board === @word
      @guess_cells = gets.gsub(/^\(+|\)+$/, '').gsub(' ', '').split("")
          
      self.save_game
           
      puts " "
      puts "Attempt number #{@attempts + 1}:"

      @guess_cells.each_with_index do |guess, guess_index|
        @word.each_with_index do |w, word_index|
          if w == guess && word_index === guess_index
            @board[word_index] = "#{guess}"
          end  
        end
      end
      self.field_play
      @attempts += 1
    end  
  end 


  def save_game
    if @guess_cells == ["1", "\n"]
      puts "Name of the slot?"
      Dir.mkdir("saved") unless Dir.exists?("saved")

      filename = "saved/slot_#{gets}.txt"

      File.open(filename,'w') do |file|
        file.puts "#{@word}"
        file.puts "#{@attempts}"
        file.puts "#{@board}"

      end
      @attempts -= 1
    end
  end


  def load_game
    puts "Do you want to start a new game?"
    if gets.chomp == "n"
      puts "Load name of the slot?"
      
      filename = File.readlines("saved/slot_#{gets}.txt")
      @word = JSON.parse(filename[0])
      @attempts == filename[1].to_i
      @board = JSON.parse(filename[2])

    else 
      self.pick_word
    end
  end  


  def play
    #self.pick_word
    self.compare
  end 
  
  
end



game = Game.new


#game.pick_word
#game.compare

game.play

#game.data

#game.load_game


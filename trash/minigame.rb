class MiniGame

  def initialize
    @number = rand(1..20)
    guess
  end

  def guess
    tries = 5
    until tries == 0
      answer = gets.chomp.to_i
      if answer == @number
        puts "grats"
        return
      end
      if @number > answer
        puts "too little"
      end
      if @number < answer
        puts "too big"
      end
    end
  end

end

MiniGame.new

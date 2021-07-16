require_relative 'interface'

class Game

  attr_accessor :money, :pc, :worker

  def initialize
    @money = 2000
    @ranks = ["F*cking Bum", "Sh*thead Freelancer", "S*cker Enthusiast", "F*cking Startuper",
                      "Wow Real Businessman", "Goddamned Big Boss", "IT-industry God"]
    @buildings = ["Street", "Garage", "Corner in thai beauty saloon", "Own room in sh*tty office building",
                      "Big Office in a cool business center", "Own f*ucking building in Silicon Valley"]
    @pc = 0
    @worker = []
  end

  def buyable(price)
    if price < @money
      @money -= price
      1
    else
      0
    end
  end

  def buy_pc
    if @pc < 10
      price = 100 + @pc * 100
      @pc += buyable(price)
    end
  end

  def hire_worker
    if @worker < 10 && @pc > @worker
      price = 100 + @worker * 100
      @worker += buyable(price)
    end
  end

end

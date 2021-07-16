require_relative 'interface'

class Game

  attr_accessor :status
  attr_reader :money, :capacity, :places, :workers

  def initialize
    @status = true
    @money = 2000
    @ranks = ["Sh*thead Freelancer", "S*cker Enthusiast", "F*cking Startuper",
              "Wow Real Businessman", "Goddamned Big Boss", "IT-industry God"]
    @rank = 0
    @offices = ["Small place near junkyard", "Garage",
                "Corner in thai beauty saloon", "Own room in sh*tty office building",
                "Big Office in a cool business center", "Own f*ucking building in Silicon Valley"]
    @capacity = 2
    @office = 0
    @places = 0
    @workers = []
  end

  def office
    office = @offices[@office]
  end

  def officeUp
    @office += 1 unless @office == @offices.size
  end

  def rank
    rank = @ranks[@rank]
  end

  def rankUp
    @rank += 1 unless @rank == @ranks.size
  end

end

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
    @capacity = 4
    @office = 0
    @places = 2
    @workers = 1
  end

  def officeArt
    withGuy = @workers
    noGuy = @places - @workers
    closed = 10 - @capacity
    avail = @capacity - @places
    ascii1 = File.readlines('ascii/slave')
    ascii2 = File.readlines('ascii/place')
    ascii3 = File.readlines('ascii/avail')
    ascii4 = File.readlines('ascii/empty')
    res = []
    withGuy.times { ascii1.each {|i| res << i} }
    noGuy.times   { ascii2.each {|i| res << i} }
    avail.times   { ascii3.each {|i| res << i} }
    closed.times  { ascii4.each {|i| res << i} }
    res
  end

  def gain
    @money += 0.1
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

  def help
    ["ITeeSim - IT Simulator progresser game,",
     "where your main purpose is to found",
     "huge IT development company:",
     "get big office, set up working places",
     "hire a lot of developers and become",
     "really big boss to overshadow",
     "Elon Mask, Jeff Bezos, Mark Zuckerberg",
     "and other c*cksu*kers!)",
     "Can u get out from this trash heap",
     "and go to be best IT director in da world?"]
  end

end

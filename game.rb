require_relative 'interface'

class Game

  attr_accessor :status
  attr_reader :money, :capacity, :pcs, :devs,:hours, :minutes, :days, :messages

  def initialize
    @status = true
    @money = 2000
    @ranks = ["Sh*thead Freelancer", "S*cker Enthusiast", "F*cking Startuper",
              "Wow Real Businessman", "Goddamned Big Boss", "IT-industry God"]
    @rank = 0
    @offices = ["Small spot near junkyard", "Dusty cr*p Garage",
                "Corner in thai beauty saloon", "Own room in sh*tty office building",
                "Office in a modern business center", "F*cking Silicon Valley headquarters"]
    @capacity = 1
    @office, @pcs, @devs = 0, 0, 0
    @passed_ms, @minutes, @hours, @days = 0, 0, 0, 0
    @messages = Messages.new
  end

  def employDev
    @devs += 1 unless @devs >= @pcs
  end

  def buyPc
    @pcs += 1 unless @pcs - @capacity >= 0
  end

  def officeArt
    withGuy = @devs
    noGuy = @pcs - @devs
    closed = 10 - @capacity
    avail = @capacity - @pcs
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

  def clocksConverter
    @minutes += 1
    @hours += @minutes / 60
    @minutes %= 60
    @days += @hours / 24
    @hours %= 24
  end

  def progress
    @money += 0.1
    @passed_ms += 0.02
    (clocksConverter ; @passed_ms = 0) if @passed_ms > 0.12
  end

  def office
    office = @offices[@office]
  end

  def officeUp
    if @office < @offices.size - 1
      @office += 1 unless @office == @offices.size
      @office < 2 ? @capacity += 1 : @capacity += 2
    end
  end

  def rank
    rank = @ranks[@rank]
  end

  def rankUp
    @rank += 1 unless @rank == @ranks.size
  end

end

class Messages

  def initialize
    @hint = 0
  end

  def hints
    header = "Hint: #{@hint + 1}/3 "
    hint0 = ["Main purpose of the game is to become",
             "a rich director of a giant IT company with",
             "a big office and a lot of employees.",
             "To reach it, you have to complete",
             "development projects.",
             "The more developers you have, the easier",
             "it will be to carry out these projects"]
    hint1 = ["At the start u have 0/1 workplaces it",
             "means that your office can accomodate",
             "1 computers but you have 0, for this",
             "reason you have 0/0 devs, it means",
             "that u can't hire any developer",
             "cause you don't have computers yet.",
             " ", "When you upgrade office,buy 2 computers and",
             "hire an employee, you would have 2/2",
             "workplaces and 1/2 devs"]
    hint2 = ["Difficulty of the projects affects",
             "the completion time and the reward,",
             "easier projects completes faster, but",
             "profit is lower.", " ",
             "It is not recommended to start big",
             "projects without enough developers",
             "in your company."]
    hints = [] << hint2 << hint0 << hint1
    (@hint > (hints.size - 2)) ? @hint = 0 : @hint += 1
    return hints[@hint].insert(0, header)
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

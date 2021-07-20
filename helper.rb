class GameHelper

  attr_reader :offices

  def initialize
    @ranks = ["Sh*thead Freelancer", "S*cker Enthusiast", "F*cking Startuper",
              "Wow Real Businessman", "Goddamned Big Boss", "IT-industry God"]
    @offices = ["Small spot near junkyard", "Dusty cr*p Garage",
                "Corner in thai beauty saloon", "Own room in sh*tty office building",
                "Office in a modern business center", "F*cking Silicon Valley headquarters"]
    @prices = [6000, 15000, 40000, 100000, 999999]
  end

  def getAsciiOffice(office, pcs, devs, capacity)
    withDev = devs
    laptop = pcs - withDev
    locked = 10 - capacity
    empty = capacity - pcs
    ascii1 = File.readlines('ascii/withdev')
    ascii2 = File.readlines('ascii/laptop')
    ascii3 = File.readlines('ascii/empty')
    ascii4 = File.readlines('ascii/locked')
    res = []
    withDev.times { ascii1.each {|i| res << i}  }
    laptop.times  { ascii2.each {|i| res << i}  }
    empty.times   { ascii3.each {|i| res << i}  }
    locked.times  { ascii4.each {|i| res << i}  }
    res
  end

  def getOffice(n)
    @offices[n]
  end

  def getPrice(n)
    @prices[n]
  end

  def getRank(n)
    @ranks[n]
  end

end

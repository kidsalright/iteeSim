require_relative 'messages'
require_relative 'time'
require_relative 'helper'
require_relative 'project'

class Game

  attr_accessor :status
  attr_reader :money, :capacity, :pcs, :devs, :time, :messages, :project

  def initialize
    @status = true
    @money = 2000000
    @rank = 0
    @capacity = 1
    @messages = Messages.new           # here we store messages and hints for GUI
    @helper   = GameHelper.new         # store and process different game logic
    @time     = Gametime.new
    @office, @pcs, @devs = 0, 0, 0
    @project = nil
    @completed = 0
  end

  def newProject
    @project = Project.new(@rank)
  end

  def progress
    @money += @pcs * 0.1
    @money += @rank * 0.1 if @rank > 1
    @money -= @devs * 0.2
    @time.timeRun
  end

  def employDev
    return "No computers for new devs" if @pcs == @devs
    price = @devs * 1000 + 1000
    return "You've to pay #{price}$ prepaid expense" if price > money
    @money -= price
    @devs += 1
    return "ok"
  end

  def buyPc
    return "You reached maximum amount of PC's" if @pcs == 10
    return "Not enough space, upgrade office" if @pcs - @capacity >= 0
    price = @pcs * 1000 + 1000
    return "Not enough money" if price > @money
    @money -= price
    @pcs += 1
    return "ok"
  end

  def officeUp
    return "You have best office already" if @office == @helper.offices.size - 1
    price = @helper.getPrice(@office)
    return "You need #{price}$ for this upgrade" if price > @money
    @money -= price
    @office += 1
    @office < 2 ? @capacity += 1 : @capacity += 2
    return "ok"
  end

  def rankUp
    @rank += 1 unless @rank == @halper.ranks.size
  end

  def asciiOffice
    @helper.getAsciiOffice(@office, @pcs, @devs, @capacity)
  end

  def statistics
    @messages.progression(nil,nil,nil)
  end

  def office
    @helper.getOffice(@office)
  end

  def rank
    @helper.getRank(@rank)
  end

end

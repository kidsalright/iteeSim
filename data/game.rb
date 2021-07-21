require_relative 'messages'
require_relative 'gametime'
require_relative 'gamehelper'
require_relative 'project'
require_relative '../gui/gui'

class Game

  include Gui

  attr_accessor :status
  attr_reader :money, :capacity, :pcs, :devs, :time, :messages, :project, :completion, :started

  def initialize
    @status = true
    @money = 2000
    @rank = 0
    @capacity = 1
    @messages = Messages.new           # here we store messages and hints for GUI
    @helper   = GameHelper.new         # store and process different game logic
    @time     = Gametime.new
    @office, @pcs, @devs = 0, 0, 0
    @project = nil
    @completed = 0
    @passive = 0
    @started = nil
    @rankups = [10, 20, 30, 40, 50]
  end

  def newProject
    @project = Project.new(@rank)
  end

  def startProject
    @started = @project
    @completion = 0
  end

  def completeProject
    @completion += (0.1 * @devs + 0.01) / @started.lvl
    if @completion >= 100
      @money += @started.reward
      @started = nil
      @completed += 1
      Gui::clearFrame("dynamic")
      Gui::clearFrame("message")
      Gui::draw_message(["You completed project"])
      rankUp
    end
  end

  def progress
    @money += @passive
    @money -= @devs * 0.2
    completeProject if @started != nil
    @time.timeRun
  end

  def fireDev
    return "No one to fire" if @devs == 0
    @devs -= 1
    return "ok"
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

  def rankUp
    case @completed
    when 10
      @rank += 1
      Gui::clearFrame("static")
      Gui::clearFrame("message")
      Gui::draw_message(["Your rank was updated gj"])
      Gui::draw_static(self)
    when 20
      @rank += 1
      Gui::clearFrame("static")
      Gui::clearFrame("message")
      Gui::draw_message(["Your rank was updated gj"])
      Gui::draw_static(self)
    when 30
      @rank += 1
      Gui::clearFrame("static")
      Gui::clearFrame("message")
      Gui::draw_message(["Your rank was updated gj"])
      Gui::draw_static(self)
    when 40
      @rank += 1
      Gui::clearFrame("static")
      Gui::clearFrame("message")
      Gui::draw_message(["Your rank was updated gj"])
      Gui::draw_static(self)
    when 50
      @rank += 1
      Gui::clearFrame("static")
      Gui::clearFrame("message")
      Gui::draw_message(["Your rank was updated gj"])
      Gui::draw_static(self)
    end
    @passive = @rank * 0.1
  end

end

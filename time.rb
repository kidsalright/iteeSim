class Gametime

  attr_reader :hours, :minutes, :days

  def initialize
    @passed_ms, @minutes, @hours, @days =  0, 0, 0, 0
  end

  def clocksConverter
    @minutes += 1
    @hours += @minutes / 60
    @minutes %= 60
    @days += @hours / 24
    @hours %= 24
  end

  def timeRun
    @passed_ms += 0.02
    (clocksConverter ; @passed_ms = 0) if @passed_ms > 0.4
  end

end

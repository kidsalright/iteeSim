class Time

  def to_ms
    (self.to_f * 1000.0).to_i
  end

end

class GameTime

  def initialize
    @minutes = 0
    @hours = 0
    @days = 0
    @last_check = Time.now.to_ms
  end

  def passed_ms
    passed = Time.now.to_ms - @last_check
    @last_check = Time.now.to_ms
    passed
  end

  def convert
    @minutes += passed_ms / 100
    @hours += @minutes / 60
    @minutes %= 60
    @days += @hours / 24
    @hours %= 24
  end

  def clocks
    convert
    printf "%02d:%02d  day: %d\r", @hours, @minutes, @days
  end
end

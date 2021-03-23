require_relative 'game'
require_relative 'interface'

class Button

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self  }
  end

  def self.info(data)
    @@data = data
  end

end

class ExitButton < Button
  def self.action
    exit
  end
end

class BuyButton < Button
  def self.action
    @str = "So we r buying PC"
    @@data.buy_pc
    Interface.draw_message(@str)
  end
end

class HireButton < Button
  def self.action
    @@data.hire_worker
    @str = "free places: #{@@data.pc - @@data.worker}"
    Interface.draw_message(@str)
  end
end

class InfoButton < Button
  def self.action
    @str = "#{@@data.pc}, #{@@data.worker}"
    Interface.draw_message(@str)
  end
end

class ClickButton < Button

  def self.action
    @@data.money += (@@data.pc + 1)
  end
end

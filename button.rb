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
    Interface.draw_message(@str)
    Interface.draw_office(0)
  end
end

class HireButton < Button
  def self.action
    @str = "So we r Hiring worker"
    Interface.draw_message(@str)
  end
end

class PricesButton < Button
  def self.action
    @str = "Price list: "
    Interface.draw_message(@str)
  end
end

class ClickButton < Button

  def self.action
    @@data.money += 1
  end
end

require_relative 'game'

class Button

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self  }
  end

  def action
    puts "#{self.name} action something"
  end

end

class ExitButton < Button
  def self.action
    exit
  end
end

class BuyButton < Button
  def self.action
    puts "\r\033[30BBUY PC"
    puts "\e[32A"
  end
end

class HireButton < Button
  def self.action
    puts "\r\e[30BHire worker"
    puts "\e[32A"
  end
end

class PricesButton < Button
  def self.action
    puts "\r\e[30BPc price 1000$"
    puts "\e[32A"
  end
end

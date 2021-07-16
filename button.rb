require_relative 'game'
require_relative 'interface'

class Button

  def self.action

  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self  }
  end

end

class ExitButton < Button
  def self.action
    exit
  end
end

class TestButton < Button
end

class Test2Button < Button
end

class Market

  attr_reader :available

  def initialize
    @available = []
    createOrders
  end

  def createOrders
    (1..3).each do |type|
      counter = rand(2..5)
      while counter != 0
        if type == 1
          @available << SimpleOrders.new
        end
        if type == 2
          @available << MiddleOrders.new
        end
        if type == 3
          @available << HardOrders.new
        end
        counter -= 1
      end
    end
  end
end

class Orders

  attr_reader :variation, :customer, :requiredPower, :complexity, :deadline, :type

  def initialize
    calculate
  end

  def calculate
    @variation = "[site] [game] [app] etc."
    @customer = "[google] [freelance] [fuck] etc."
    @requiredPower = @type
    @complexity *= 1000
    @deadline = @complexity * rand(3..5)
    @penalty = @type * 1000 * rand(3..5)
  end

  def info
    puts "#{@type} - сложность заказа"
    puts "#{@variation} - тип заказа"
    puts "#{@customer} - компания заказчик"
    puts "#{@requiredPower} - требуемый апгрейд компов"
    puts "#{@complexity} - итоговая сложность"
    puts "#{@deadline} - время до дедлайна"
  end

end

class SimpleOrders < Orders

  def initialize
    @type = 1
    @complexity = rand(1..2)
    super
  end

end

class MiddleOrders < Orders

  def initialize
    @type = 2
    @complexity = rand(3..5)
    super
  end

end

class HardOrders < Orders

  def initialize
    @type = 3
    @complexity = rand(6..10)
    super
  end

end

require_relative 'workers'

class Boss

  attr_reader :balance, :officeLvl, :places, :workers, :workstations

  def initialize
    @balance = 10000
    @officeLvl = 0
    @places = @officeLvl * 5
    @workers = []
    @workstations = []
  end

  def officeUpgradePrice
    if @officeLvl == 0
      officePrice = 5000
    else
      officePrice = 5000 * (@officeLvl + 2) * 2
    end
  end

  def buyOffice
    price = officeUpgradePrice
    if price < @balance
      @balance -= price
      @officeLvl += 1
      @places = @officeLvl * 5
    end
  end

  def buyWorkstation
    price = 3000
    if price < @balance
      @balance -= price
      @workstations << 1
    end
  end

end

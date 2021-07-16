require_relative 'game'
require_relative 'interface'

class Button

  def self.action
    printf "\rEmpty button click"
    printf "\e[2A"
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

class HelpButton < Button
end

class UpgradeOfficeButton < Button
end

class BuyEquipmentButton < Button
end

class HireButton < Button
end

class AAAOrderButton < Button
end

class BigProjectButton < Button
end

class SmallOutsourceButton < Button
end

require_relative 'game'
require_relative 'gui'

class Button
  include Gui

  def self.action(data)
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self  }
  end

end

class ExitButton < Button
  def self.action(data)
    data.status = false
    exit
  end
end

class HelpButton < Button
  def self.action(data)
    Gui::clearFrame("message")
    Gui::draw_message(data.messages.help)
  end
end

class UpgradeOfficeButton < Button
  def self.action(data)
    data.officeUp
    Gui::draw_office(data.officeArt)
    Gui::clearFrame("message")
    Gui::draw_message(["Upgraded office"])
    Gui::clearFrame("static")
    Gui::draw_static(data)
  end
end

class HintsButton < Button
  def self.action(data)
    Gui::clearFrame("message")
    Gui::draw_message(data.messages.hints)
  end
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

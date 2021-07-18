require_relative 'game'
require_relative 'gui'

class Button
  include Gui

  def self.action(data)
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self  }
  end

  def self.refreshGui(data)
    Gui::clearFrame("message")
    Gui::clearFrame("static")
    Gui::draw_static(data)
  end
end

class ExitButton < Button
  def self.action(data)
    data.status = false
    exit
  end
end

class AboutButton < Button
  def self.action(data)
    Gui::clearFrame("message")
    Gui::draw_message(data.messages.help)
  end
end

class ShowHintsButton < Button
  def self.action(data)
    Gui::clearFrame("message")
    Gui::draw_message(data.messages.hints)
  end
end

class ProgressionButton < Button
end

class UpgradeOfficeButton < Button
  def self.action(data)
    data.officeUp
    Gui::draw_office(data.officeArt)
    refreshGui(data)
    Gui::draw_message(["Upgraded office"])
  end
end

class BuyComputerButton < Button
  def self.action(data)
    data.buyPc
    Gui::draw_office(data.officeArt)
    refreshGui(data)
    Gui::draw_message(["Bought PC"])
  end
end

class EmployDeveloperButton < Button
def self.action(data)
    data.employDev
    Gui::draw_office(data.officeArt)
    refreshGui(data)
    Gui::draw_message(["employed"])
  end

end

class ShowPricesButton < Button
end

class CancelProjectButton < Button
end

class HardProjectButton < Button
end

class MediumProjectButton < Button
end

class EasyProjectButton < Button
end

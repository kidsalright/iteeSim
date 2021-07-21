require_relative '../data/game'
require_relative '../gui/gui'

class Button

  include Gui

  def self.action(data)
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self  }
  end

  def self.refreshGui(data)
    Gui::draw_office(data.asciiOffice)
    Gui::clearFrame("message")
    Gui::clearFrame("static")
    Gui::clearFrame("dynamic")
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
  def self.action(data)
    Gui::clearFrame("message")
    Gui::draw_message(data.statistics)
  end
end

class FireDeveloperButton < Button
  def self.action(data)
    str = data.fireDev
    if str == "ok"
      refreshGui(data)
      Gui::draw_message(["Successfully fired developer"])
    else
      Gui::clearFrame("message")
      Gui::draw_message([str])
    end
  end
end

class EmployDeveloperButton < Button
  def self.action(data)
    str = data.employDev
    if str == "ok"
      refreshGui(data)
      Gui::draw_message(["Employed one f*cking junior developer"])
    else
      Gui::clearFrame("message")
      Gui::draw_message([str])
    end
  end
end

class UpgradeOfficeButton < Button
  def self.action(data)
    str = data.officeUp
    if str == "ok"
      refreshGui(data)
      Gui::draw_message(["Upgraded your f*cking office"])
    else
      Gui::clearFrame("message")
      Gui::draw_message([str])
    end
  end
end

class BuyComputerButton < Button
  def self.action(data)
    str = data.buyPc
    if str == "ok"
      refreshGui(data)
      Gui::draw_message(["Bought PC or Laptop i dont giv a fuck"])
    else
      Gui::clearFrame("message")
      Gui::draw_message([str])
    end
  end
end

class StartProjectButton < Button
  def self.action(data)
    if data.project == nil
      Gui::clearFrame("message")
      Gui::draw_message(["Nothing to start, use FIND PROJECT button"])
      return
    end
    if data.started == nil
      data.startProject
    else
      Gui::clearFrame("message")
      Gui::draw_message(["You're already busy with another project"])
    end
  end
end

class FindProjectButton < Button
  def self.action(data)
    data.newProject
    Gui::clearFrame("message")
    Gui::draw_message(["You found an order","",
                       "Task: #{data.project.type}",
                       "From: #{data.project.from}","",
                       "Potential earnings: #{data.project.reward}$",
                       "Approximate completion time: 1 day",
                       "Difficulty: #{data.project.lvlword}"])

  end
end

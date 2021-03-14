require 'yaml'

class SaveManager

  def saveGame(obj)
    File.open('save.dump', 'w') { |f| f.write(YAML.dump(obj))  }
  end

  def loadGame
    YAML.load(File.read('save.dump'))
  end

  def newGame
    game = Control.new
    game.boss = Boss.new
  end

end


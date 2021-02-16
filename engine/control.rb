require_relative 'boss'
require_relative 'arts'
require_relative 'gameclocks'
require 'yaml'


class ControlPanel

  def new_game
    @boss = Boss.new
    @time = GameTime.new
  end

  def save 
    File.open('save.dump', 'w') { |f| f.write(YAML.dump(self)) }
  end

end

def load_game
  YAML.load(File.read('save.dump'))
end

test = load_game
test.boss_info


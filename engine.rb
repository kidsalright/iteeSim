require 'io/console'
require 'curses'
require_relative 'keys'
require_relative 'intro'
require_relative 'game'
require_relative 'interface'
require_relative 'button'

class Engine

  include Interface
  include Keys

  def initialize
    intro_helper
    @index = 0
    @data = Game.new
    @buttons = Button.descendants
    Interface::draw_menu(@buttons, @index)
    run_game
  end

  def run_thread
    thread = []

    thread << Thread.new do
      while true
        @index += Keys::read_key(@buttons, @index)
      end
    end
  end

  def progress
    @data.money += 0.1
    sleep 0.1
  end

  def run_game
    run_thread
    old_index = @index
    while true
      if @index != old_index
        Interface::draw_menu(@buttons, @index)
        old_index = @index
      end
      progress
      Interface::draw_progress(@data.money)
    end
  end

  def intro_helper
    thread = []

    @press = true
    intro = IntroAnim.new
    intro.init
    thread << Thread.new do
      intro.drawBg
    end
    until Keys::read_char; end
    @press = false
    intro.stopIntro
    thread.pop
  end

end

Engine.new

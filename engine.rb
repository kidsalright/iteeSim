require 'io/console'
require 'curses'
require_relative 'keys'
require_relative 'intro'
require_relative 'game'
require_relative 'interface'
require_relative 'button'

class Engine

  include Keys

  def initialize
    Curses::curs_set(0)
    intro_helper
    puts "\033[32m"
    Interface.draw_frames
    @index = 0
    @data = Game.new
    @buttons = Button.descendants
    run_game
  end

  def run_thread
    thread = []

    thread << Thread.new do
      old_index = @index
      while true
        @index += Keys::read_key(@buttons, @index)
        if @index == @buttons.length
          @index = 0
          old_index = @index
        end
        if @index < 0
          @index = @buttons.length - 1
          old_index = @index
        end
      end
    end
  end

  def progress
    Button.info(@data)
    @data.money += (@data.worker * 0.5)
  end

  def run_game
    run_thread
    old_index = -1
    while true
      if @index != old_index
        Interface.draw_menu(@buttons, @index)
        old_index = @index
      end
      progress
      Interface.draw_progress(@data)
      sleep 0.1
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

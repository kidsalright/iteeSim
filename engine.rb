require 'io/console'
require 'curses'
require_relative 'keys'
require_relative 'intro'
require_relative 'game'
require_relative 'button'
require_relative 'gui'

class Engine

  include Keys
  include Gui

  def initialize
    Curses::curs_set(0)             # Hide cursor
    IntroAnim.new
    puts "\033[32m"                 # Set green text color
    @cursor = 0                     # Var for tracking cursos pos in menu
    @data = Game.new
    @buttons = Button.descendants
    @tasks = []                     # Array for storing tasks got from UI
    init_interface
    run_game                        # Starting loop that tracks Keyboard keys and @data changing
  end

  def init_interface
    Gui::draw_menu(@buttons, @cursor)
    Gui::init_frames
  end

  def run_thread
    thread = []

    thread << Thread.new do
      old_cursor = @cursor
      while true
        pressed_key = Keys::read_key(@buttons, @cursor)
        @tasks << pressed_key unless pressed_key == nil
      end
    end
  end

  def progress
    @data.money += (@data.worker * 0.5)
  end

  def tasks_handler
    case @tasks.first
    when :down
      @cursor >= @buttons.size - 1 ? @cursor = 0 : @cursor += 1
      Gui::draw_menu(@buttons, @cursor)
    when :up
      @cursor <= 0 ? @cursor = @buttons.size - 1 : @cursor -= 1
      Gui::draw_menu(@buttons, @cursor)
    end
    @tasks.shift
  end

  def run_game
    run_thread
    new_tasks = @tasks.size
    while true
      tasks_handler
      sleep 0.02
    end
  end

end

Engine.new

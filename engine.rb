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
    @game = Game.new
    @buttons = Button.descendants
    @events = []                    # Array for storing events got from UI
    init_interface
    run_game                        # Starting loop that tracks Keyboard keys and @game changing
  end

  def init_interface
    Gui::draw_menu(@buttons, @cursor)
    Gui::init_frames
    Gui::draw_static(@game)
    Gui::draw_office(@game.officeArt)
  end

  def run_thread
    thread = []

    thread << Thread.new do
      old_cursor = @cursor
      while @game.status
        pressed_key = Keys::read_key(@cursor)
        @events << pressed_key unless pressed_key == nil
      end
    end
  end

  def events_handler
    case @events.first
    when :down
      @cursor >= @buttons.size - 1 ? @cursor = 0 : @cursor += 1
      Gui::draw_menu(@buttons, @cursor)
    when :up
      @cursor <= 0 ? @cursor = @buttons.size - 1 : @cursor -= 1
      Gui::draw_menu(@buttons, @cursor)
    when :pressed
      button = @buttons.fetch(@cursor)
      button.action(@game)
    end
    @events.shift
  end

  def run_game
    run_thread
    while @game.status
      Gui::draw_dynamic(@game)
      @game.progress
      events_handler
      sleep 0.02
    end
  end

end

Engine.new

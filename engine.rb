require 'io/console'
require 'curses'
require_relative 'intro'
require_relative 'keys'

class Engine

  include Keys

  def initialize
    intro_helper
    init_data
    draw_menu
    run_game
  end

  def draw_menu
    puts "\r\n"
    @commands.each_with_index do |cmd, i|
      @board.each {|i| printf "\r\033[80C%s", i}
      puts "\r\033[2A\033[82C#{cmd}"
    end
  end

  def run_progress
    puts "\ru have #{@money.to_i} $\033[1A"
    @money += 0.1
    sleep 0.1
  end

  def run_thread
    thread = []

    thread << Thread.new do
      while true
        Keys::read_key(nil)
      end
    end
  end

  def run_game
    run_thread
    while true
      run_progress
    end
  end

  def init_data
    @money = 999
    @commands = %w[ex1 ex2 ex3 ex4]
    @board = File.readlines('ascii/border')
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

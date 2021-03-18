require 'io/console'
require 'curses'
require_relative 'intro'

class String

  def conv
    self.tr_s('_', ' ').upcase
  end

end

class Game

  include Curses

  def initialize
    @money = 0
    @pos = 0
    @commands = ["price_list", "new_pc", "hire_slave", "take_order", "exit"]
    @board = File.readlines('ascii/border')
    @status = 1
    Curses::curs_set(0)
    wait_key
    run
  end

  def slider_down
    puts "\033[20B"
    5.times do
      puts "\r                                                          \n"
    end
    puts "\033[5A"
  end

  def price_list
    slider_down
    puts "\r Price list:"
    puts "\033[21A"
  end

  def new_pc
    slider_down
    puts "\r Buying pc heh"
    puts "\033[21A"
  end

  def hire_slave
    slider_down
    puts "\r Hiring slave heh"
    puts "\033[21A"
  end

  def take_order
    slider_down
    puts "\r Taking order like site or game\n or soft and making quests"
    puts "\033[22A"
  end

  def wait_key
    thread = []

    @press = true
    intro = IntroAnim.new
    intro.init
    thread << Thread.new do
      intro.drawBg
    end
    until read_char; end
    @press = false
    intro.stopIntro
    thread.pop

  end

  def run_thread
    thread = []

    thread << Thread.new do
      while true
        read_key
      end
    end
  end

  def slider_up
    puts "\r\033[#{@commands.length * 2 + 1}A"
  end

  def run_progress
    if @new_pos != @pos
      draw_menu
    end
    @new_pos = @pos
    slider_up
    puts "\ru have #{@money.to_i} $\033[1A"
    @money += 0.1
    sleep 0.1
  end

  def run
    run_thread
    puts `clear`
    draw_menu
    @new_pos = @pos
    while true
      run_progress
    end
  end

  def eat
    puts "\033[1A\r                     \033"
    @money = 0
  end

  def draw_menu
    puts "\r\n"
    @commands.each_with_index do |cmd, i|
      @board.each {|i| printf "\r\033[60C%s", i}
      if i == @pos
        puts "\r\033[42m\033[2A\033[62C#{cmd.conv}\033[0m"
      else
        puts "\r\033[2A\033[62C#{cmd.conv}"
      end
    end
    slider_up
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def read_key
    c = read_char

    case c
    when "\r"
      if @commands[@pos] == "exit"
        puts `clear`
      end
      send(@commands[@pos])
    when "\e[A"
      if @pos == 0
        @pos = @commands.length - 1
      else
        @pos -= 1
      end
    when "\e[B"
      if @pos == @commands.length - 1
        @pos = 0
      else
        @pos += 1
      end
    when "\u0003"
      exit 0
    end
  end

end

Game.new

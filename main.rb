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
    @commands = ["new_pc", "hire_slave", "take_order", "exit"]
    @board = File.readlines('ascii/border')
    @status = 1
    Curses::curs_set(0)
    wait_key
    run
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

  def run_progress
    if @new_pos != @pos
      draw_menu
    end
    @new_pos = @pos
    slider_def
      puts "\ru have #{@money.to_i} $\033[1A"
      @money += 0.1
      sleep 0.1
    end

    def slider_def
      puts "\r\033[#{@commands.length * 2 + 1}A"
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
        @board.each {|i| printf "\r\033[30C%s", i}
        if i == @pos
          puts "\r\033[42m\033[2A\033[35C#{cmd.conv}\033[0m"
        else
          puts "\r\033[2A\033[35C#{cmd.conv}"
        end
      end
      slider_def
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
          @pos -= 1
        when "\e[B"
          @pos += 1
        when "\u0003"
          exit 0
        end
      end

    end

    Game.new

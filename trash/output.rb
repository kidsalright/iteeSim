require 'io/console'

class Test

  attr_reader :boards, :commands

  def initialize
    @commands = %w(ssss ssddad aAAAAAAAA Back exit)
    @boards = File.readlines('border')
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

  def show_single_key
    c = read_char

    case c
    when "\e[A"
      printf "\033[2K\033[6A\r"
      keey
    when "\e[B"
      printf "\033[2K\033[6B\r"
      keey
    when "\u0003"
      puts "CONTROL-C"
      exit 0
    end
  end

  def keey
    printf "\033[3C                                ".bg_magenta
  end

  def paint
    strnum = 0
    @commands.each do |cmd|
      @boards.each { |board| printf "%s", board }
      printf "\033[3A"
      printf "%10s%s\n", " ", cmd
      printf "\033[3B"
    end
    printf "\033[28A"
    keey
  end

end

t = Test.new
puts `clear`
t.paint
t.show_single_key while true

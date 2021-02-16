require 'io/console'

class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

class Test

  attr_reader :boards, :commands

  def initialize
    @commands = %w(spaerma ssss ssddad aAAAAAAAA Back exit)
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

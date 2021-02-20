require_relative 'arts'
require 'io/console'

class InOut

  def initialize
  end

  def readKey
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

  def catchKey
    c = readKey

    case c
    when "\r"
      return :ok
    when "\e"
      return :esc
    when "\e[A"
      return :up
    when "\e[B"
      return :down
    when "\u0003"
      exit 0
    when /^.$/
      return c.inspect
    else
      return c.inspect
    end
  end

end

hah = InOut.new

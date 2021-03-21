require_relative 'button'

module Keys

  def self.read_char
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

  def self.read_key(buttons, index)
    c = read_char

    @buttons = buttons
    @index = index
    @clicked = 0
    case c
    when "\r"
      button = @buttons.fetch(@index)
      button.action
      0
    when "\e[A"
      -1
    when "\e[B"
      1
    when "\u0003"
      exit 0
    else
      0
    end
  end

end

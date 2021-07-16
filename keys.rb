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

  def self.read_key(buttons, buttonpos)
    c = read_char

    @buttons = buttons
    @buttonpos = buttonpos
    @clicked = 0
    case c
    when "\r"
      #button = @buttons.fetch(@buttonpos)
      ##button.action
    when "\e[A"
      :up
    when "\e[B"
      :down
    when "\u0003"
      exit 0
    else
      return
    end
  end

end

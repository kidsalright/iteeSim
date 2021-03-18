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

  def self.read_key(index)
    c = read_char

    case c
    when "\r"
      puts "enter"
    when "\e[A"
      puts "up"
    when "\e[B"
      puts "down"
    when "\u0003"
      exit 0
    end
  end

end

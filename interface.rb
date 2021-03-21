class Interface

  def self.draw_frame(hash)
    printf "\r\e[#{hash[:y]}B"
    printf "\r\e[#{hash[:x]}C"
    printf "┌"
    hash[:width].times { printf "-"  }
    printf "┐", " "
    hash[:height].times do
      printf "\r\e[#{hash[:x]}C"
      printf "\e[1B|%#{hash[:width]}s|", ""
    end
    printf "\r\e[#{hash[:x]}C"
    printf "└"
    hash[:width].times { printf "-"  }
    printf "┘"
    printf "\r\e[#{hash[:height]}A"
    printf "\r\e[#{hash[:y]}A"
  end

  def self.draw_frames
    frames = []
    frames << @progress = { height: 10, width: 35, x: 1, y: 1 }
    frames << @messages = { height: 10, width: 35, x: 38, y: 1 }
    frames << @office = { height: 20, width: 100, x: 1, y: 12 }
    frames.each { |frame| draw_frame(frame) }
  end

  def self.indenter(hash)
    printf "\r\e[#{hash[:x] + 2}C"
    printf "\e[#{hash[:y] + 2}B"
  end

  def self.indentback(hash)
    printf "\e[#{hash[:y] + 2}A"
  end

  def self.draw_message(data)
    draw_frame(@messages)
    indenter(@messages)
    printf "%s", data
    indentback(@messages)
  end

  def self.draw_office(i)
    place = File.readlines('ascii/place')
    worker = File.readlines('ascii/slave')
    if i == 0
      indenter(@office)
      @counter = 0
      place.each do |i|
        printf "\r\e[#{@office[:x] + 2}C%s", i
        @counter += 1
      end
      printf "\r\e[#{@counter}A"
      indentback(@office)
    end
  end

  def self.draw_menu(buttons, index)
    printf "\033[1B"
    width = "\033[80C"
    buttons.each_with_index do |cmd, i|
      printf "\r%s.%s.\n", width, "---------------"
      printf "\r%s|%15s|\n", width, " "
      printf "\r%s'%s'\n", width, "---------------"
      if i == index
        puts "\r\033[2A\033[82C#{cmd.to_s.upcase}"
      else
        puts "\r\033[2A\033[82C#{cmd.to_s}"
      end
    end
    puts "\r\033[#{buttons.length*2 + 2}A"
  end

  def self.draw_progress(data)
    indent = "\e[3C"
    puts "\r\e[3B"
    puts "\r#{indent}Balance: #{data.money.to_i}$"
    puts "\r\e[6A"
  end

end

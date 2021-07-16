module Gui

  extend self

  def draw_equipment(n)
    ascii = File.readlines('ascii/place')
    indenter(@office)
    p ascii
  end

  def draw_frame(hash)
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

  def init_frames
    frames = []
    frames << @progress = { height: 12, width: 44, x: 1, y: 1  }
    frames << @messages = { height: 12, width: 44, x: 48, y: 1  }
    frames << @office = { height: 20, width: 91, x: 1, y: 14  }
    frames.each { |frame| draw_frame(frame)  }
  end

  def draw_menu(buttons, pos)
    printf "\e[1B"
    width = "\e[95C"
    buttons.each_with_index do |cmd, i|
      button = cmd.to_s.delete_suffix("Button").upcase
      printf "\r%s%s\n", width, "┍━━━━━━━━━━━━━━━━━━━━━┑"
      i == pos ? (printf "\r%s|\e[48;2;1;61;54m    %-16s \e[49m|\n", width, button)
      : (printf "\r%s|    %-16s |\n", width, button)
      printf "\r%s%s\n", width, "┕━━━━━━━━━━━━━━━━━━━━━┙"
    end
    puts "\r\e[#{buttons.length*3 + 2}A"
  end

  private

  def indenter(hash)
    printf "\r\e[#{hash[:x] + 2}C"
    printf "\e[#{hash[:y] + 2}B"
  end

  def indentback(hash)
    printf "\e[#{hash[:y] + 2}A"
  end

end

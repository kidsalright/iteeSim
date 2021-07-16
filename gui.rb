module Gui

  extend self

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
    frames << @progress = { height: 10, width: 35, x: 1, y: 1  }
    frames << @messages = { height: 10, width: 35, x: 38, y: 1  }
    frames << @office = { height: 23, width: 100, x: 1, y: 12  }
    frames.each { |frame| draw_frame(frame)  }
  end

  def draw_menu(buttons, pos)
    printf "\e[1B"
    width = "\e[90C"
    buttons.each_with_index do |cmd, i|
      button = cmd.to_s.delete_suffix("Button").upcase
      printf "\r%s%s\n", width, "┍━━━━━━━━━━━━━━━━━━━━━┑"
      i == pos ? (printf "\r%s|\e[48;2;1;61;54m    %-16s \e[49m|\n", width, button)
      : (printf "\r%s|    %-16s |\n", width, button)
      printf "\r%s%s\n", width, "┕━━━━━━━━━━━━━━━━━━━━━┙"
    end
    puts "\r\e[#{buttons.length*3 + 2}A"
  end

end

module Gui

  extend self

  def draw_office(res)
    indentStart(@office)
    i = 0
    x = 0
    res.each do |str|
      if i == 10
        i = 0
        x += 1
        printf "\r\e[10A"
      end
      if x == 5
        printf "\r\e[11B"
        x = 0
      end
      printf "\r\e[#{x * 18 + 4}C%s", str
      i += 1
    end
    indentEnd(@office, 21)
  end

  def draw_message(arr)
    indentStart(@message)
    arr.each do |i|
      printf "%s\e[1B", i
      indentLine(@message)
    end
    indentEnd(@message, arr.size)
  end

  def draw_dynamic(data)
    indentStart(@dynamic)
    printf "Money: %d", data.money
    indentEnd(@dynamic)
  end

  def draw_static(data)
    indentStart(@static)
    printf "Rank: %s\e[1B", data.rank
    indentLine(@static)
    printf "Office: %s\e[1B", data.office
    indentLine(@static)
    printf "Workplaces: %d/%d\e[1B", data.places, data.capacity
    indentLine(@static)
    printf "Workers: %d/%d\e[1B", data.workers.size, data.places
    indentEnd(@static, 4)
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
    frames << @dynamic = { height: 5, width: 44, x: 1, y: 1  }
    frames << @static = { height: 6, width: 44, x: 1, y: 7  }
    frames << @message = { height: 12, width: 44, x: 48, y: 1  }
    frames << @office = { height: 22, width: 91, x: 1, y: 14  }
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

  def indentLine(hash)
    printf "\r\e[#{hash[:x] + 2}C"
  end

  def indentStart(hash)
    printf "\r\e[#{hash[:x] + 2}C"
    printf "\e[#{hash[:y] + 1}B"
  end

  def indentEnd(hash, n = 0)
    printf "\e[#{hash[:y] + 1 + n}A"
  end

end

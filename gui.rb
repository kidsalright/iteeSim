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
      printf "%s", i
      indentLine(@message)
    end
    indentEnd(@message, arr.size)
  end

  def draw_dynamic(data)
    indentStart(@dynamic)
    printf "%02d:%02d   day: %d", data.time.hours,
      data.time.minutes, data.time.days
    indentLine(@dynamic)
    printf "Money:  %d$", data.money
    if data.started != nil
      indentLine(@dynamic)
      printf "Project progression: %d%%", data.completion
      indentEnd(@dynamic, 2)
      return
    end
    indentEnd(@dynamic, 1)
  end

  def draw_static(data)
    indentStart(@static)
    printf "Rank: %s", data.rank
    indentLine(@static)
    printf "Office: %s", data.office
    indentLine(@static)
    printf "Computers: %d/%d", data.pcs, data.capacity
    indentLine(@static)
    printf "Developers: %d/%d", data.devs, data.pcs
    indentEnd(@static, 3)
  end

  def draw_frame(hash)
    printf "\r\e[#{hash[:y]}B"
    printf "\r\e[#{hash[:x]}C"
    printf "┏"
    hash[:width].times { printf "━"  }
    printf "┓", " "
    hash[:height].times do
      printf "\r\e[#{hash[:x]}C"
      printf "\e[1B┃%#{hash[:width]}s┃", ""
    end
    printf "\r\e[#{hash[:x]}C"
    printf "┗"
    hash[:width].times { printf "━"  }
    printf "┛"
    printf "\r\e[#{hash[:height]}A"
    printf "\r\e[#{hash[:y]}A"
  end

  def clearFrame(str)
    case str
    when "dynamic"
      draw_frame(@dynamic)
    when "static"
      draw_frame(@static)
    when "message"
      draw_frame(@message)
    when "office"
      draw_frame(@office)
    end
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
    buttons.each_with_index do |button, i|
      printf "\r%s%s\n", width, "╔═════════════════════╗"
      i == pos ? (printf "\r%s║\e[48;2;1;61;54m  %-16s   \e[49m║\n", width, button)
      : (printf "\r%s║  %-16s   ║\n", width, button)
      printf "\r%s%s\n", width, "╚═════════════════════╝"
    end
    puts "\r\e[#{buttons.length*3 + 2}A"
  end

  private

  def indentLine(hash)
    printf "\e[1B\r\e[#{hash[:x] + 2}C"
  end

  def indentStart(hash)
    printf "\r\e[#{hash[:x] + 2}C"
    printf "\e[#{hash[:y] + 1}B"
  end

  def indentEnd(hash, n = 0)
    printf "\e[#{hash[:y] + 1 + n}A"
  end

end

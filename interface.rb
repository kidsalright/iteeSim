module Interface

  def self.draw_frame(hash)
    printf "\r┌%#{hash[:width]}s┐", " "
    printf "\r\e[#{hash[:height]}B"
    printf "\r└%#{hash[:width]}s┘", " "
    printf "\r\e[#{hash[:height]}A"
  end

  def self.draw_menu(buttons, index)
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

  def self.draw_progress(money)
    draw_frames
    indent = "\e[3C"
    puts "\r\e[3B"
    puts "\r#{indent}Balance: #{money.to_i}$"
    puts "\r\e[6A"
  end

  def self.draw_frames
    progress = { height: 10, width: 35}
    messages = { height: 10, width: 35}
    office = { height: 20, width: 100}
    draw_frame(progress)
  end

end

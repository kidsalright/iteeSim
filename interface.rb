module Interface

  def self.draw_menu(buttons, index)
    puts "\r\n"
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
    puts "\r\033[#{buttons.length*2 + 2}A]"
  end

  def self.draw_progress(money)
    puts "\ru have #{money.to_i} $\033[1A"
  end

end

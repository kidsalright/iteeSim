HEIGHT = 44
WIDTH = 130

class Animations

  def getBg
    "\e[48;2;#{@r};#{@g};#{@b}m"
  end

  def getStr
    "\e[38;2;#{@r};#{@g};#{@b}m"
  end

  def getArt(name)
    File.readlines("ascii/#{name}")
  end

  def setColors
    @r, @g, @b = 80, 183, 210
  end

  def newColors
    @r, @g, @b = 0, 253, 200
  end

  def  nextRGB
    if (@r == 255 && @g < 255 && @b == 0)
      @g += 5
    end
    if (@g == 255 && @r > 0 && @b == 0)
      @r -= 5
    end
    if (@g == 255 && @b < 255 && @r == 0)
      @b += 5
    end
    if (@b == 255 && @g > 0 && @r == 0)
      @g -= 5
    end
    if (@b == 255 && @r < 255 && @g == 0)
      @r += 5
    end
    if (@r == 255 && @b > 0 && @g == 0)
      @b -= 5
    end
  end

  def openArts
    @pc = getArt('pc')
    @title = getArt('title')
    @keys = getArt('keyboard')
    @mouse = getArt('mouse')
  end


end

class IntroAnim < Animations

  def drawDetails
    printf "\e[1B"
    @pc.each { |i| printf "%s\e[17C%s\e[0m", getStr, i}
    printf "\e[10A"
    13.times { printf "\e[44C%s%68s\e[0m\n", getBg, "" }
    printf "\e[11A"
    @title.each { |i| printf "%s\e[30m\e[46C%s\e[0m", getBg, i}
    printf "\e[13B"
    @keys.each { |i| printf "%s\e[19C%s\e[0m", getStr, i }
    printf "\e[8A"
    @mouse.each { |i| printf "%s\e[90C%s\e[0m", getStr, i}
    printf "\e[32A"
  end

  def drawBg
    puts `clear`
    openArts
    printf "\e[#{HEIGHT}B"
    art = getArt('intro')
    setColors
    art.reverse_each { |i| printf "\e[2A%s%10s%s\e[0m", getStr, "", i ; sleep 0.02}
    @r = 0
    @g = 255
    @b = 150
    while true
      drawDetails
      sleep 0.06
      nextRGB
    end
  end

end

t = IntroAnim.new
t.drawBg

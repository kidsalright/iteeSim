HEIGHT = 40
WIDTH = 130

class Animations

  def getArt(name)
    File.readlines("ascii/#{name}")
  end

  def pcColor
    @rs, @gs, @bs = 5, 5, 40
  end

  def bgColor
    @r, @g, @b = 210, 190, 210
  end

  def bgGrad
    @r -= 5
    @g -= 3
    @b -= 2
  end

  def reverseBgGrad
    @r += 5
    @g += 3
    @b += 2
  end

  def colorBg
    "\e[48;2;#{@r};#{@g};#{@b}m"
  end

  def colorStr
    "\e[38;2;#{@rs};#{@gs};#{@bs}m"
  end

  def showPic
    printf "\e[3A\e"
    4.times { reverseBgGrad }
    pic = getArt('intro1')
    pcColor
    printf "%s", colorStr
    pic.reverse_each do |i|
      printf "%s%10s\e[2A%s", colorBg, "", i
      reverseBgGrad
      sleep (0.05)
    end
    sleep 5
  end

  def drawBg
    puts `clear`
    bgColor
    HEIGHT.times do
      sleep 0.01
      printf "%s%#{WIDTH}s\n", colorBg, ""
      bgGrad
    end
    showPic
  end

end

t = Animations.new
t.drawBg

require_relative 'keys'

HEIGHT = 39
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
      @g += 15
    end
    if (@g == 255 && @r > 0 && @b == 0)
      @r -= 15
    end
    if (@g == 255 && @b < 255 && @r == 0)
      @b += 15
    end
    if (@b == 255 && @g > 0 && @r == 0)
      @g -= 15
    end
    if (@b == 255 && @r < 255 && @g == 0)
      @r += 15
    end
    if (@r == 255 && @b > 0 && @g == 0)
      @b -= 15
    end
  end

  def openArts
    @intro = getArt('intro')
    @pc = getArt('pc')
    @title = getArt('title')
    @keys = getArt('keyboard')
    @mouse = getArt('mouse')
  end

end

class IntroAnim < Animations

  include Keys

  def initialize
    thread = []

    @press = true
    init
    thread << Thread.new do
      drawBg
    end
    sleep(0.2)
    until Keys::read_char; end
    @press = false
    stopIntro
    thread.pop
  end

  def drawDetails
    @pc.each do |i|
      printf "\r%s\e[17C%s\e[0m", getStr, i
    end
    printf "\e[10A"
    @title.each do |i|
      nextRGB
      printf "\r%s\e[30m\e[44C%s\e[0m", getBg, i
    end
    printf "\e[10B"
    @keys.each do |i|
      printf "\r%s\e[19C%s\e[0m", getStr, i 
    end
    printf "\e[8A"
    @mouse.each do |i|
      printf "\r%s\e[90C%s\e[0m", getStr, i
    end
    printf "\e[31A"
  end

  def init
    puts `clear`
    openArts
    HEIGHT.times { printf "\n" }
    setColors
    @intro.reverse_each { |i| printf "\r\e[2A%s%10s%s\e[0m", getStr, "", i ; sleep 0.02}
    @r = 0
    @g = 0
    @b = 255
    @status = true
  end

  def stopIntro
    puts `clear`
    @status = false
  end

  def drawBg
    while @status
      drawDetails
      sleep 0.1
    end
  end

end

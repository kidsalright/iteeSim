class Arts

  def initialize
    cls = self.class
    cls.instance_methods(false).each do |method|
      cls.instance_method(method).bind(self).call
    end
  end

  def pc_pic
    pc = File.readlines('ascii/bigpc')
    puts "read"
  end

  def intro_borders
    pic = File.readlines('ascii/borders')
    puts "read"
  end

end

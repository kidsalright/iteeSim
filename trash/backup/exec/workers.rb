class Worker

  attr_reader :rank, :name, :sex, :payday

  def initialize
    @ranks = %w(intern junior middle senior)
    initPerson
    initSkills
  end

  def initPerson
    @name = 'Randomize'
    if rand(0..10) < 8
      @sex = 'male'
    else
      @sex = 'female'
    end
  end

  def initSkills
    @rank = rand(0..3)
    @payday = rand(7..9) * @rank
  end

end

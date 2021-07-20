class Project

  attr_reader :from, :type, :lvlword, :reward, :lvl

  def initialize(rank)
    setupLvl(rank)
    @from = projectFrom
    @type = projectType
  end

  def setupLvl(rank)
    case rank
    when 0..1
      @lvl = 1
      @lvlword = "Easy"
      @reward = @lvl * rand(4000..4500)
    when 2..3
      @lvl = 2
      @lvlword = "Medium"
      @reward = @lvl * rand(5000..5500)
    when 4..5
      @lvl = 3
      @lvlword = "Hard"
      @reward = @lvl * rand(10000..15000)
    end
  end

  def projectType
    case @lvl
    when 1
      ["To-Do-List rails app", "VK dark theme chrome extension",
       "Flappy Bird clone mobile game", "Drunk beer counter app",
       "One-page site about beer", "Scam telegram bot"].sample
    when 2
      ["Online store", "Financial Pyramide website",
       "Rewrite 28 years old code with Golang",
       "Taxi aggregator app", "Employee anti-anime tracking app"].sample
    when 3
      ["Brand-new search engine", "GTA VI",
       "Brand-new coding language NeLang",
       "American hackers cracker"].sample
    end
  end

  def projectFrom
    case @lvl
    when 1
      ["Your Uncle Zinaida", "Your Uncle Grisha",
       "Friend of your friend", "Your ex's new love",
       "Your old classmate", "Very very distant relative",
       "Guy you drunk with year ago"].sample
    when 2
      ["Belgorod State University", "Shawarma chain owner"].sample
    when 3
      ["Vladimir Putin", "Yandex", "Google"].sample
    end
  end

end

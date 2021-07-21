class Messages

  def initialize
    @hint = 0
  end

  def progression(rank, completed,spent)
    ["Your rank is #{rank}",
     "completed projects #{completed}"]
  end

  def hints
    header = "Hint: #{@hint + 1}/5 "
    hint0 = ["Main purpose of the game is to become",
             "a rich director of a giant IT company with",
             "a big office and a lot of employees.",
             "To reach it, you have to complete",
             "development projects.",
             "The more developers you have, the easier",
             "it will be to carry out these projects"]
    hint1 = ["Buying computers boost passive earnings",
             "Employees boost order completion time, but",
             "they need to be paid a salary.", "",
             "Remember, if all your money goes to",
             "salaries and you go bankrupt, then",
             "your game will be over, and you'll have to",
             "start from the beginning"]
    hint2 = ["At the start u have 0/1 workplaces it",
             "means that your office can accomodate",
             "1 computers but you have 0, for this",
             "reason you have 0/0 devs, it means",
             "that u can't hire any developer",
             "cause you don't have computers yet.",
             " ", "When you upgrade office,buy 2 computers and",
             "hire an employee, you would have 2/2",
             "workplaces and 1/2 devs"]
    hint3 = ["Difficulty of the projects affects",
             "the completion time and the reward,",
             "easier projects completes faster, but",
             "profit is lower.", " ",
             "It is not recommended to start big",
             "projects without enough developers",
             "in your company."]
    hint4 = ["You noticed that there are fewer devs,",
             "then it were? It's ok, sometimes employees",
             "quit, you have to watch it, and hire new,",
             "to complete your orders!"]
    hints = [] << hint4 << hint0 << hint1 << hint2 << hint3
    (@hint > (hints.size - 2)) ? @hint = 0 : @hint += 1
    return hints[@hint].insert(0, header)
  end

  def help
    ["ITeeSim - IT Simulator progresser game,",
     "where your main purpose is to found",
     "huge IT development company:",
     "get big office, set up working places",
     "hire a lot of developers and become",
     "really big boss to overshadow",
     "Elon Mask, Jeff Bezos, Mark Zuckerberg",
     "and other c*cksu*kers!)",
     "Can u get out from this trash heap",
     "and go to be best IT director in da world?"]
  end

end

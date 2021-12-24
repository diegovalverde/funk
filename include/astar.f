use sort



# found no solution
astar(_, _, _, []):[].

# found a solution
astar(isGoal, getNext, sortCriteria, explore | isGoal(explore[0]) = 1):
    explore[0].


astar(isGoal, getNext, sortCriteria,  n <~ [explore]):
    x <-  getNext(n)
    astar( isGoal, getNext, sortCriteria, sort([explore] ++ [x], sortCriteria) ).



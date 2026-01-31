use tchk, rroll, hroll, croll

test_roll_core():
      say('=== test roll ===')
      A <- [[1,2,3],[4,5,6],[7,8,9]]
      R <- [1,2,3]
      tchk( rroll(R,0), R )
      tchk( croll(A,0), A )
      1.

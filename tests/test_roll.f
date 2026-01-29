use assert, rroll, hroll, croll

test_roll():
      say('=== test roll ===')
      A <- [[1,2,3],[4,5,6],[7,8,9]]
      assert( rroll(A,0), A )
      assert( croll(A,0), A )
      1.

main():
      test_roll().

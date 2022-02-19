
      _find_all([],_,_): [].
      _find_all(l <~ [L],v,k | v = l): k ~> [ _find_all(L,v,k+1)  ].
      _find_all(l <~ [L],v,k): _find_all(L,v,k+1).
      
    find_all(L,v): _find_all(L,v,0).

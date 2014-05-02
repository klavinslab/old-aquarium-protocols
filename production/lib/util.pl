#########################################################################################
# Arrays of hashes
#

function ha_select(list,key)

  # Takes a list of hashes and a key and returns and array of the values associated 
  # with that key in each hash.
  #
  # For example, ha_select([{a:1, b:2},{a:3,b:4}],:a) returns [ 1, 3 ]

  f = []
  foreach x in list
    f = append(f,x[key])
  end

  return f

end

function ha_get(list,key,value)

  # Takes a list of hashes and a key,value pair. Returns the last hash h such
  # that h[key] = value.
  #
  # For example, ha_get({a:1, b:2},{a:3,b:4}],:a,1) returns { a:1, b:2 }

  h = {}

  foreach x in list
    if x[key] == value
      h = x
    end
  end

  return h

end
# library of functions

# takes in an original sample id and a sample array of hashes and returns the first descendent sample as a hash
function find_original( o_id, sample_array)
  foreach elem in sample_array
    if o_id == elem[:original_id]
      return elem
    end
  end
end

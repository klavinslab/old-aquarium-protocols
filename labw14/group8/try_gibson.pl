require "labw14/group8/lib_read_gibson.pl"

g = get_gibson_csv_path_return_gibsons()

# idea TODO
# build up a data structure using loops etc that define experiment
# then iterate through that data structure, showing it
step
  description: "print out the gibson array"
  note: "%{g}"
end

argument
  plated_cells: sample("Transformed E coli Strain") array, "An array of THREE agarose-streaked
                                                            colonies to grow in glucose media"
  #pipette_transfer: object, "The name of the serological pipette to use"
end #note that 'plated_cells' is an array of integers, representing sample ID numbers

#step
#  description: "This protocol will grow multiple cell cultures in glucose."
#  note: "This is a serological pipette (you will fech this in the next step)"
#  image: "serological_pipette"
#end
step
  description: "In the media bay"
  check: "You should still be in the media bay when you start this procedure.
         If you are not in the media bay, move there now."
  note: "This protocol will grow multiple cell cultures in glucose."
  note: "This is a 14mL culture tube (you will fetch 12 of these in the next step)"
  image: "14ml_culture_tube"
end

strains = length(plated_cells)
n = strains * 4 #this could be "repeats"


take
  note: "Be sure to grab a tube rack to hold all of the culture tubes."
  culture_tubes = n "14 mL Test Tube"
  pipette = 1 "Serological Pipette"
  tip = 1 "5 mL Serological Pipette Tips"
  media_tube1 = 1 "30 mL M9 liquid Glucose + amp + kan"
  media_tube2 = 1 "30 mL M9 liquid Glucose + amp + kan"
end

step
  description: "Add 3mL media to each culture tube"
  note: "If you have a lab partner, they can help you by holding the cap of each culture tube,
         and the cap of the media tube while you do the pipetting"
  note: "If you do not have a lab parner, use your best sterile technique to remove the lid of each container
         with one hand while pipetting the liquid with the other hand (this will take much longer)."
  check: "Use the electric serological pipette to add 3ml of 'M9 liquid Glucose + amp + kan' to each culture tube."
  check: "Dispose of your serological pipette tip in the large red biological waste bin."
end

release [pipette[0]]

step
  description: "Return to your own bench"
  note: "You are now done in the media bay.  Take your prepared culture tubes and return to your station.
         You will be using cells next, and you don't want to contaminate the media bay"
end

take
  plate_array = item plated_cells
end
#A loop to produce all of the culture tubes silently, so I can get their newly assigned ID numbers
incubated_cells = []#a sample reference array of culture tubes to be incubated 
return_array = []#an array of id numbers for each culture tube sample
i = 0
while i<strains
  id = plated_cells[i]
  a = []
  produce silently
    a = 1 "Overnight suspension culture" from plate_array[i]
    location: "Bench"
  end
  i = i + 1
  incubated_cells = append(incubated_cells, a)
  return_array = append(return_array, a[:id])
end

#now we want to write the ID numbers onto the tubes"
tube0 = return_array[0]
tube1 = return_array[1]
tube2 = return_array[2]
step
  description: "Label culture tubes"
  note: "You will need 12 tubes in total: 4 repetitions for each of 3 strains"
  note: "You should write your labels vertically on the clear glass part of the tubes, NOT on the white part 
         (if you draw on the white part, it is very difficult to wash off!)"
  check: "Label a set of 4 culture tubes with:"
  bullet: "'%{tube0} R1', '%{tube0} R2', '%{tube0} R3', and '%{tube0} R4'"
  check: "Label another set of 4 culture tubes with:"
  bullet: "'%{tube1} R1', '%{tube1} R2', '%{tube1} R3', and '%{tube1} R4'"
  check: "Label a final set of 4 culture tubes with:"
  bullet: "'%{tube2} R1', '%{tube2} R2', '%{tube2} R3', and '%{tube2} R4'"
#  note: "Keep the sets separate"
end
#Loop through the three strains and add cells from each strain to a set of four culture tubes"
i = 0
while i<strains
  id = plated_cells[i]
  new_id = return_array[i]
  step
    description: "Add cells from plate %{id} to four seperate culture tubes"
    check: "Clean your gloves with ethanol to avoid contamination (be sure to let it evaporate 
            again before handling the pipette tip)"
    check: "Use a 100uL pipette tip (held in your hand) to extract cells from a single colony from plate %{id}.
            Drop the whole tip into the culture tube marked '%{new_id} R1'"
    check: "Repeat the above procedure for '%{new_id} R2', '%{new_id} R3', and '%{new_id} R4'."
    bullet: "Be sure to use a new 100uL pipette tip to extract cells from a different colony from plate %{id},
            for each repetition R1~R4"
    image: "colony_in_tube"
  end
  i = i+1
end


step
  description: "Place the tubes in the 37C shaker"
  note: "You should now have a tube rack containing 4 repeats of each cell colony, in a total of %{n} culture tubes" 
  check: "Load the %{n} cell culture tubes into the 37C shaker."
  note: "This will incubate for 18hrs (overnight)"
end

i=0
while i<length(incubated_cells)
  modify
    incubated_cells[i]
    location: "B13.425 37C Shaker" 
  end
  i=i+1
end

step
  description: "Store one tube of 'M9 liquid Glucose + amp + kan'"
  note: "You should now have two 30ml tubes of 'M9 liquid Glucose + amp + kan' on your bench. 
         One of them should be empty, and one of them partially remaining"
  check: "Store parially filled 30mL tube of 'M9 liquid Glucose + amp + kan' at location B0.110
         (media refridgerator)"
  bullet: "Make sure this tube is labelled properly with '30mL M9 liquid Glucose + amp + kan',
           in addition to YOUR NAME AND DATE. The antibiotics will go bad after a couple of days,
           so you will have to use the remaining media tomorrow."
  check: "In the next step, please select 'dispose' to remove the empty 30ml tube from the inventory.
          You may toss this empty falcon tube into the large red 'biohazard' bin"
end

release media_tube1

modify
  media_tube2[0]
  location: "B0.110"
end

step
  description: "Re-paraffin the agar plates"
  check: "Cut off a 0.5 inch strip of paraffin, hold one end of the strip to the side of an agar plate,
          and stretch the other end out around the whole plate"
  check: "Repeat this proces for each of your three agar plates"
end

release plate_array

log
  return: { incubated_cells_id: return_array}
end



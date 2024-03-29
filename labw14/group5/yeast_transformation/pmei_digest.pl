information "This protocol describes how to digest your plasmid with PmeI enzyme."

argument
   fragment_id: sample, "The purified fragment that needs to be digested"
   neb_id: sample, "NEB 4 buffer"
   bsa_id: sample, "BSA buffer"
   pmei_id: sample, "PmeI enzyme"
end

take
#  y = item fragment
   neb4     = item neb_id
   bsa      = item bsa_id
   fragment = item fragment_id
end

step
  description: "In the next step you will use a -20 C blue ice block tube holder to grab the enzyme"
  note: "The enzyme are temperature sensitive."
end

take
   ice_block = 1 "Styrofoam Ice Block"
   alum_rack = 1 "Aluminum Tube Rack"
   pmei      = item pmei_id
end

step 
  description: "Prepare PmeI digestion reaction"
  check: "Take a 1.5mL tube. Write your name and today's date on the tube's side."
  check: "Pipet 42.3 µL of molecular grade water into the 1.5mL tube."
  check: "Pipet 5 µL of NEB4 buffer with id %{neb_id} into the tube."
  check: "Pipet 0.5 µL of BSA buffer with id %{bsa_id} into the tube."
  check: "Pipet 1.0 µL of DNA plasmid stock with id %{fragment_id} into the tube."
  check: "Pipet 0.3 µL of PmeI enzyme with id %{pmei_id} into the tube."
  warning: "Be careful to pipet into the liquid, not the side of the tube."
  image: "Prepare_PmeI_digestion_reaction_group5"
end

step
  description: "Put the tube in a small green tube holder."
  image: "green_tube_holder"
end

produce
   y = 1 "Digested Plasmid" from fragment[0]
   note: "Write the above id number on the tube's cap and then place in the 37°C incubator for 40 minutes,
            location is B14.310."
   location: "B14.310"
end

log
  return: { digested_plasmid: y[:id] }
end

#step
#  description: "Place in the 37°C incubator for 40 minutes, location is B14.310."
#  image: "put_green_tube_holder_to_incubator"
#end

#modify
#  y[0]
#  location:"B14.310"
#  inuse:0
#end

release [neb4[0],bsa[0],pmei[0]]
release [ice_block[0], alum_rack[0], fragment[0]]

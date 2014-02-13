argument
  oligo_pool: sample array, "Select the oligonucleotide stocks you want to combine through gene assembly"
end

n = length(oligo_pool)
# The number of oligo pools to use in the assembly is recorded, just in case


take
  masterstock = item oligo_pool
  molecular_g_h2o = "Molecular Grade Water"
  
end

step
  description: 
    "This protocol describes how to run gene assembly of two oligonuleotide stocks"
end

step
  description: ""
  note: ""
end
argument
  primer1: sample, "The first primer"
  primer2: sample, "The second primer"
  plasmid_id: sample, "The plasmid stock"
  enzyme_id: sample, "The Phsion HF Master Mix stock"
end

take
  primer1_stock = item primer1
  primer2_stock = item primer2
  plasmid_stock = item plasmid_id
  phusion_stock = item enzyme_id
end

step
  description: "This protocol prepares the PCR mix in PCR tube and starts it in thermal cycler."
end

step
  description: "Label a 0.2 mL PCR tube. Write your initials on it."
end

step
  description: "Prepare Reaction"
  check:"Pipet 7 µL molecular grade water into the labeled PCR tube."
  check: "Pipet 1 µL of plasmid with id %{plasmid_id} into the tube."
  check: "Pipet 1 µL of primer with id %{primer1} into the tube."
  check: "Pipet 1 µL of primer with id %{primer2} into the tube."
  check: "Pipet 10 µL of Phusion Master Mix with id %{enzyme_id} into the tube."
  check: "Use the tip to gently mix."
  note: "Be careful to pipette into the liquid, not the side of the tube."
end

release phusion_stock

step
  description: "You will now be asked to use the lab thermal cycler"
  note: "The thermal cycler will be shared by all groups."
  image: "thermal_cycler_off"
end

step
  description: "Place the tube into thermal cycler T2 at B3.335"
end

step
  description: "Choose program on the thermal cycler"
  note: "Click Home then click Saved Protocol, choose LABW14 folder, choose COLONYPCR. Wait for all other groups to load in their samples."
  image: "thermal_cycler_home"
end

step
  description: "When all group samples are loaded, hit 'run' on the thermal cycler and select 20 µL setting."
  note: "Coordinate with your fellow classmates to put all their samples before hit run."
  image: "thermal_cycler_select"
end


release [primer1_stock[0],primer2_stock[0],plasmid_stock[0]]

step
  description: "Go to the thermal cycler to pick up the PCR tube you put in the previous protocol."
  note: "Put it on you bench after you picked up the PCR tube"
end

produce
  r = 1 "Colony PCR product" of "pLAB3 in Z1"
  note: "Keep the tube on the bench to use in the next protocol. (no need to edit the location below)"
  location: "Bench"
end

log
  return: {PCR_Result_id: r[:id]}
end
produce
  new_gene = 1 "PCR Result"

end




log
  return: { gene: new_gene  }
end
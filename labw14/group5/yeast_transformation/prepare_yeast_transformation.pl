argument
  yeast_aliquot_id: sample array, "Diluted yeast culture"
  numbers_set_id: number array, "Number of aliquot tubes of each yeast strain that were made."
  fragment_id: sample, "Digested plasmid"
end

numbers_set = numbers_set_id

num = length(yeast_aliquot_id)

step
 description: "This protocol describes how to prepare yeast trasformation mix"
 note: "You will pipet several chemical reagents to the yeast aliquot tibes with id %{yeast_aliquot_id} you previously made."
end

take
  yeast_aliquot_tubes = item yeast_aliquot_id
  digested_plasmid    = item fragment_id
end

take
  peg         = 1 "50 percent PEG 3350"
  liac        = 1 "1.0 M LiOAc"
  carrier_dna = 1 "Salmon Sperm DNA (boiled)"
end

ii = 0
r = []

number_we_can_make = 1 + 1 # should be more complicated construction

while ii < number_we_can_make

  id_num = yeast_aliquot_id[ii]
  
  if ii == 0 # CONTROL TUBE
    step
      description: "Making CONTROL yeast transformation mixture"
      note: "Take a 1.5 mL tube with id %{id_num}"
      warning: "Pipette the following reagents into the tube %{id_num}.
                The order of the reagents is super important for cells' health.
                Also be as clean as possible when pipetting 50%% PEG 3350. It gets easily contaminated."
      check: "Pipette 240 µL  50%% PEG 3350 reagent to the tube. When pipetting PEG it's recommended to tilt a bottle
              and pipet slowly (PEG is viscous). Don't touch the bottle's walls with a pipettor."
      check: "Pipette 36 µL  1.0M LiOAc reagent to the tube."
      check: "Pipette 25 µL  Carrier DNA (Salmon Sperm DNA) to the tube."
      check: "Pipette 50 µL  Molecular grade water to the tube."
      image: "yeast_transformation_mixture_group5"
    end
    step
      description: "Resuspend the cells by vortexing"
      warning: "Vortex strongly (setting 8 or 9 on the vortexer) for 1 min or until mixed."
    end
#    produce
#        y = 1 "Yeast Transformation Mixture" from yeast_aliquot_tubes[ii]
#        release yeast_aliquot_tubes[ii]
#    end
#    r = append(r,y[:id])
    modify
      yeast_aliquot_tubes[ii]
      location:"Bench"
      inuse:0
    end
  else
  # NON-CONTROL TUBES
    step
      description: "Making DNA - yeast transformation mixture"
      note: "Take a 1.5 mL tube with id %{id_num}"
      warning: "Pipette the following reagents into the tube %{id_num}.
                The order of the reagents is super important for cells' health.
                Also be as clean as possible when pipetting 50%% PEG 3350. It gets easily contaminated."
      check: "Pipette 240 µL  50%% PEG 3350 reagent to the tube."
      check: "Pipette 36 µL  1.0M LiOAc reagent to the tube."
      check: "Pipette 25 µL  Carrier DNA (Salmon Sperm DNA) to the tube."
      warning: "Please attend! Now you have to pipet Transformation DNA pladmid! NOT water!"
      check: "Pipette 50 µL  Transformation DNA plasmid with id %{fragment_id} to the tube."
      image: "yeast_transformation_mixture_group5"
    end
    step
      description: "Resuspend the cells by vortexing"
      warning: "Vortex strongly (setting 8 or 9 on the vortexer) for 1 min or until mixed."
      image: "voltexing_strongly_group5"
    end
#    produce
#        z = 1 "Yeast Transformation Mixture" from yeast_aliquot_tubes[ii]
#        release yeast_aliquot_tubes[ii]
#    end
#    r = append(r,z[:id])
    modify
      yeast_aliquot_tubes[ii]
      location:"Bench"
      inuse:0
    end
  end
  
  #r = append(r,y[:id])
  ii=ii+1
end

#log
#  return: { yeast_plasmid_mixture: r }
#end

release digested_plasmid
release [ peg[0], liac[0], carrier_dna[0] ]

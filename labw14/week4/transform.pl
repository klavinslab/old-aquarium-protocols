#TODO: Fix s.t. if time constant is < 3.0 then grab another aliquot (Same ID) and use half as much DNA
# once a good time constant or 4 tries end protocol.

argument
  plasmid_id: sample, "The plasmid to be used"
  e_coli_strain_type: sample, "One electrocompetent aliquot (of the 4 made in the previous protocol) to be transformed"
  dna_vol: number
  strain_name: string, "Enter the name of the strain you are producing"
end

take
  falcon_tube = 1 "50 mL LB liquid aliquot (sterile)"
  plasmid = item plasmid_id
  electroporator = 1 "Electroporator"
end

step
  description:
    "Intialize the Electroporator"
  note:
    "Turn on the electroporator if it is off and set the voltage to 1800V by clicking up and down button.\n
     Click the time constant button."
end

step
  description: "Label a 1.5 mL tube"
  note: "Place the tube in the tube rack.\n
         This tube will eventually hold the transformed cells."
  image: "label_1_5mL_tube"
end

step
  description: "Arange Ice Block"
  note: "You will next retrieve a styrofoam ice block and an aluminum tube rack.\n
         Put the aluminum tube rack on top of the ice block."
  image: "arrange_cold_block"

end

take
  iceblock = 1 "Styrofoam Ice Block"
  alrack = 1 "Aluminum Tube Rack"
end

step
  description:"Retrieve Cuvette and Electrocompetent Cells"
  note: "You will next retrieve a Clean Electrocuvette, put it inside the styrofoam touching ice block.\n
        Then grab a tube of electrocompetent cells and put it on the aluminum tube rack."
  image: "handle_electrocompetent_cells"
  warning: "The cuvette metal sides should be touching the ice block to keep it cool."
end

take
  strain = item e_coli_strain_type
  cuvette = 1 "Clean Electrocuvette"
end

step
  description: "Pipette %{dna_vol} µL Fragment (sample id: %{plasmid_id}) into the electrocompetent cells tube"
  check: "Pieptte into the culture, not on the side of the tube."
  check: "Swirl the tip gently in the culture to mix after pieptting."
  check: "Put back on the aluminum rack (not the -20 C blue tube incubator) after mixing."
#  warning: "Vortex the plasmid stock before pipetting into the electrocompetent cells"
  image: "pipette_plasmid_into_electrocompotent_cells"
end

step
  description: "Electroporation and Rescue Preparation"
  check: "Set your pipettors to be 50 µL and 1000 µL."
  check: "Prepare 100 µL and 1000 µL pipette tips."
  check: "Loosen cap on the 50 mL LB liquid aliquot (sterile)."
  check: "Take the black plastic cuvette holder out of electroporator."
end

step
  description: "Transfer the cells-plasmid mixture to electrocuvette."
  note: "Take lid off the cuvette.\n
        Pipette 50 µL of the mixture from the electrocompetent cells tube into the center of the gap of the electrocuvette."
  warning: "Hold the plastic sides of cuvette during pipetting."
  image: "pipette_transformation_mix_to_cuvette"
end

step
  description: "Electroporation, Rescue and Transfer"
  bullet: "Put the cuvette in the cuvette holder, slide into electroporator and press the PULSE button twice quickly."
  bullet: "Remove the cuvette from the electroporator and QUICKLY add 1 mL of LB."
  bullet: "Pipette up and down 3 times to extract the cells from the gap in the cuvette."
  bullet: "Transfer to tube T."
  warning: "If you hear a pop, throw away the cuvette,
            click ABORT."
  image: "electroporation_rescue"
  getdata
    time_constant: number, "Enter the time constant shown on the electroporator."
  end
end

if time_constant >= 3
  produce
    r = 1 "1.5 mL tube transformation" of strain_name 
    note: "Keep on the bench"
    location: "Bench"
  end
  
  log
    return: { transformed_cells_id: r[:id], time_constant: time_constant}
  end

else
  step
    description: "Transformation Unsuccessful"
    note: "Your time constant value was too low, resulting in an unsuccessful transformation.\n
    You must now discard your Transformed E.coli 1.5 mL tube and repeat this protocol."
  end
  
  log
    return: { transformed_cells_id: 0000, time_constant: time_constant}
  end

end



release [electroporator[0]]
release [falcon_tube[0],plasmid[0],alrack[0],iceblock[0],strain[0],cuvette[0]]


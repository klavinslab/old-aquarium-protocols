argument
  
  Transformed_E_coli_Strain_id: sample, "The plate containing the grown colonies"
  
end

step
  description: 
    "This protocol describes the process for overnight suspension of transformed E Coli strains." 
end

take
  plate = item Transformed_E_coli_Strain_id
end
  
take
  tube = 1 "14 mL test tube from media bay"
  LB = 1 "50 mL LB Aliquot"
end

step 

  description: "Media Preparation"
  note: "We will create the growth media for the cells"
  bullet: "Label the 14 mL test tube."
  check: "Use 1000 uL pipetter to pipett 2 mL of LB Aliquot to the test tube"
  warning: "Make sure that the LB media is not contaminated"
  warning: "Make sure that the test tube is capped after tranfer of LB Media"
  warning: "Do not let the pipetter itself touch the LB media""
end 

step

  description: "Adding Cells to the growth media"
  note: "We will add a tranformed E Coli colony to the prepared media"
  check: "Remove the parafilm from the plate"
  check: "Use a pipetter tip to pick 1 colony from the plate"
  check: "Carefully tilt your labeled test tube and scrap the colony inside the media"
end

produce
    1 "Overnight suspension culture" from plate[0]
end

step

  description: "Overnight Suspension"
  note: "We will now incubate the cells"
  check: "Place the test tube in the 37C shaker"
  
end

release plate
release LB
 


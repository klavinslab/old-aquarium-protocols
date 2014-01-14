information "Pour a 50 mL agarose gel."


argument
  percentage: number, "Enter the percentage gel to make (e.g. 1 = 1%)"
  comb_n: number, "Enter the number of combs to use (1 or 2)."
end


step
  description: "Transfer this protocol to the gel room."
  note: "Log out, go to the gel room (A5, A6, A7), and log in there to run this protocol - it will be under 'Protocols > Pending Jobs'."
end


take
  agarose = 1 "Ultrapure* Agarose"
end


gel_volume = 50.0
agarose_mass = (percentage / 100.0) * gel_volume
step
  description: "Add %{agarose_mass} g agarose to flask"
  note: "Go to the station at A5.300. Using a digital scale, measure out %{agarose_mass} g of agarose powder and add it to a clean flask. Add agarose by tipping and shaking the bag and remove excess to the waste container by folding the weigh paper."
end


step
  description: "Add 1X TAE"
  note: "Get a graduated cylinder from on top of the microwave at A5.305. Measure and add 50 mL of 1X TAE from jug J2 at A5.500 to the flask."
end


step
  description: "Microwave into solution"
  bullet: "Swirl the flask to mix for about two seconds."
  bullet: "Microwave 70 seconds on high, then swirl. The agarose should now be in solution."
  bullet: "If it is not in solution, microwave 7 seconds on high, then swirl. Repeat until dissolved."
  warning: "Use a paper towel to handle the flask."
end


take
  gel_green = 1 "GelGreen Nucleic Acid Stain"
end


gel_green_volume = gel_volume / 10.0  # in µL
step
  description: "Add %{gel_green_volume} µL GelGreen"
  note: "Using a 10 µL pipetter, pipet %{gel_green_volume} µL of GelGreen directly into the agarose, then swirl to mix."
  warning: "GelGreen is supposedly safe, but stains DNA and can transit cell membranes (limit your exposure)."
  warning: "GelGreen is photolabile. Limit its exposure to light by putting it back in the box."
end


release [agarose[0], gel_green[0]]


take
  gel_box = 1 "49 mL Gel Box With Casting Tray (clean)"
end


if comb_n == 1
  step
    description: "Add comb"
    note: "Retrieve a 6-well purple comb from A7.325. Position the gel box With the electrodes facing away from you. Add a purple comb to the side of the casting tray nearest the side of the gel box, thicker side down. Make sure it is well-situated in the groove of the casting tray."
  end
else
  step
    description: "Add combs"
    note: "Retrieve two 6-well purple combs from A7.325. Position the gel box With the electrodes facing away from you. Add a purple comb to each casting tray groove, thicker side down. Make sure it is well-situated in the groove of the casting tray."
  end
end


take
  gloves = 1 "Autoclave Gloves"
end


step
  description: "Pour the gel"
  note: "Using autoclave gloves, pour the gel from the flask into the casting tray. Pour slowly and in a corner for best results. Pop any bubbles with a 10 µL pipet tip."
end

release gloves


produce
  gel = 1 "50 mL 1 Percent Agarose Gel in Gel Box"
  location: "A7.325"
  release gel_box
end

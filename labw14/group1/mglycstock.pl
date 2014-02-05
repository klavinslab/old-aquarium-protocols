argument
 Transformed_E_coli_Strain_id: sample array, "A tube with overnight suspension culture"
end

step
 description: "This protocol describes how to make glycerol stock"
end

take
  glycerol_bottle = 1 "50 percent Glycerol (sterile)"
  glycerol_tube = length(tube) "Cryo tube"
  tube = item Transformed_E_coli_Strain_id
end

step
 description: "Put the overnight suspension culture tube into a holder"
end

step
 description: "Mixing glycerol with cell suspension"
 note: "Pipette 900 uL of the glycerol stock into the Cryo tube. Then pipette 900 uL of the overnight
 suspension culture into the same Cryo tube"
 bullet: "Label the Cryo tube with your initials, date and year"
 bullet: "Vortex the Cryo tube for 15-30 seconds"
 warning: "Be as sterile as possible. Do not touch the inside of the glycerol bottle with either a tip or pipette."
end

x = 0

r2 = []
while x < length(tube)
 produce
  r3 = 1 "Transformed E coli Glycerol Stock" from tube[x]
  release glycerol_tube
  note: "Place your Cryo tube in the -80 C refrigerator"
 end
 r2 = append(r2,r3[:id])
 x = x + 1
end

release glycerol_bottle
release tube

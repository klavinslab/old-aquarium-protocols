#this protocol describes how to set up a sequencing reaction to send to genewiz


argument 
  plasmids: sample("Plasmid Stock") array, "Enter the template plasmids you wish to create a sequencing reaction with"
  plasmids_lengths: number array, "Enter the length in basepairs of the above plasmids" 
  concentrations: number array, "Enter the concentration of the above plasmid samples in ng/µl"
  primers: sample("Primer") array, "Enter the primers you wish to use to set up a sequencing reaction"
  initials: string, "Your initials"
  tracking_no: string, "Enter the tracking number of your Genewiz order"
end

y=length(plasmids)

take
  plasmids_ids=item unique(plasmids)
end

take
  primers_ids=item unique(primers)
end

step
  description: "This protocol sets up a set of sequencing reactions to be sent to Genewiz for analysis."
end

step
  description: "Grab a 12 strip-well PCR tube and cap, and rest it in a green PCR tube rack. With the numbers FACING YOU, do the following:"
  check: "Label the right most well with the letters %{initials}01"
  check: "Label the left most well with the letter %{initials}12"
  note: "These wells will be refered to as 1 - 12"
end
if length(plasmids) > 12
  step
    description: "Grab a second 12 strip-well PCR tube and cap, and rest it in a green PCR tube rack. With the numbers FACING YOU, do the following:"
    check: "Label the right most well with the letters %{initials}13"
    check: "Label the left most well with the letter %{initials}24"
    note: "These wells will be refered to as 13 - 24"
  end
end
if length(plasmids) > 24
  step
    description: "Grab a third 12 strip-well PCR tube and cap, and rest it in a green PCR tube rack. With the numbers FACING YOU, do the following:"
    check: "Label the right most well with the letters %{initials}25"
    check: "Label the left most well with the letter %{initials}36"
    note: "These wells will be refered to as 25 - 36"
  end
end
if length(plasmids) > 36
  step
    description: "Grab a fourth 12 strip-well PCR tube and cap, and rest it in a green PCR tube rack. With the numbers FACING YOU, do the following:"
    check: "Label the right most well with the letters %{initials}37"
    check: "Label the left most well with the letter %{initials}48"
    note: "These wells will be refered to as 37 - 48"
  end
end
if length(plasmids) > 48
  step
    description: "Grab a fourth 12 strip-well PCR tube and cap, and rest it in a green PCR tube rack. With the numbers FACING YOU, do the following:"
    check: "Label the right most well with the letters %{initials}49"
    check: "Label the left most well with the letter %{initials}60"
    note: "These wells will be refered to as 49 - 60"
  end
end


count1=0

H20_req=[0]
DNA_req=[0]
plasmid_vol=[0]

while count1<y
  DNA_req[count1]=plasmids_lengths[count1]/10
  plasmid_vol[count1]=ceil(DNA_req[count1]/concentrations[count1])
  H20_req[count1]=12.5-plasmid_vol[count1]
  count1=count1+1
end

count2=0

while count2<y
  label=count2+1
  water=H20_req[count2]
    step  
      description: "Add %{water}µl of MGH20 to tube %{label}."
    end
  count2=count2+1 
end

count3=0

while count3<y
  label=count3+1
  primer=primers[count3][:id]
    step  
      description: "Add 2.5µl of %{primer} to tube %{label}."
    end
  count3=count3+1
end

count4=0

while count4<y
  label=count4+1
  plas=plasmids[count4][:id]
  plasvol=plasmid_vol[count4]
    step
      description: "Add %{plasvol}µl of plasmid %{plas} into tube %{label}"
    end
  count4=count4+1
end

step
  description: "Cap all strip well tubes"
end

step
  description: "Write %{tracking_no} on a small slip of paper."
end

step
  description: "Place all of the strip well tubes and the small strip of paper in a small plastic bag above B14.310 and place the bag into the Genewiz collection box"
end
 

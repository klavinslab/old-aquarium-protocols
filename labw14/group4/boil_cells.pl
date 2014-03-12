# Modified from existing protocol
# WARNING: Protocol assumes that all samples can be run in single PCR machine"

argument
  template_plate: sample array, "your plate from last week"
end

take
  platetemplate = item template_plate
end

sample_count = length(platetemplate)
step
  description: "Take %{sample_count} tubes from a PCR tube strip, label them 1 - %{sample_count}, and write your initials on it." 
end

step
  description: "Add 20 µL molecular grade water to each tube"
end

i=0
while i<sample_count
	current_plate = template_plate[i]
	current_tube=i+1
	
	step
	  description: "Pick a colony from plate %{current_plate} and put it into tube %{current_tube}"
	  check: "Find a colony in plate %{current_plate} that is medium sized, round, and isolated"
	  check: "Pick up the entire colony with a pipette tip and transfer it to tube %{current_tube}."
	end
	i = i+1
end

step
  description: "Place the tubes into thermal cycler T2 at B3.335"
end

step
  description: "Choose program on the thermal cycler"
  check: "Click Home then click Saved Protocol, choose LABW14 folder, choose BOIL."
  check: "Close the lid and click 'Run'."
  check: "Choose 20 µL option."
  image: "thermal_cycler_home"
end
step
  description: "Wait for 12 minutes for the cells to boil"
	timer: { hours: 0, minutes: 12, seconds: 0 }
end

step
  description: "Open the lid and take the PCR tubes you placed."
  note: "Place tubes on your bench, these tubes will be used as your boiled cell 1 - %{sample_count} for the following reaction setup."
end
#produces 4 templates.  Each template has 3 primers and 2 reactions (f+r1,f+r2)


release platetemplate
log 
	return: {sample_count: sample_count}
end


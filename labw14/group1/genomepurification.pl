argument
  eDNA: sample, "Extracted DNA"
end

step
  description: "Purify the extracted genome."
end

take
  extracted_DNA = item eDNA[:id]
  kit = 1 "Zymo Genomic DNA Clean & Concentrator Kit"
end

step
  description: "Prepare the purification Column"
  warning: "Check that the DNA Wash Buffer is labled as having ethanol added.  If not, do so now as instructed on the bottle."
  check: "Pipette a volume of ChIP DNA Binding Buffer equal to twice the volume of DNA extracted into the tube.  Mix thoroughly"
  check: "Transfer the mixture into a new Zymo-Spin IC-XL Column.  Place the Column in a Collection Tube."
end

step
  description: "DNA Purification 1"
  check: "Centerfuge the collection Tube for 30 seconds.  Discard and replace the collection tube."
  check: "Add 200uL DNA Wash Buffer to the column.  Centerfuge for 1 minute.  Discard and replace the collection tube."
end

step
  description: "DNA Purification 2"
  check: "Add 200uL DNA Wash Buffer to the column.  Centerfuge for 1 minute.  Discard and replace the collection tube."
  check: "Pipette 15 uL DNA Elution Buffer directly into the filter of the column.  Allow to incubate for 1 minute at room tempurature."
  check: "Place the column in a 1.5mL tube.  Centrifuge for 30 seconds to elute the DNA.  The tube contains purified DNA.  The column can be discarded."
end

#produce
 # r = 1 "Purified DNA" from eDNA[0]
  #release eDNA
  #note: "Store the tube containing purified DNA at the bench for the next step."
#end

modify
  extracted_DNA[0]
  location: "Bench"
  inuse: 0
end

release kit

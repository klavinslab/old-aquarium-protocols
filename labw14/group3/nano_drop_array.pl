argument
  fragment_array: sample array,"An array of nucleic acid samples that you want to measure its concentration"
end

n = length(fragment_array)

take
  y = item fragment_array
end

information "Measure Nucleic Acid Concentration using Nanodrop Spectrophotometer."

step
  description: "Go to location B3.405, and find the Nanodrop"
end

step
  description: "Open Nanodrop Software and Initialize"
  check: "Verify the Nucleic Acid program is selected"
  note: "If initialization is necessary proceed with this step, if not skip ahead."
  check: "Wipe both lower (sensor) pedestal and the upper (lid) pedestal with Kimwipe."
  check: "Add 1.5 µL of Molecular Grade Water on the lower pedestal."
  check: "Close the pedestal."
  check: "Click Initialize in the software."
end

step
  description: "Blank the Nanodrop"
  note: "If Initialization was necessary, the same water sample can be used to blank."
  check: "Wipe both lower (sensor) pedestal and the upper (lid) pedestal with Kimwipe."
  check: "Add 1.5 µL of Molecular Grade Water on the lower pedestal."
  check: "Close the pedestal."
  check: "Click Blank in the software."
end

i = 0
conc = []
while i < n
  id = fragment_array[i]
  step
    description: "Measure the Sample"
    check: "Open the pedestal"
    check: "Wipe both lower (sensor) pedestal and the upper (lid) pedestal with Kimwipe."
    check: "Add 1.5 µL of your sample with id %{id} on the lower pedestal."
    check: "Close the pedestal."
    check: "Click Measure in the software."
  end
  
  step
    description: "Record the concentration shown on the nanodrop computer"
    getdata
      conc_of_strain: number,"Write down the number shown on the computer after ng/µL"
    end
  end
  conc = append(conc,conc_of_strain)
  i = i+1
end

step
  description: "Clean the Nanodrop"
  check: "Open the pedestal"
  check: "Wipe both lower (sensor) pedestal and the upper (lid) pedestal with Kimwipe!"
end

log
  return:{conc_array: conc}
end

release y

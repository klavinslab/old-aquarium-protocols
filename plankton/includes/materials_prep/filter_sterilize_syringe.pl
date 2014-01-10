argument
  volume: number, "The volume to sterilize in mL (maximum of 30 mL)."
  name: string, "The name of the solution being sterilized, e.g. 'the solution'."
end


take
  tube = 1 "50 mL Falcon Tube"
  filter = 1 "25 mm Syringe Filter"
  syringe = 1 "30 mL Syringe"
end


step
  description: "Draw up %{volume} mL of %{name} into the syringe and attach the filter"
  note: "Loosen the cap of the falcon tube. Remove the backing from the filter package so the filter is easy to access.\n\nUsing the syringe (without filter), draw up %{volume} mL of %{name}. Screw the syringe onto the filter."
  warning: "Never touch the bottom or sides of the filter - they must remain sterile."
end


step
  description: "Dispense into falcon tube"
  note: "Dispense the solution through the filter into the falcon tube. When done dispensing, replace the falcon tube cap."
  warning: "Do not touch the filter to the falcon tube."
end


# Nothing is produced - it's up to you to keep track of that!


release [filter[0], syringe[0]]

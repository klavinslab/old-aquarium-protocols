argument
  aTc_inducer_in: object, "The aTc inducer to add"
  plate_chart: string, "The filename of the chart to use"
end

take
  aTc_inducer = 1 aTc_inducer_in
  note: "The aTc should be in a box marked 'INDUCERS'."
end

step
  description: "Add the inducer to the wells indicated in the chart"
  note: "Be sure the solution is fully melted.  You can hold it to warm it up."
  check: "Pipette 1uL of aTc solution into each well labelled '0hr' in orange"
  note: "Use a new tip each time to avoid contamination"
  image: "%{plate_chart}"
end

release aTc_inducer

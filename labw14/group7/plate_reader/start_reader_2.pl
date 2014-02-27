step
  description: "Start the plate reader software"
  note: "The reader takes some time to warm up, so it is started before you prepare your samples"
  check: "Move to the 'Biotech Synergy HT' plate reader at location B9.355"
  image: "plate_reader_closed"
end

step
  description: "Start the plate reader software"
  check: "On the accompanying computer, click the start menu, type in 'Gen5 1.11'"
  check: "Confirm that you see 'Gen5 1.11' as an option, and enter to run the 'Biotech Gen5' software"
end

step
  description: "Clear the previous data"
  check: "In the intro pop-up menu, open the file 'Lab B Sample Run' (Look in recent files)"
  check: "Immediately go to 'File->Save As...', and save this into a new file name"
  check: "Click on 'Procedure->Change run time' to clear all previous data"
  image: "read_plate_prompt"
end
step
  description: "Warm up the plate reader to 37C"
  check: "Click on the 'Read Plate' button (at the top) to start the program."
  image: "Read_plate"
  check: "Click the 'Read' button in the dialog that opens. This should produce a pop-up asking your to wait for the bulb to heat up to 37C"
  note: "You will now start loading your 96 well plate while the plate reader warms up"
end

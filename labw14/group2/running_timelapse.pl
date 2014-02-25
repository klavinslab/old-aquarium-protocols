step
  description: "Adjust the Nikon software settings for running timelapse"
  note: "Click next to begin this protocol"
end 

step
  description: "Load optical settings"
  bullet: "Click on the 'Calibration' menu"
  bullet: "Click on 'Optical Configuration' option"
  bullet: "Click on the 'Restore' button"
  bullet: "Navigate to D:/LABW14/Phase GRCY .xml"
  bullet: "Open the file to apply settings"
end

step
  description: "Time adjustments"
  bullet: "Find the ND acquisition window and click on the Time tab"
  bullet: "To set the phase make sure the box for number 1 is checked"
  bullet: "Set interval to 10 min"
  bullet: "Set duration to 8 hours"
  bullet: "Make sure Z-series is unchecked"
  bullet: "Under the Lambda tab, set the first drop down menu to Ph-GFP, and the second one to GFP"
end

step
  description: "Save File"
  bullet: "Make sure save to file is checked under the ND Acquisition tab"
  bullet: "Click on browse and save the file in D:/LABW14/date(YMD),initials"
end

step
  description: "Test time-lapse"
  bullet: "Click on '1 time loop'. This takes an image of all your cells only once."
  bullet: "Once you have the images, you can click on the toolbar at the bottom of the image window to view them"
  bullet: "Find the LUTs window"
  bullet: "Adjust the Ph GFP and GFP bandwidth according to the brightness level needed to make the cells visible"
end

step
  description: "Run time-lapse"
  bullet: "Click on 'play now' to begin the cycle"
  bullet: "This protocol is now complete, and so is Day 2!" 
end

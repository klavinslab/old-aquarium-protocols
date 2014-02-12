argument
  
  ddPhiX : sample, "Denatured and Diluted PhiX Control"
  ddSample : sample, "Denatured and Diluted Sample Library"

end

step
  
  description : "This protocol describes the process for combining the sample library and PhiX Control."

end


take

  ddPhiX1 = item ddPhiX
  ddSample1 = item ddSample

end

step 

  description : "Combine the PhiX Control and Sample Library"
  check: "Pick a 1.5 mL tube and label it D."
  check : "Add 6 uL of Denatured and Diluted PhiX Control to tube D"
  check : "Add 594 uL of Denatured and Diluted Sample Library to tube D"

end

step 
  
  description : "Store the combined sample library"
  check : "Place the combined sample library (tube D) on ice in a styrofoam box (can be found at SF2 : B14.315)"
  Warning : "The combined sample library should be kept on ice till you are ready to use the  MiSeq reagent cartridge"
  note : "MiSeq is the machine we will use for sequencing"
  
end

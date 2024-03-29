# plasmids_to_make = append ( plasmid_summary, 
#        { plasmid_name: name,
#          letter: letters[j],
#          start: 1,
#          end: quantity,
#          quantity: quantity,
#          total_fragments_vol: total_fragments_vol,
#          vol_with_master_mix: vol_with_master_mix,
#          vol_mg_water_to_add: vol_mg_water_to_add  })
#   pipetting_plan = [
#         [{ fragment_name: name, 
#           fragment_ids: [ ], # fragments to take from
#           total_amount: total,
#           plasmid_letter_start_end_amounts: [ 
#            { plasmid_name: p_name,
#              letter: A, # pipette into tubes A1 through A3 inclusive
#              start: 1, 
#              end: 3,
#              amount: f[:amount]}, ... ]
#                     , ... ]
argument
  plasmids_to_make: sample, "a hash with plasmids"
  pipetting_plan: sample, "a hash with fragment names and amounts"
  gibson_master_mix_amt: number, "Amount of Gibson master mix to add to PCR tube, in uL"
  gibson_master_mix: sample array, "Gibson master mix (plus backup ids, not yet used)"
end

function collect_from_hash(hash, nested_key_array)
  # each level should give back an array
  # or allow placeholders like * to denote
  # when get a hash back or an array back, etc
  local vals = hash
      
end

to_release = [ ]
#  pattern - edit tags / values in hashes on datastructures
# like [:this_protocol][:completed] = true
# instead of holding values in memory / putting them in arrays

step
  description: "Take fragments for Gibsons"
  note: "Go to the locations listed on the next page to take fragments for all the gibsons.
         You don't need to keep them on ice."
end

# iterate over pipetting plan and collect fragment ids
fragments = [ ]
foreach f in pipetting_plan
  fragments = concat(fragments, f[:fragment_ids])
end

fragments = unique(fragments)

take
    x = item fragments
    molecular_g_h2o = 1 "Molecular Biology Grade Water"
end

to_release = x
to_release = concat(to_release, molecular_g_h2o)

sum = 0
foreach p in plasmids_to_make
  sum = sum + p[:quantity]
end

#probably do this in groups instead
step
  description: "Take %{sum} PCR tubes"
  note: "Take enough PCR tubes for the next labeling steps.
         Keep them separate by letter since you will
         pipette by letter groups. Take enough small green tube racks, 
         to hold the PCR tubes, and flip the green tube racks upside down."
end

foreach p in plasmids_to_make
  num = p[:quantity]
  l = p[:letter]
  vol_mg_water_to_add = p[:vol_mg_water_to_add]
  if vol_mg_water_to_add > 0
    step
      description: "Label %{num} PCR tube(s) and pipette MG water"
      note: "Label %{num} PCR tubes, %{l}1 to %{l}%{num}
           by writing on the sides of the tubes near the top
           (otherwise they will be smudged off, see second picture).
           Pipette %{vol_mg_water_to_add}uL of MG water into each tube.
           Place the tubes open in separate rows by letter.
           Leaving the tubes open in the tube rack will help you go faster
           in the next pipetting steps."
    end
  else
    step
      description: "Label %{num} PCR tube(s)"
      note: "Label %{num} PCR tubes, %{l}1 to %{l}%{num}
           by writing on the sides of the tubes near the top
           (otherwise they will be smudged off, see second picture).
           Place the tubes open in separate rows by letter.
           Leaving the tubes open in the tube rack will help you go faster
           in the next pipetting steps."
    end
  end
end

#for each pipetting step, do that step
foreach p in pipetting_plan
  f_name = p[:fragment_name]
  f_ids = p[:fragment_ids]
  targets = p[:plasmid_letter_start_end_amounts]
  step
      description: "Pipette %{f_name} in the next screen(s)"
      note: "Fragment %{f_name} is in tube(s) with id(s) %{f_ids}.
             You may have multiple tubes to avoid running out of fragment stock as you go.
             On the next few screens, you will pipette the amount shown into the PCR tubes
             you labeled.
             There will be a separate screen for each set, which are summarized
             below:
             %{targets}"
  end
    
  foreach t in targets
    amt = t[:amount]
    start = t[:start]
    stop = t[:end]
    l = t[:letter]
    step
     description: "Pipette %{f_name} into sample(s)"
     note: "Pipette %{amt} microliters of fragment (drawing any of %{f_ids}) into each of tube(s)
             %{l}%{start} to %{l}%{stop}, inclusive."
    end
  end # todo put all on one screen nicely once can concat strings

end


step
  description: "Check there is an open thermocycler"
  note: "In the next step you'll add Gibson master mix.
         The exonuclease in gibson master mix begins eating fragments immediately
         after you put it in. Check there is an available thermocycler with
         enough space before adding the gibson master mix. If not, wait until
         there is an open thermocycler and continue then."
end

first = gibson_master_mix[0]

take
  gmix = item first
end

to_release = concat(to_release, gmix)
gmix_id = gmix[0][:id]

step
  description: "Start the Gibson reaction"
  note: "Add %{gibson_master_mix_amt}µL of gibson aliquot (id = %{gmix_id}) to each tube. Do this expediently,
         starting with A tubes, then B tubes, etc."
end

step
  description: "Put the gibsons into the thermocycler."
  note: "Take the tubes to the thermocycler and log into the station there,
         or you can click through the steps here.
         You'll put them in for 60 minutes at a 50C hold"
end

#silently produce gibsons
completed_samples = [ ]
foreach p in plasmids_to_make
  name = p[:plasmid_name]
  num = p[:quantity]
  letter = p[:letter]
  
  i = 1
  while i <= num
    temp_label = letter + to_string(i)
    produce silently
       r = 1 "Gibson Reaction Result" of name
       location: "Thermocycler"
       data
           fragment_amounts: p[:fragment_amounts_in_ul]
           temp_label: temp_label
       end
    end
    
    completed_samples = append (completed_samples, r)
    
    i = i + 1
  end
end

# call step from a library here

# nice to have enter the gibsons that you put in the thermocycler, ids of ones that you didn't
# plus time to check back, since if making many, may not have enough thermocycler space


#Nice to have - if ran out of fragment stock or no stock for that fragment
# let people specify the tubes here, then reschedule them
# might be better to implement a generic exeption step for that, anything produce in the protocol
# let the user manipulate the inventory / reschedule them
# need a generic way to reconstruct the datastructure used to produce them to do that
aborted_samples = [ ] # route these to another protocol to just put them in the thermocycler

log
  return: {completed_samples: completed_samples, aborted_samples: aborted_samples} # put resulting samples from produce here
end

release to_release

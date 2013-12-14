information "Prepare unsterile bottle(s) of 800 mL LB Media (rich media for bacteria), ready to be autoclaved."


product_name = "800 mL LB Liquid (unsterile)"


argument
  n_bottle: number, "Enter the number of bottles you want to make (maximum of 4)."
end


if n_bottle < 1 || n_bottle > 4
  step
    description: "There were more than 4 bottles specified or the number is negative"
    note: "You can only specify 1-4 bottles!"
    getdata
      n_bottle: number, "Enter the number of bottles you want to make.", [1, 2, 3, 4]
    end
  end
end


take
  bottles = n_bottle "1 L Bottle"
  lb_powder = 1 "Difco LB Broth, Miller"
end


# Make a temporary label for the bottles - just a number
step
  description: "Add temporary labels"
  note: "Using lab tape, number each bottle (from 1 up to 4)."
end


step
  description: "Remove autoclave tape"
  note: "Remove any old autoclave tape from each bottle."
end


# Add LB Powder
include "plankton/includes/materials_prep/add_dry_reagent.pl"
  container: "each bottle"
  reagent: "%{lb_powder}"
  mass: 20
end


# Clean the spatula before returning it
include "plankton/includes/materials_prep/clean_spatula.pl"
end


step
  description: "Add deionized water"
  note: "Fill each bottle to the 800 mL mark with deionized water."
end


step
  description: "Cap and mix."
  note: "Tightly close the caps on each bottle and shake until all contents are dissolved. To check for dissolution, let bottle rest for 10 seconds, and then pick up and look for sediment on the bottom. This should take approximately 20 seconds."
end


produce
  produced_bottles = n_bottle product_name
  release bottles
  note: "Write %{product_name} and the date on the label in addition to the above id number."
  location: "B1.320"
end


release lb_powder

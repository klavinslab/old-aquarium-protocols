information "Prepare unsterile bottle(s) of LB (rich media for bacteria)."
# FIXME: parameterize for adding IPTG, aTc, X-Gal


argument
  n_bottle: number, "Enter the number of bottles you want to make (maximum of 4)."
  volume: number, "Enter the media volume (200, 400, or 800 mL)."
  add_agar: string, "Make agar media? (Yes or No)"
end


if n_bottle < 1 || n_bottle > 4
  step
    description: "The number of bottles was incorrectly entered as %{n_bottle}."
    note: "You can only specify 1-4 bottles!"
    getdata
      n_bottle: number, "Enter the number of bottles you want to make.", [1, 2, 3, 4]
    end
  end
end


if volume != 200 && volume != 400 && volume != 800
  step
    description: "The LB volume was incorrectly entered as %{volume}."
    getdata
      volume: number, "Enter the volume of LB to make.", [200, 400, 800]
    end
  end
end


if add_agar != "Yes" && add_agar != "No"
  step
    description: "The question of whether this is to be agar media was incorrectly entered as %{add_agar}."
    note: "You can only specify Yes or No! Hassle the person who scheduled this protocol."
    getdata
      add_agar: string, "Should this be a batch of agar media?", ["Yes", "No"]
    end
  end
end

bottle_type = "250 mL Bottle"
if volume == 200
  bottle_type = "250 mL Bottle"
elsif volume == 400
  bottle_type = "500 mL Bottle"
elsif volume == 800
  bottle_type = "1 L Bottle"
end

lb_powder = 1 "Difco LB Broth, Miller"
lb_grams = 29.6
product_name = ""

lb_grams = 0.0
bottles = {}
if add_agar == "Yes"
  product_name = "%{volume} mL LB Agar (unsterile)"
  if volume == 200
    lb_grams = 7.4
  elsif volume == 400
    lb_grams = 14.8
  else
    lb_grams = 29.6
  end
  take
    bottles = n_bottle bottle_type
    lb_powder = 1 "LB Agar Miller"
  end
else
  product_name = "%{volume} mL LB Liquid (unsterile)"
  if volume == 200
    lb_grams = 5.0
  elsif volume == 400
    lb_grams = 10.0
  else
    lb_grams = 20.0
  end
  take
    bottles = n_bottle bottle_type
    lb_powder = 1 "Difco LB Broth, Miller"
  end
end

stir_bars = {}
if volume == 800
  take
     stir_bars = n_bottle "Medium Magnetic Stir Bar"
  end
  step
    description: "Add stir bars."
    note: "Add one stir bar to each bottle."
  end
end

step
  description: "Add temporary labels"
  note: "Using lab tape, number each bottle (from 1 up to 4)."
end


step
  description: "Remove autoclave tape"
  note: "Remove any autoclave tape from each bottle."
end


# Add LB Powder
lb_name = lb_powder[0][:name]
include "includes/materials_prep/add_dry_reagent.pl"
  container: "each bottle"
  reagent: lb_name
  grams: lb_grams
end


# Clean the spatula before returning it
include "includes/materials_prep/clean_spatula.pl"
end


step
  description: "Add deionized water"
  note: "Fill each bottle to the %{volume} mL mark with deionized water."
end


if add_agar == "Yes"
  step
    description: "Cap and mix."
    note: "Tightly close the caps on each bottle and shake until all contents are dissolved. To check for dissolution, let bottle rest for 10 seconds, and then pick up and look for sediment on the bottom. This should take approximately 60 seconds."
  end
else
  step
    description: "Cap and mix."
    note: "Tightly close the caps on each bottle and shake until all contents are dissolved. To check for dissolution, let bottle rest for 10 seconds, and then pick up and look for sediment on the bottom. This should take approximately 20 seconds."
  end
end

if volume == 800
  produce
    produced_bottles = n_bottle product_name
    release bottles
    release stir_bars
    note: "Write %{product_name} and the date on the label in addition to the above id number."
    location: "B1.320"
  end
else
  produce
    produced_bottles = n_bottle product_name
    release bottles
    note: "Write %{product_name} and the date on the label in addition to the above id number."
    location: "B1.320"
  end
end


release lb_powder

argument
  transformed_yeast_plate: sample array, "A plate with yeast colonies"
end

num = length(transformed_yeast_plate)

step
 description: "This protocol describes how to make an overnight yeast suspension"
 warning: "You're going to make %{num} overnight suspension tubes"
end

take
  test_tube    = num "14 mL Test Tube"
  falcon_tube  = 1 "50 mL YPAD liquid aliquot (sterile)"
  plate        = item transformed_yeast_plate
end

ii = 0
r = []

while ii < length(transformed_yeast_plate)

  produce
    y = 1 "Overnight suspension" from plate[ii]
    release test_tube[ii]
  end

  r = append(r,y[:id])
  ii=ii+1
end

log
  return: { yeast_overnight_suspension: r }
end

release plate
release falcon_tube

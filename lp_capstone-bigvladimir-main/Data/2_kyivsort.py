text = ""
with open("families.pl", "r") as file:
  for line in file:
    if "Киевск" in line:
      text += line

with open("kyivfamilies.pl", "w") as file:
  file.write(text)
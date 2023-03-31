result = []
filename = "royal_gen_20_11_2002.ged"
#filename = input("filename < ");
gedFile = open(filename, "r", encoding="utf-8")
#чтение нужных элементов из файла и форматирование имён
for line in gedFile:
    for each in ["NAME", "FAMS", "FAMC", "SEX"]:
        if each in line:
            newline = line.split(' ')[1:]
            newline[-1] = newline[-1].replace("\n", "")
            if newline[0] == "NAME":
              newline[1] = " ".join(newline[1:]).replace("/", "").replace("'", "")
              del newline[2:]
            result.append(newline)
gedFile.close()

print("File reading completed.")

#удаление неизвестных имён
k = 0
for i in range(len(result) - 1, 0, -1):
    if result[i][0] != "NAME":
        k = k + 1
    else:
        if (len(result[i][1]) == 0) or (result[i][1][0] == '?') or (result[i][1][-1] == '?') or (result[i][1][0:2] == "N "):
            while k >= 0:
                del result[i]
                k = k - 1
        k = 0

print("Cleaning names completed.")

families = []
cur_name = ""
cur_sex = ""

counter = 1
for element in result:
    if element[0] == "NAME":
        cur_name = element[1]
      
        if counter % 500 == 0:
          print(counter)
        counter += 1
      
        continue
    if element[0] == "SEX":
        cur_sex = element[1]
        continue
    isFound = False
    index = 0
    for familyIndex in range(len(families)):
        if families[familyIndex][0] == element[1]:
            isFound = True
            index = familyIndex
            break

    if isFound == True:
        if element[0] == "FAMS":
            families[index][1].append([cur_name, cur_sex])
        else:
            families[index][2].append([cur_name, cur_sex])
    else:
        families.append([])
        families[-1].append(element[1])
        families[-1].append([])
        families[-1].append([])
        if element[0] == "FAMS":
            #родитель
            families[-1][1].append([cur_name, cur_sex])
        else:
            #ребёнок
            families[-1][2].append([cur_name, cur_sex])

print("Data processing completed.")

output = open("families.pl", "w", encoding="utf-8")
facts = []

for family in families:
    if len(family[2]) == 0:
        continue
    for child in family[2]:
        for parent in family[1]:
            if parent[1] == "M":
                facts.append("father(\'" + parent[0] + "\', \'" + child[0] + "\').\n")
            else:
                facts.append("mother(\'" + parent[0] + "\', \'" + child[0] + "\').\n")

facts.sort(key=lambda st: st[0])
for i in facts:
    output.write(i)

output.close()

print("File writing completed.")
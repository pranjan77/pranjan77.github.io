import json
with open("out.txt") as file:
    lines = file.read().split("\n")

lines = filter(bool, lines)
#remove header line.
#lines = lines[1:]

entries = {}

#create an entry for each child node.
for line in lines:
	 #print line
     name , level, child, size = line.split("\t")
     entries[child] = {"name": child, "size": int(size), "children": []}

#we now have an entry for all nodes that are a child of another node.
#but not for the topmost parent node, so we'll make one for it now.

parents  = set(line.split()[0] for line in lines)
children = set(line.split()[2] for line in lines)
top_parent = (parents - children).pop()

#(just guess the size, since it isn't supplied in the file)

entries[top_parent] = {"name": top_parent, "size": 5000, "children": []}

#hook up each entry to its children
for line in lines:
    name, level, child, size = line.split("\t")
    entries[name]["children"].append(entries[child])


for entry in entries.itervalues():
    if not entry["children"]:
        del entry["children"]
        
#the nested structure is ready to use!
structure = entries[top_parent]

#display the beautiful result
#import pprint
#pprint.pprint(json.dumps(structure))
print json.dumps(structure)


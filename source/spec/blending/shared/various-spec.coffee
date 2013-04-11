# http://stackoverflow.com/questions/728360/most-elegant-way-to-clone-a-javascript-object
#// This would be cloneable:
#var tree = {
#    "left"  : { "left" : null, "right" : null, "data" : 3 },
#    "right" : null,
#    "data"  : 8
#};
#
#// This would kind-of work, but you would get 2 copies of the
#// inner node instead of 2 references to the same copy
#var directedAcylicGraph = {
#    "left"  : { "left" : null, "right" : null, "data" : 3 },
#    "data"  : 8
#};
#directedAcyclicGraph["right"] = directedAcyclicGraph["left"];
#
#// Cloning this would cause a stack overflow due to infinite recursion:
#var cylicGraph = {
#    "left"  : { "left" : null, "right" : null, "data" : 3 },
#    "data"  : 8
#};
#cylicGraph["right"] = cylicGraph;
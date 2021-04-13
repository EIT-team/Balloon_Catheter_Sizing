# mesh a step file with sizing field, this is based on t10.py

#%% Load files
import gmsh
import os
import meshio

gmsh.initialize()
gmsh.option.setNumber("General.Terminal", 1)

# inpath='15mm_height/new9fr/elliptical6mm_oriented.step'
inpath ='15mm_height/9fr/elliptical15mm.step'
outname='15mm_height/9fr/elliptical15mm' # saved as .msh and .vtu

# Let's merge an STEP mesh that we would like to remesh (from the parent
# directory):
path = os.path.dirname(os.path.abspath(__file__))
gmsh.merge(os.path.join(path, inpath))

model = gmsh.model
fields = model.geo


#%% Make sizing field

# define a line through the middle z=0 x=150 x=-150 y=0.7
# todo - define the line in the cad model

# could use the MathEval option too?

Lmin = 0.25 # smallest size in mesh units -> make them smaller
Lmax = 0.25 # biggest size -> to increase elements -> make smaller to increase


DistMin = 1.5 + 1
DistMax= 7.5 # 7 radius of outer wall in this example

PointTag1 = fields.addPoint(0, 0, 100, Lmin)
PointTag2 = fields.addPoint(0, 0, -100, Lmin)
LineTag = fields.addLine(PointTag1, PointTag2)

# update all points
fields.synchronize()

# add a distance field - gives a value of the distance of every point in mesh to points we describe
DistanceField=model.mesh.field.add("Distance")

# create 100 points along the line with made down the middle
model.mesh.field.setNumber(DistanceField, "NNodesByEdge", 100)
model.mesh.field.setNumbers(DistanceField, "EdgesList", [LineTag])

# We then define a `Threshold' field, which uses the return value of the
# `Distance' field 1 in order to define a simple change in element size
# depending on the computed distances
#
# LcMax -                         /------------------
#                               /
#                             /
#                           /
# LcMin -o----------------/
#        |                |       |
#      Point           DistMin DistMax
ThresField=model.mesh.field.add("Threshold")
model.mesh.field.setNumber(ThresField, "IField", DistanceField)
model.mesh.field.setNumber(ThresField, "LcMin", Lmin)
model.mesh.field.setNumber(ThresField, "LcMax", Lmax)
model.mesh.field.setNumber(ThresField, "DistMin", DistMin)
model.mesh.field.setNumber(ThresField, "DistMax", DistMax)

# set this threshold field as the background sizing field
model.mesh.field.setAsBackgroundMesh(ThresField)

# turn off any sizing based on geometry
gmsh.option.setNumber("Mesh.CharacteristicLengthExtendFromBoundary", 0)
gmsh.option.setNumber("Mesh.CharacteristicLengthFromPoints", 0)
gmsh.option.setNumber("Mesh.CharacteristicLengthFromCurvature", 0)


#%% Generate mesh

gmsh.model.mesh.generate(3)

# these take a while to run so i recommend turning them off to start with
# then run them when you are happy with the sizing field choice

model.mesh.optimize('',niter=10)
model.mesh.optimize('Netgen',niter=10)

# this opens the result in gmsh. uncomment to view it. you must close gmsh to run the rest of the script
gmsh.fltk.run()

#%% Save meshfile

gmsh.write(os.path.join(path,outname + ".msh"))
gmsh.finalize()

# you can now load the .msh file in paraview

# meshio saves it better to vtu (binary compressed) this makes it easy to load into paraview
m = meshio.Mesh.read(os.path.join(path,outname + ".msh"))
m.write(os.path.join(path, outname + ".vtu"))

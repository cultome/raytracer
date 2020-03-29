import raytracerpkg/matrices

type
  Sphere* = ref object
    transformation*: Matrix

proc sphere*(): Sphere =
  Sphere(transformation: identity(4))

import raytracerpkg/matrices
import raytracerpkg/tuples

type
  Sphere* = ref object
    transformation*: Matrix

proc sphere*(): Sphere =
  Sphere(transformation: identity(4))

proc normalAt*(s: Sphere, p: Point): Vector =
  (p - point(0, 0, 0)).normalize

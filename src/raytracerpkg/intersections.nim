import raytracerpkg/spheres

type
  Intersection* = ref object
    t*: float64
    obj*: Sphere

proc intersection*(t: float64, obj: Sphere): Intersection =
  Intersection(t: t, obj: obj)

proc intersections*(intersections: varargs[Intersection]): seq[Intersection] =
  @intersections

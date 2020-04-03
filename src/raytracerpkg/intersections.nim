import algorithm
import strutils
import options

import raytracerpkg/spheres

type
  Intersection* = ref object
    t*: float64
    obj*: Sphere

proc `<`*(a, b: Intersection): bool =
  a.t < b.t

proc `==`*(a, b: Intersection): bool =
  a.t == b.t

proc `$`*(a: Intersection): string =
  "(t: $1, obj: $2)" % [$a.t, $type(a.obj)]

proc initIntersection*(t: float64, obj: Sphere): Intersection =
  Intersection(t: t, obj: obj)

proc intersections*(intersections: varargs[Intersection]): seq[Intersection] =
  @intersections

proc hit*(intersections: seq[Intersection]): Option[Intersection] =
  for i in (@intersections).sortedByIt(it.t):
    if i.t >= 0:
      return some(i)

  none(Intersection)

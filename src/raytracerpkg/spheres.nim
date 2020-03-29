import math

import raytracerpkg/tuples
import raytracerpkg/rays

type
  Sphere = ref object

proc sphere*(): Sphere =
  Sphere()

proc intersect*(s: Sphere, r: Ray): seq[float64] =
  var
    sphereToRay = r.origin - point(0, 0, 0)
    a = r.direction.dot(r.direction)
    b = 2 * r.direction.dot(sphereToRay)
    c = sphereToRay.dot(sphereToRay) - 1
    discriminant = pow(b, 2) - (4 * a * c)

  if discriminant < 0:
    return @[]

  var
    t1 = ((-b) - sqrt(discriminant)) / (2 * a)
    t2 = ((-b) + sqrt(discriminant)) / (2 * a)

  @[t1, t2]

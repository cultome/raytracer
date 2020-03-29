import math

import raytracerpkg/tuples
import raytracerpkg/matrices
import raytracerpkg/spheres
import raytracerpkg/intersections

type
  Ray* = ref object
    origin*: Point
    direction*: Vector

proc ray*(origin: Point, direction: Vector): Ray =
  Ray(origin: origin, direction: direction)

proc position*(r: Ray, distance: float64): Point =
  r.origin + (r.direction * distance)

proc transform*(r: Ray, transformation: Matrix): Ray =
  ray(point(0, 0, 0), vector(0, 0, 0))

proc intersect*(r: Ray, s: Sphere): seq[Intersection] =
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

  @[intersection(t1, s), intersection(t2, s)]

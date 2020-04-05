import math
import algorithm
import options

import raytracerpkg/computation
import raytracerpkg/spheres
import raytracerpkg/tuples
import raytracerpkg/matrices
import raytracerpkg/intersections
import raytracerpkg/world

type
  Ray* = ref object
    origin*: Point
    direction*: Vector

proc initRay*(origin: Point, direction: Vector): Ray =
  Ray(origin: origin, direction: direction)

proc position*(r: Ray, distance: float64): Point =
  r.origin + (r.direction * distance)

proc transform*(r: Ray, transformation: Matrix): Ray =
  var
    tOrigin = cast[Point](transformation * r.origin)
    tDir = cast[Vector](transformation * r.direction)

  initRay(tOrigin, tDir)

proc intersect*(r: Ray, s: Sphere): seq[Intersection] =
  var
    tr = r.transform(s.transformation.inverse)
    sphereToRay = tr.origin - initPoint(0, 0, 0)
    a = tr.direction.dot(tr.direction)
    b = 2 * tr.direction.dot(sphereToRay)
    c = sphereToRay.dot(sphereToRay) - 1
    discriminant = pow(b, 2) - (4 * a * c)

  if discriminant < 0:
    return @[]

  var
    t1 = ((-b) - sqrt(discriminant)) / (2 * a)
    t2 = ((-b) + sqrt(discriminant)) / (2 * a)

  @[initIntersection(t1, s), initIntersection(t2, s)]

proc intersect*(r: Ray, w: World): seq[Intersection] =
  for obj in w.objects:
    result.add(r.intersect(obj))

  result.sort

proc prepareComputation*(r: Ray, i: Intersection): Computation =
  var
    inside = false
    point = r.position(i.t)
    eye = !r.direction
    normal = i.obj.normalAt(point)

  if normal.dot(eye) < 0:
    inside = true
    normal = !normal

  initComputation(i.t, i.obj, point, eye, normal, inside)

proc colorAt*(r: Ray, w: World): Color =
  var
    xs = r.intersect(w)
    hitOpt = xs.hit

  if hitOpt.isNone:
    return initColor(0, 0, 0)

  var comps = r.prepareComputation(hitOpt.get)
  w.shadeHit(comps)

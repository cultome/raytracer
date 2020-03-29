import raytracerpkg/tuples
import raytracerpkg/matrices

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

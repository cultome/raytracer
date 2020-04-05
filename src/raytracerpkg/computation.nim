import strutils

import raytracerpkg/tuples
import raytracerpkg/spheres

type
  Computation* = ref object
    t*: float64
    obj*: Sphere
    point*: Point
    eye*: Vector
    normal*: Vector
    inside*: bool

proc `$`*(c: Computation): string =
  "{t: $1, obj: $2, point: $3, eye: $4, normal: $5,}" % [$c.t, $c.obj, $c.point, $c.eye, $c.normal]

proc initComputation*(t: float64, obj: Sphere, point: Point, eye: Vector, normal: Vector, inside: bool): Computation =
  Computation(t: t, obj: obj, point: point, eye: eye, normal: normal, inside: inside)

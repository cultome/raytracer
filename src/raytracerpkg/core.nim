import math
import strutils

type
  Tuple* = ref object of RootObj
    x*: float64
    y*: float64
    z*: float64
    w*: float64

  Point* = ref object of Tuple
  Vector* = ref object of Tuple

template genericops(t) =
  proc `<`*(a: t, b: Tuple): bool =
    a.x < b.x or a.y < b.y or a.z < b.z

  proc `==`*(a: t, b: Tuple): bool =
    a.x == b.x and a.y == b.y and a.z == b.z and a.w == b.w

  proc `+`*(t1: t, t2: Tuple): t =
    t(x: t1.x + t2.x, y: t1.y + t2.y, z: t1.z + t2.z, w: t1.w + t2.w)

  proc `-`*(t1: t, t2: Tuple): t =
    t(x: t1.x - t2.x, y: t1.y - t2.y, z: t1.z - t2.z, w: t1.w - t2.w)

  proc `!`*(t: t): t =
    t(x: -t.x, y: -t.y, z: -t.z, w: -t.w)

  proc `*`*(t1: t, scalar: float64): t =
    t(x: t1.x * scalar, y: t1.y * scalar, z: t1.z * scalar, w: t1.w * scalar)

  proc `/`*(t1: t, scalar: float64): t =
    t(x: t1.x / scalar, y: t1.y / scalar, z: t1.z / scalar, w: t1.w / scalar)

genericops(Tuple)
genericops(Vector)
genericops(Point)

template `$`*(a: Tuple): string =
  "($1, $2, $3, $4)" % [$a.x, $a.y, $a.z, $a.w]

proc tp*(x, y, z, w: int32): Tuple =
  Tuple(x: x.float64, y: y.float64, z: z.float64, w: w.float64)

proc tp*(x, y, z, w: float64): Tuple =
  Tuple(x: x, y: y, z: z, w: w)

proc point*(x, y, z: int32): Point =
  Point(x: x.float64, y: y.float64, z: z.float64, w: 1.0.float64)

proc point*(x, y, z: float64): Point =
  Point(x: x, y: y, z: z, w: 1.0.float64)

proc vector*(x, y, z: int32): Vector =
  Vector(x: x.float64, y: y.float64, z: z.float64, w: 0.0.float64)

proc vector*(x, y, z: float64): Vector =
  Vector(x: x, y: y, z: z, w: 0.0.float64)

proc magnitude*(v: Vector): float64 =
  sqrt(pow(v.x, 2) + pow(v.y, 2) + pow(v.z, 2) + pow(v.w, 2))

proc normalize*(v: Vector): Vector =
  var m = v.magnitude

  Vector(x: v.x / m, y: v.y / m, z: v.z / m, w: v.w / m)

proc dot*(v: Vector, v1: Vector): float64 =
  v.x * v1.x + v.y * v1.y + v.z * v1.z + v.w * v1.w

proc cross*(v: Vector, v1: Vector): Vector =
  vector(v.y * v1.z - v.z * v1.y, v.z * v1.x - v.x * v1.z, v.x * v1.y - v.y * v1.x)

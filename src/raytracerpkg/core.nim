import math

type
  Tuple* = tuple[x: float64, y: float64, z: float64, w: float64]

proc tp*(x, y, z, w: int32): Tuple =
  (x: x.float64, y: y.float64, z: z.float64, w: w.float64)

proc tp*(x, y, z, w: float64): Tuple =
  (x: x, y: y, z: z, w: w)

proc point*(x, y, z: int32): Tuple =
  (x: x.float64, y: y.float64, z: z.float64, w: 1.0.float64)

proc point*(x, y, z: float64): Tuple =
  (x: x, y: y, z: z, w: 1.0.float64)

proc vector*(x, y, z: int32): Tuple =
  (x: x.float64, y: y.float64, z: z.float64, w: 0.0.float64)

proc vector*(x, y, z: float64): Tuple =
  (x: x, y: y, z: z, w: 0.0.float64)

proc `+`*(t1, t2: Tuple): Tuple =
  (x: t1.x + t2.x, y: t1.y + t2.y, z: t1.z + t2.z, w: t1.w + t2.w)

proc `-`*(t1, t2: Tuple): Tuple =
  (x: t1.x - t2.x, y: t1.y - t2.y, z: t1.z - t2.z, w: t1.w - t2.w)

proc `!`*(t: Tuple): Tuple =
  (x: -t.x, y: -t.y, z: -t.z, w: -t.w)

proc `*`*(t1: Tuple, scalar: float64): Tuple =
  (x: t1.x * scalar, y: t1.y * scalar, z: t1.z * scalar, w: t1.w * scalar)

proc `/`*(t1: Tuple, scalar: float64): Tuple =
  (x: t1.x / scalar, y: t1.y / scalar, z: t1.z / scalar, w: t1.w / scalar)

proc magnitude*(t: Tuple): float64 =
  sqrt(pow(t.x, 2) + pow(t.y, 2) + pow(t.z, 2) + pow(t.w, 2))

import math

type
  Tuple* = ref object of RootObj
    x*: float64
    y*: float64
    z*: float64
    w*: float64

  Point* = ref object of Tuple
  Vector* = ref object of Tuple

  Color* = tuple[red, green, blue: float64]

const epsilon = 1e-5

template genericTupleOps(t) =
  proc `<`*(a: t, b: Tuple): bool =
    a.x < b.x or a.y < b.y or a.z < b.z

  proc `==`*(a: t, b: Tuple): bool =
    abs(a.x - b.x) < epsilon and abs(a.y - b.y) < epsilon and abs(a.z - b.z) < epsilon and abs(a.w - b.w) < epsilon

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

genericTupleOps(Tuple)
genericTupleOps(Vector)
genericTupleOps(Point)

template `$`*(a: Tuple): string =
  "($1, $2, $3, $4)" % [$a.x, $a.y, $a.z, $a.w]

# constructors
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

proc color*(red, green, blue: float64): Color =
  (red: red, green: green, blue: blue)

# functions
proc magnitude*(v: Vector): float64 =
  sqrt(pow(v.x, 2) + pow(v.y, 2) + pow(v.z, 2) + pow(v.w, 2))

proc normalize*(v: Vector): Vector =
  var m = v.magnitude

  Vector(x: v.x / m, y: v.y / m, z: v.z / m, w: v.w / m)

proc dot*(v: Vector, v1: Vector): float64 =
  v.x * v1.x + v.y * v1.y + v.z * v1.z + v.w * v1.w

proc cross*(v: Vector, v1: Vector): Vector =
  vector(v.y * v1.z - v.z * v1.y, v.z * v1.x - v.x * v1.z, v.x * v1.y - v.y * v1.x)

proc `-`*(t1, t2: Point): Vector =
  Vector(x: t1.x - t2.x, y: t1.y - t2.y, z: t1.z - t2.z, w: t1.w - t2.w)

proc `+`*(c1, c2: Color): Color =
  (red: c1.red + c2.red, green: c1.green + c2.green, blue: c1.blue + c2.blue)

proc `-`*(c1, c2: Color): Color =
  (red: c1.red - c2.red, green: c1.green - c2.green, blue: c1.blue - c2.blue)

proc `*`*(c1: Color, scalar: float64): Color =
  (red: c1.red * scalar, green: c1.green * scalar, blue: c1.blue * scalar)

proc `*`*(c1, c2: Color): Color =
  (red: c1.red * c2.red, green: c1.green * c2.green, blue: c1.blue * c2.blue)

proc `==`*(a, b: Color): bool =
  abs(a.red - b.red) < epsilon and abs(a.green - b.green) < epsilon and abs(a.blue - b.blue) < epsilon

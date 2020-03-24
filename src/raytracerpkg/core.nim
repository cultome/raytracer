type
  Point = tuple[x: float32, y: float32, z: float32, w: float32]
  Vector = tuple[x: float32, y: float32, z: float32, w: float32]

proc point*(x, y, z: float32): Point =
  (x: x, y: y, z: z, w: 1.0.float32)

proc vector*(x, y, z: float32): Vector =
  (x: x, y: y, z: z, w: 0.0.float32)

import raytracerpkg/tuples

type
  Matrix* = seq[seq[float64]]

proc matrix*(cols: varargs[seq[float64]]): Matrix =
  @cols

proc filledMatrix*(rowNum, colNum: int, defaultValue: float64): Matrix =
  var
    col: seq[float64]
    cols: seq[seq[float64]] = @[]

  for _ in 0..<rowNum:
    col = @[]

    for _ in 0..<colNum:
      col.add(defaultValue)

    cols.add(col)

  matrix(cols)

proc at*(m: Matrix, y, x: int): float64 =
  m[y][x]

proc `*`*(m: Matrix, t: Tuple): Tuple =
  if m.len != 4 or m[0].len != 4:
    raise newException(ValueError, "Matrix should have 4 rows")

  var acc = [0.0, 0.0, 0.0, 0.0]

  for idx in 0..3:
    acc[idx] = m[idx][0] * t.x + m[idx][1] * t.y + m[idx][2] * t.z + m[idx][3] * t.w

  tp(acc[0], acc[1], acc[2], acc[3])

proc `*`*(m1, m2: Matrix): Matrix =
  if m1.len != m2[0].len:
    raise newException(ValueError, "Matrices sizes are not compatible")

  result = filledMatrix(m2.len, m2[0].len, 0.0)
  var acc: float64

  for ridx, row in m2.pairs():
    for cidx, col in row.pairs():
      acc = 0.0

      for idx in 0..<row.len:
        acc += m1[ridx][idx] * m2[idx][cidx]

      result[ridx][cidx] = acc

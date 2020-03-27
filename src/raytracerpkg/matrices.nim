import math
import sequtils
import strutils

import raytracerpkg/tuples

type
  Matrix* = seq[seq[float64]]

const epsilon = 1e-5

proc `==`*(a, b: Matrix): bool =
  if a.len != b.len or a[0].len != b[0].len:
    return false

  for y in 0..<a.len:
    for x in 0..<a[0].len:
      if abs(abs(a[y][x]) - abs(b[y][x])) > epsilon:
        return false

  return true

proc matrix*(cols: varargs[seq[int]]): Matrix =
  @cols.map(proc (row: seq[int]): seq[float64] =
    row.mapIt( float64(it) )
  )

proc matrix*(cols: varargs[seq[float64]]): Matrix =
  @cols

proc identity*(size: int): Matrix =
  var
    cols: seq[seq[float64]]
    col: seq[float64]

  for y in 0..<size:
    col = @[]

    for x in 0..<size:
      if y == x:
        col.add(1.0)
      else:
        col.add(0.0)

    cols.add(col)

  matrix(cols)

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

proc submatrix*(m: Matrix, row, col: int): Matrix =
  var
    width = m.len - 1
    height = m[0].len - 1
    xOff = 0
    yOff = 0

  result = filledMatrix(width, height, 0.0)

  for y in 0..<height:
    xOff = 0
    if y == row:
      yOff += 1

    for x in 0..<width:
      if x == col:
        xOff += 1

      result[y][x] = m[y + yOff][x + xOff]

proc cofactor*(m: Matrix, row, col: int): float64

proc determinant*(m: Matrix): float64 =
  if m.len == 2 and m[0].len == 2:
    return m[0][0] * m[1][1] - m[1][0] * m[0][1]

  var cofact: float64

  for x, val in m[0].pairs:
    cofact = m.cofactor(0, x)
    result += val * cofact

proc minor*(m: Matrix, row, col: int): float64 =
  var s = m.submatrix(row, col)
  s.determinant

proc cofactor*(m: Matrix, row, col: int): float64 =
  result = m.minor(row, col)

  if (row + col) mod 2 != 0:
    result *= -1

proc transpose*(m: Matrix): Matrix =
  result = filledMatrix(m[0].len, m.len, 0.0)

  for ridx, row in m.pairs:
    for cidx, col in row.pairs:
      result[ridx][cidx] = m[cidx][ridx]

proc inverse*(m: Matrix): Matrix =
  let det = m.determinant

  if det == 0:
    raise newException(ValueError, "Matrix is not invertible")

  var
    height = m.len
    width = m[0].len
    cofact: float64

  result = filledMatrix(height, width, 0.0)

  for y in 0..<height:
    for x in 0..<width:
      cofact = m.cofactor(y, x)
      result[x][y] = cofact / det

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

proc print*(m: Matrix, decimals: int): string =
  var val: string

  result &= "\n"
  for y in 0..<m.len:
    result &= "| "

    for x in 0..<m[0].len:
      val = m[y][x].formatFloat(ffDecimal, decimals)
      result &= "$1 | " % [val.align(decimals + 3)]

    result &= "\n"

proc `$`*(m: Matrix): string =
  m.print(4)

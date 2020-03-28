import math

import raytracerpkg/matrices

type
  Axis* = enum
    axisX, axisY, axisZ

proc translation*(x, y, z: float64): Matrix =
  result = identity(4)
  result[0][3] = x
  result[1][3] = y
  result[2][3] = z

proc scaling*(x, y, z: float64):  Matrix =
  result = identity(4)
  result[0][0] = x
  result[1][1] = y
  result[2][2] = z

proc rotation*(axis: Axis, rads: float64): Matrix =
  result = identity(4)

  case axis
  of axisX:
    result[1][1] = cos(rads)
    result[1][2] = -sin(rads)
    result[2][1] = sin(rads)
    result[2][2] = cos(rads)
  of axisY:
    result[0][0] = cos(rads)
    result[0][2] = sin(rads)
    result[2][0] = -sin(rads)
    result[2][2] = cos(rads)
  of axisZ:
    result[0][0] = cos(rads)
    result[0][1] = -sin(rads)
    result[1][0] = sin(rads)
    result[1][1] = cos(rads)

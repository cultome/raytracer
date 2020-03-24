import unittest
import math

import raytracerpkg/core

suite "tuples features":
  test "tuples types":
    var
      p = point(1, 2, 3)
      v = vector(1, 2, 3)
      t = tp(1, 2, 3, 0)

    check($type(p) == "Point")
    check($type(v) == "Vector")
    check($type(t) == "Tuple")

  test "a tuple with w=1 is a point":
    var p = point(4.3, -4.2, 3.1)

    check(p.x - 4.3 < 0.001)
    check(p.y - -4.2 < 0.001)
    check(p.z - 3.1 < 0.001)
    check(p.w - 1.0 < 0.001)

  test "a tuple with w=0 is a vector":
    var v = vector(4.3, -4.2, 3.1)

    check(v.x - 4.3 < 0.001)
    check(v.y - -4.2 < 0.001)
    check(v.z - 3.1 < 0.001)
    check(v.w - 0.0 < 0.001)

  test "adding two tuples":
    var
      p = point(3.0, -2.0, 5.0)
      v = vector(-2.0, 3.0, 1.0)

    check(p + v == point(1.0, 1.0, 6.0))

  test "substracting two points":
    var
      p1 = point(3.0, 2.0, 1.0)
      p2 = point(5.0, 6.0, 7.0)

    check(p1 - p2 == vector(-2.0, -4.0, -6.0))

  test "substracting a vector from a point":
    var
      p = point(3, 2, 1)
      v = vector(5, 6, 7)

    check(p - v == point(-2, -4, -6))

  test "substracting two vectors":
    var
      v1 = vector(3, 2, 1)
      v2 = vector(5, 6, 7)

    check(v1 - v2 == vector(-2, -4, -6))

  test "substracting a vector from a zero vector":
    var
      v1 = vector(1, -2, 3)
      vz = vector(0, 0, 0)

    check(vz - v1 == vector(-1, 2, -3))

  test "negate tuple":
    var t: Tuple = tp(1, -2, 3, -4)

    check(!t == tp(-1, 2, -3, 4))

  test "multiply a tuple by a scalar":
    var t: Tuple = tp(1, -2, 3, -4)

    check(t * 3.5 == tp(3.5, -7, 10.5, -14))

  test "multiply a tuple by a fraction":
    var t: Tuple = tp(1, -2, 3, -4)

    check(t * 0.5 == tp(0.5, -1, 1.5, -2))

  test "divide a tuple by a scalar":
    var t: Tuple = tp(1, -2, 3, -4)

    check(t / 2 == tp(0.5, -1, 1.5, -2))

  test "computing the magnitude of vector (1, 0, 0)":
    var v = vector(1, 0, 0)

    check(v.magnitude == 1)

  test "computing the magnitude of vector (0, 1, 0)":
    var v = vector(0, 1, 0)

    check(v.magnitude == 1)

  test "computing the magnitude of vector (0, 0, 1)":
    var v = vector(0, 0, 1)

    check(v.magnitude == 1)

  test "computing the magnitude of vector (1, 2, 3)":
    var v = vector(1, 2, 3)

    check(v.magnitude == sqrt(14.0))

  test "computing the magnitude of vector (-1, -2, -3)":
    var v = vector(-1, -2, -3)

    check(v.magnitude == sqrt(14.0))

  test "normalizing vector (4, 0, 0) gives (1, 0, 0)":
    var v = vector(4, 0, 0)

    check(v.normalize == vector(1, 0, 0))

  test "normalizing vector (1, 2, 3) gives (1, 0, 0)":
    var v = vector(1, 2, 3)

    check(v.normalize == vector(1 / sqrt(14.0), 2 / sqrt(14.0), 3 / sqrt(14.0)))

  test "the magnitude of a normalized vector":
    var v = vector(1, 2, 3)

    check(v.normalize.magnitude == 1)

  test "the dot product of two tuples":
    var
      a = vector(1, 2, 3)
      b = vector(2, 3, 4)

    check (a.dot(b) == 20)

  test "the cross product of two vectors":
    var
      a = vector(1, 2, 3)
      b = vector(2, 3, 4)

    check (a.cross(b) == vector(-1, 2, -1))
    check (b.cross(a) == vector(1, -2, 1))

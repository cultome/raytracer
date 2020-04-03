import unittest
import math

import raytracerpkg/tuples

suite "tuples features":
  test "tuples types":
    var
      p = initPoint(1, 2, 3)
      v = initVector(1, 2, 3)
      t = initTuple(1, 2, 3, 0)

    check($type(p) == "Point")
    check($type(v) == "Vector")
    check($type(t) == "Tuple")

  test "a tuple with w=1 is a point":
    var p = initPoint(4.3, -4.2, 3.1)

    check(p.x - 4.3 < 0.001)
    check(p.y - -4.2 < 0.001)
    check(p.z - 3.1 < 0.001)
    check(p.w - 1.0 < 0.001)

  test "a tuple with w=0 is a vector":
    var v = initVector(4.3, -4.2, 3.1)

    check(v.x - 4.3 < 0.001)
    check(v.y - -4.2 < 0.001)
    check(v.z - 3.1 < 0.001)
    check(v.w - 0.0 < 0.001)

  test "adding two tuples":
    var
      p = initPoint(3.0, -2.0, 5.0)
      v = initVector(-2.0, 3.0, 1.0)

    check(p + v == initPoint(1, 1, 6))

  test "substracting two points":
    var
      p1 = initPoint(3.0, 2.0, 1.0)
      p2 = initPoint(5.0, 6.0, 7.0)

    check(p1 - p2 == initVector(-2.0, -4.0, -6.0))

  test "substracting a vector from a point":
    var
      p = initPoint(3, 2, 1)
      v = initVector(5, 6, 7)

    check(p - v == initPoint(-2, -4, -6))

  test "substracting two vectors":
    var
      v1 = initVector(3, 2, 1)
      v2 = initVector(5, 6, 7)

    check(v1 - v2 == initVector(-2, -4, -6))

  test "substracting a vector from a zero vector":
    var
      v1 = initVector(1, -2, 3)
      vz = initVector(0, 0, 0)

    check(vz - v1 == initVector(-1, 2, -3))

  test "negate tuple":
    var t: Tuple = initTuple(1, -2, 3, -4)

    check(!t == initTuple(-1, 2, -3, 4))

  test "multiply a tuple by a scalar":
    var t: Tuple = initTuple(1, -2, 3, -4)

    check(t * 3.5 == initTuple(3.5, -7, 10.5, -14))

  test "multiply a tuple by a fraction":
    var t: Tuple = initTuple(1, -2, 3, -4)

    check(t * 0.5 == initTuple(0.5, -1, 1.5, -2))

  test "divide a tuple by a scalar":
    var t: Tuple = initTuple(1, -2, 3, -4)

    check(t / 2 == initTuple(0.5, -1, 1.5, -2))

  test "computing the magnitude of vector (1, 0, 0)":
    var v = initVector(1, 0, 0)

    check(v.magnitude == 1)

  test "computing the magnitude of vector (0, 1, 0)":
    var v = initVector(0, 1, 0)

    check(v.magnitude == 1)

  test "computing the magnitude of vector (0, 0, 1)":
    var v = initVector(0, 0, 1)

    check(v.magnitude == 1)

  test "computing the magnitude of vector (1, 2, 3)":
    var v = initVector(1, 2, 3)

    check(v.magnitude == sqrt(14.0))

  test "computing the magnitude of vector (-1, -2, -3)":
    var v = initVector(-1, -2, -3)

    check(v.magnitude == sqrt(14.0))

  test "normalizing vector (4, 0, 0) gives (1, 0, 0)":
    var v = initVector(4, 0, 0)

    check(v.normalize == initVector(1, 0, 0))

  test "normalizing vector (1, 2, 3) gives (1, 0, 0)":
    var v = initVector(1, 2, 3)

    check(v.normalize == initVector(1 / sqrt(14.0), 2 / sqrt(14.0), 3 / sqrt(14.0)))

  test "the magnitude of a normalized vector":
    var v = initVector(1, 2, 3)

    check(v.normalize.magnitude == 1)

  test "the dot product of two tuples":
    var
      a = initVector(1, 2, 3)
      b = initVector(2, 3, 4)

    check (a.dot(b) == 20)

  test "the cross product of two vectors":
    var
      a = initVector(1, 2, 3)
      b = initVector(2, 3, 4)

    check (a.cross(b) == initVector(-1, 2, -1))
    check (b.cross(a) == initVector(1, -2, 1))

  test "colors are (red, green, blue) tuples":
    var c = initColor(-0.5, 0.4, 1.7)

    check(c.red == -0.5)
    check(c.green == 0.4)
    check(c.blue == 1.7)

  test "adding colors":
    var
      c1 = initColor(0.9, 0.6, 0.75)
      c2 = initColor(0.7, 0.1, 0.25)

    check(c1 + c2 == initColor(1.6, 0.7, 1.0))

  test "substracting colors":
    var
      c1 = initColor(0.9, 0.6, 0.75)
      c2 = initColor(0.7, 0.1, 0.25)

    check(c1 - c2 == initColor(0.2, 0.5, 0.5))

  test "multiplying a color by a scalar":
    var c = initColor(0.2, 0.3, 0.4)

    check(c * 2 == initColor(0.4, 0.6, 0.8))

  test "mutiply colors":
    var
      c1 = initColor(1, 0.2, 0.4)
      c2 = initColor(0.9, 1, 0.1)

    check(c1 * c2 == initColor(0.9, 0.2, 0.04))

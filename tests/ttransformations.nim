import unittest
import math

import raytracerpkg/transformations
import raytracerpkg/tuples
import raytracerpkg/matrices

suite "Matrix Transformations":
  test "Multiplying by a translation matrix":
    var
      t = translation(5, -3, 2)
      p = initPoint(-3, 4, 5)

    check(t * p == initPoint(2, 1, 7))

  test "Multiplying by the inverse of a translation matrix":
    var
      t = translation(5, -3, 2)
      inv = inverse(t)
      p = initPoint(-3, 4, 5)

    check(inv * p == initPoint(-8, 7, 3))

  test "Translation does not affect vectors":
    var
      t = translation(5, -3, 2)
      v = initVector(-3, 4, 5)

    check(t * v == v)

  test "A scaling matrix applied to a point":
    var
      t = scaling(2, 3, 4)
      p = initPoint(-4, 6, 8)

    check(t * p == initPoint(-8, 18, 32))

  test "A scaling matrix applied to a vector":
    var
      t = scaling(2, 3, 4)
      v = initVector(-4, 6, 8)

    check(t * v == initVector(-8, 18, 32))

  test "Multiplying by the inverse of a scaling matrix":
    var
      t = scaling(2, 3, 4)
      inv = inverse(t)
      v = initVector(-4, 6, 8)

    check(inv * v == initVector(-2, 2, 2))

  test "Reflection is scaling by a negative value":
    var
      t = scaling(-1, 1, 1)
      p = initPoint(2, 3, 4)

    check(t * p == initPoint(-2, 3, 4))

  test "Rotating a point around the x axis":
    var
      p = initPoint(0, 1, 0)
      half_quarter = rotation(axisX, PI / 4)
      full_quarter = rotation(axisX, PI / 2)

    check(half_quarter * p == initPoint(0, sqrt(2.0)/2, sqrt(2.0)/2))
    check(full_quarter * p == initPoint(0, 0, 1))

  test "The inverse of an x-rotation rotates in the opposite direction":
    var
      p = initPoint(0, 1, 0)
      half_quarter = rotation(axisX, PI / 4)
      inv = inverse(half_quarter)

    check(inv * p == initPoint(0, sqrt(2.0)/2, -sqrt(2.0)/2))

  test "Rotating a point around the y axis":
    var
      p = initPoint(0, 0, 1)
      half_quarter = rotation(axisY, PI / 4)
      full_quarter = rotation(axisY, PI / 2)

    check(half_quarter * p == initPoint(sqrt(2.0)/2, 0, sqrt(2.0)/2))
    check(full_quarter * p == initPoint(1, 0, 0))

  test "Rotating a point around the z axis":
    var
      p = initPoint(0, 1, 0)
      half_quarter = rotation(axisZ, PI / 4)
      full_quarter = rotation(axisZ, PI / 2)

    check(half_quarter * p == initPoint(-sqrt(2.0)/2, sqrt(2.0)/2, 0))
    check(full_quarter * p == initPoint(-1, 0, 0))

  test "A shearing transformation moves x in proportion to y":
    var
      t = shearing(1, 0, 0, 0, 0, 0)
      p = initPoint(2, 3, 4)

    check(t * p == initPoint(5, 3, 4))

  test "A shearing transformation moves x in proportion to z":
    var
      t = shearing(0, 1, 0, 0, 0, 0)
      p = initPoint(2, 3, 4)

    check(t * p == initPoint(6, 3, 4))

  test "A shearing transformation moves y in proportion to x":
    var
      t = shearing(0, 0, 1, 0, 0, 0)
      p = initPoint(2, 3, 4)

    check(t * p == initPoint(2, 5, 4))

  test "A shearing transformation moves y in proportion to z":
    var
      t = shearing(0, 0, 0, 1, 0, 0)
      p = initPoint(2, 3, 4)

    check(t * p == initPoint(2, 7, 4))

  test "A shearing transformation moves z in proportion to x":
    var
      t = shearing(0, 0, 0, 0, 1, 0)
      p = initPoint(2, 3, 4)

    check(t * p == initPoint(2, 3, 6))

  test "A shearing transformation moves z in proportion to y":
    var
      t = shearing(0, 0, 0, 0, 0, 1)
      p = initPoint(2, 3, 4)

    check(t * p == initPoint(2, 3, 7))

  test "Individual transformations are applied in sequence":
    var
      p = initPoint(1, 0, 1)
      t1 = rotation(axisX, PI / 2)
      t2 = scaling(5, 5, 5)
      t3 = translation(10, 5, 7)
      # apply rotation first
      p2 = t1 * p
      # then apply scaling
      p3 = t2 * p2
      # then apply translation
      p4 = t3 * p3

    check(p2 == initPoint(1, -1, 0))
    check(p3 == initPoint(5, -5, 0))
    check(p4 == initPoint(15, 0, 7))

  test "Chained transformations must be applied in reverse order":
    var
      p = initPoint(1, 0, 1)
      t1 = rotation(axisX, PI / 2)
      t2 = scaling(5, 5, 5)
      t3 = translation(10, 5, 7)
      tr = t3 * t2 * t1

    check(tr * p == initPoint(15, 0, 7))

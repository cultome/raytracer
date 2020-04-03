import unittest

import raytracerpkg/tuples
import raytracerpkg/transformations
import raytracerpkg/rays

suite "Rays":
  test "Creating and querying a ray":
    var
      origin = initPoint(1, 2, 3)
      direction = initVector(4, 5, 6)
      r = ray(origin, direction)

    check(r.origin == origin)
    check(r.direction == direction)

  test "Computing a point from a distance":
    var
      r = ray(initPoint(2, 3, 4), initVector(1, 0, 0))

    check(position(r, 0) == initPoint(2, 3, 4))
    check(position(r, 1) == initPoint(3, 3, 4))
    check(position(r, -1) == initPoint(1, 3, 4))
    check(position(r, 2.5) == initPoint(4.5, 3, 4))

  test "Translating a ray":
    var
      r = ray(initPoint(1, 2, 3), initVector(0, 1, 0))
      m = translation(3, 4, 5)
      r2 = r.transform(m)

    check(r2.origin == initPoint(4, 6, 8))
    check(r2.direction == initVector(0, 1, 0))

  test "Scaling a ray":
    var
      r = ray(initPoint(1, 2, 3), initVector(0, 1, 0))
      m = scaling(2, 3, 4)
      r2 = r.transform(m)

    check(r2.origin == initPoint(2, 6, 12))
    check(r2.direction == initVector(0, 3, 0))

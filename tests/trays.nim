import unittest

import raytracerpkg/tuples
import raytracerpkg/transformations
import raytracerpkg/rays
import raytracerpkg/materials
import raytracerpkg/world

suite "Rays":
  test "Creating and querying a ray":
    var
      origin = initPoint(1, 2, 3)
      direction = initVector(4, 5, 6)
      r = initRay(origin, direction)

    check(r.origin == origin)
    check(r.direction == direction)

  test "Computing a point from a distance":
    var
      r = initRay(initPoint(2, 3, 4), initVector(1, 0, 0))

    check(position(r, 0) == initPoint(2, 3, 4))
    check(position(r, 1) == initPoint(3, 3, 4))
    check(position(r, -1) == initPoint(1, 3, 4))
    check(position(r, 2.5) == initPoint(4.5, 3, 4))

  test "Translating a ray":
    var
      r = initRay(initPoint(1, 2, 3), initVector(0, 1, 0))
      m = translation(3, 4, 5)
      r2 = r.transform(m)

    check(r2.origin == initPoint(4, 6, 8))
    check(r2.direction == initVector(0, 1, 0))

  test "Scaling a ray":
    var
      r = initRay(initPoint(1, 2, 3), initVector(0, 1, 0))
      m = scaling(2, 3, 4)
      r2 = r.transform(m)

    check(r2.origin == initPoint(2, 6, 12))
    check(r2.direction == initVector(0, 3, 0))

  test "The color when a ray misses":
    var
      w = initWorld()
      r = initRay(initPoint(0, 0, -5), initVector(0, 1, 0))
      c = r.colorAt(w)

    check(c == initColor(0, 0, 0))

  test "The color when a ray hits":
    var
      w = initWorld()
      r = initRay(initPoint(0, 0, -5), initVector(0, 0, 1))
      c = r.colorAt(w)

    check(c == initColor(0.38066, 0.47583, 0.2855))

  test "The color with an intersection behind the ray":
    var
      w = initWorld()
      outer = w.objects[0]
      inner = w.objects[1]
      r = initRay(initPoint(0, 0, 0.75), initVector(0, 0, -1))

    outer.material.ambient = 1
    inner.material.ambient = 1

    check(r.colorAt(w) == inner.material.color)


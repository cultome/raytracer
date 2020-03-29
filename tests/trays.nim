import unittest

import raytracerpkg/tuples
import raytracerpkg/transformations
import raytracerpkg/rays

suite "Rays":
  test "Creating and querying a ray":
    var
      origin = point(1, 2, 3)
      direction = vector(4, 5, 6)
      r = ray(origin, direction)

    check(r.origin == origin)
    check(r.direction == direction)

  test "Computing a point from a distance":
    var
      r = ray(point(2, 3, 4), vector(1, 0, 0))

    check(position(r, 0) == point(2, 3, 4))
    check(position(r, 1) == point(3, 3, 4))
    check(position(r, -1) == point(1, 3, 4))
    check(position(r, 2.5) == point(4.5, 3, 4))

  #test "Translating a ray":
    #var
      #r = ray(point(1, 2, 3), vector(0, 1, 0))
      #m = translation(3, 4, 5)
      #r2 = r.transform(m)

    #check(r2.origin == point(4, 6, 8))
    #check(r2.direction == vector(0, 1, 0))

  #test "Scaling a ray":
    #var
      #r = ray(point(1, 2, 3), vector(0, 1, 0))
      #m = scaling(2, 3, 4)
      #r2 = r.transform(m)

    #check(r2.origin == point(2, 6, 12))
    #check(r2.direction == vector(0, 3, 0))

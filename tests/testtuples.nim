import unittest

import raytracerpkg/core

suite "tuples features":
  test "a tuple with w=1 is a point":
    var p = point(4.3, -4.2, 3.1)

    check(p.x - 4.3 < 0.001)
    check(p.y - -4.2 < 0.001)
    check(p.z - 3.1 < 0.001)
    check(p.w - 1.0 < 0.001)

    check($type(p) == "Point")

  test "a tuple with w=0 is a vector":
    var v = vector(4.3, -4.2, 3.1)

    check(v.x - 4.3 < 0.001)
    check(v.y - -4.2 < 0.001)
    check(v.z - 3.1 < 0.001)
    check(v.w - 0.0 < 0.001)

    check($type(v) == "Vector")

import unittest

import raytracerpkg/canvas

suite "canvas features":
  test "creating a canvas":
    var c = canvas(10, 20)

    check(c.width == 10)
    check(c.height == 20)

    # ... and every pixel is color(0, 0, 0)

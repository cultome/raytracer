import unittest

import raytracerpkg/canvas
import raytracerpkg/core

suite "canvas features":
  test "creating a canvas":
    var c = canvas(10, 20)

    check(c.width == 10)
    check(c.height == 20)

    # ... and every pixel is color(0, 0, 0)
  test "write pixels to canvas":
    var
      c = canvas(10, 20)
      r = color(1, 0, 0)

    c.writePixel(2, 3, r)

    check(c.pixelAt(2, 3) == r)

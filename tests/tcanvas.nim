import unittest
import strutils

import raytracerpkg/canvas
import raytracerpkg/tuples

suite "canvas features":
  test "creating a canvas":
    var c = initCanvas(10, 20)

    check(c.width == 10)
    check(c.height == 20)

  test "write pixels to canvas":
    var
      c = initCanvas(10, 20)
      r = initColor(1, 0, 0)

    c.writePixel(2, 3, r)

    check(c.pixelAt(2, 3) == r)

  test "construct the PPM header":
    var
      c = initCanvas(5, 3)
      ppm = c.toPpm
      lns = ppm.split("\n")

    check(lns[0] == "P3")
    check(lns[1] == "5 3")
    check(lns[2] == "255")

  test "constructing the ppm pixel data":
    var
      c = initCanvas(5, 3)
      c1 = initColor(1.5, 0, 0)
      c2 = initColor(0, 0.5, 0)
      c3 = initColor(-0.5, 0, 1)

    c.writePixel(0, 0, c1)
    c.writePixel(2, 1, c2)
    c.writePixel(4, 2, c3)

    var
      ppm = c.toPpm
      lns = ppm.split("\n")

    check(lns[3] == "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
    check(lns[4] == "0 0 0 0 0 0 0 128 0 0 0 0 0 0 0")
    check(lns[5] == "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255")

  test "spliting long lines in PPM files":
    var
      c1 = initColor(1, 0.8, 0.6)
      c = initCanvas(10, 2, c1)
      ppm = c.toPpm
      lns = ppm.split("\n")

    check(lns[3] == "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204")
    check(lns[4] == "153 255 204 153 255 204 153 255 204 153 255 204 153")
    check(lns[5] == "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204")
    check(lns[6] == "153 255 204 153 255 204 153 255 204 153 255 204 153")

  test "PPM files are terminated by a newline character":
    var
      c = initCanvas(5, 3)
      ppm = c.toPpm
      lns = ppm.split("\n")

    check(lns[6] == "")

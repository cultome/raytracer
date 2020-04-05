import unittest
import math

import raytracerpkg/camera
import raytracerpkg/tuples
import raytracerpkg/matrices
import raytracerpkg/transformations
import raytracerpkg/world
import raytracerpkg/canvas

const EPSILON = 1e-5

suite "Feature camera":
  test "Constructing a camera":
    var
      canvasWidth = 160
      canvasHeight = 120
      fieldOfView = PI/2
      c = initCamera(canvasWidth, canvasHeight, fieldOfView)

    check(c.canvasWidth == 160)
    check(c.canvasHeight == 120)
    check(c.fieldOfView == PI/2)
    check(c.transformation == identity(4))

  test "The pixel size for a horizontal canvas":
    var c = initCamera(200, 125, PI/2)

    check(abs(c.pixelSize-0.01) < EPSILON)

  test "The pixel size for a vertical canvas":
    var c = initCamera(125, 200, PI/2)

    check(abs(c.pixelSize-0.01) < EPSILON)

  test "Constructing a ray through the center of the canvas":
    var
      c = initCamera(201, 101, PI/2)
      r = c.rayForPixel(100, 50)

    check(r.origin == initPoint(0, 0, 0))
    check(r.direction == initVector(0, 0, -1))

  test "Constructing a ray through a corner of the canvas":
    var
      c = initCamera(201, 101, PI/2)
      r = c.rayForPixel(0, 0)

    check(r.origin == initPoint(0, 0, 0))
    check(r.direction == initVector(0.66519, 0.33259, -0.66851))

  test "Constructing a ray when the camera is transformed":
    var c = initCamera(201, 101, PI/2)

    c.transformation = rotation(axisY, PI/4) * translation(0, -2, 5)

    var r = c.rayForPixel(100, 50)

    check(r.origin == initPoint(0, 2, -5))
    check(r.direction == initVector(sqrt(2.0)/2, 0, -sqrt(2.0)/2))

  test "Rendering a world with a camera":
    var
      w = initWorld()
      c = initCamera(11, 11, PI/2)
      fromP = initPoint(0, 0, -5)
      to = initPoint(0, 0, 0)
      up = initVector(0, 1, 0)

    c.transformation = viewTransformation(fromP, to, up)

    var canvas = c.render(w)

    check(canvas.pixelAt(5, 5) == initColor(0.38066, 0.47583, 0.2855))

import math

import raytracerpkg/tuples
import raytracerpkg/matrices
import raytracerpkg/rays
import raytracerpkg/world
import raytracerpkg/canvas

type
  Camera* = ref object
    canvasWidth*: int
    canvasHeight*: int
    fieldOfView*: float64
    halfWidth*: float64
    halfHeight*: float64
    pixelSize*: float64
    transformation*: Matrix

proc initCamera*(canvasWidth, canvasHeight: int, fieldOfView: float64, transformation = identity(4)): Camera =
  var
    halfWidth, halfHeight, pixelSize: float64
    halfView = tan(fieldOfView / 2.0)
    aspect = canvasWidth / canvasHeight

  if aspect >= 1:
    halfWidth = halfView
    halfHeight = halfView / aspect
  else:
    halfWidth = halfView * aspect
    halfHeight = halfView

  pixelSize = (halfWidth * 2) / (canvasWidth.float64)

  Camera(
    canvasWidth: canvasWidth,
    canvasHeight: canvasHeight,
    fieldOfView: fieldOfView,
    transformation: transformation,
    halfWidth: halfWidth,
    halfHeight: halfHeight,
    pixelSize: pixelSize
  )

proc rayForPixel*(c: Camera, x, y: int): Ray =
  var
    xOffset = (x.float64 + 0.5) * c.pixelSize
    yOffset = (y.float64 + 0.5) * c.pixelSize

    xWorld = c.halfWidth - xOffset
    yWorld = c.halfHeight - yOffset

    pixel = c.transformation.inverse * initPoint(xWorld, yWorld, -1)
    origin = c.transformation.inverse * initPoint(0, 0, 0)
    direction = (pixel - origin).normalize

  initRay(origin, direction)

proc render*(c: Camera, w: World): Canvas =
  var
    canvas = initCanvas(c.canvasWidth, c.canvasHeight)
    ray: Ray
    color: Color

  for y in 0..<c.canvasWidth:
    for x in 0..<c.canvasHeight:
      ray = c.rayForPixel(x, y)
      color = ray.colorAt(w)
      canvas.writePixel(x, y, color)

  canvas

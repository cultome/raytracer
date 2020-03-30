import options
import strutils

import raytracerpkg/spheres
import raytracerpkg/intersections
import raytracerpkg/tuples
import raytracerpkg/canvas
import raytracerpkg/rays

var
  raySrcPos = point(0, 0, -5)
  wallZ = 10.0
  wallSize = 7.0
  canvasSize = 100
  pixelSize = wallSize / float64(canvasSize)
  half = wallSize / 2

  c = canvas(canvasSize, canvasSize)
  color = color(1, 1, 1)
  s = sphere()

  r: Ray
  position: Point
  h: Option[Intersection]
  ixs: seq[Intersection]
  worldY: float64
  worldX: float64

for y in 0..<canvasSize:
  worldY = half - (pixelSize * float64(y))

  for x in 0..<canvasSize:
    worldX = -half + (pixelSize * float64(x))
    position = point(worldX, worldY, wallZ)

    r = ray(raySrcPos, cast[Vector](position - raySrcPos).normalize)
    ixs = r.intersect(s)
    h = ixs.hit
    if h.isSome:
      c.writePixel(x, y, color)

writeFile("exercices/rays.ppm", c.to_ppm)

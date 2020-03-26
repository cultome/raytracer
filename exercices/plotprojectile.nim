import raytracerpkg/tuples
import raytracerpkg/canvas
import sequtils
import math

from projectiles import launch

when isMainModule:
  let
    (xs, ys) = launch(point(0, 1, 0), vector(1, 1.8, 0).normalize * 11.25, vector(0, -0.1, 0), vector(-0.01, 0, 0))
    coords = xs.zip(ys).mapIt( (int(round(it[0])), int(round(it[1]))) )
    height = int(round(max(ys) + 0.5))
    width = int(round(max(xs) + 0.5))
    cv = canvas(width+10, height+10)
    color = color(1, 1, 1)

  for (x, y) in coords:
    cv.writePixel(x, height - y, color)

  writeFile("exercices/plotprojectile.ppm", cv.to_ppm)

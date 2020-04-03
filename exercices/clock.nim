import math

import raytracerpkg/tuples
import raytracerpkg/matrices
import raytracerpkg/canvas
import raytracerpkg/transformations

var
  size = 100
  cv = initCanvas(size, size)
  rotate: Matrix
  marker: Tuple

  translate = translation(0.0, ((size / 2) * -1) + 1, 0.0)

  color = initColor(1.0, 0.0, 0.0)

for hour in 0..11:
  rotate = rotation(axisZ, float64(hour) * (PI / 6))
  marker = rotate * translate * initPoint(0, 0, 0)
  cv.writePixel(int(size / 2 + marker.x), int(size / 2 + marker.y), color)

writeFile("exercices/clock.ppm", cv.to_ppm)

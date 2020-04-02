import raytracerpkg/spheres
import raytracerpkg/tuples
import raytracerpkg/canvas
import raytracerpkg/rays

var
  wallZ = 10.0
  wallSize = 7
  halfWall = wallSize.float64 / 2.0
  canvasSize = 100
  pixelSize = wallSize / canvasSize
  camera = point(0, 0, -5)
  shape = sphere()
  canva = canvas(canvasSize, canvasSize)
  color = color(1, 1, 1)
  source: Ray
  sourceVector: Vector

for y in 0..<canvasSize:
  for x in 0..<canvasSize:
    sourceVector = point(-halfWall + x.float64 * pixelSize, halfWall - y.float64 * pixelSize, wallZ) - camera
    source = ray(camera, sourceVector)

    if source.intersect(shape).len > 0:
      canva.writePixel(y, x, color)

  canva.save("exercices/rays.ppm")

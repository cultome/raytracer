import options

import raytracerpkg/spheres
import raytracerpkg/tuples
import raytracerpkg/canvas
import raytracerpkg/rays
import raytracerpkg/materials
import raytracerpkg/lights
import raytracerpkg/intersections

var
  wallZ = 10.0
  wallSize = 7
  halfWall = wallSize.float64 / 2.0
  canvasSize = 100
  pixelSize = wallSize / canvasSize
  camera = initPoint(0, 0, -5)
  material = initMaterial()
  shape = initSphere(material)
  canva = initCanvas(canvasSize, canvasSize)
  light = initLightPoint(initPoint(-10, 10, -10), initColor(1, 1, 1))
  color: Color
  shapePoint: Point
  source: Ray
  sourceVector, pointNormal, eye: Vector
  optHit: Option[Intersection]
  hit: Intersection

shape.material.color = initColor(0.7, 0.2, 0.3)

for y in 0..<canvasSize:
  for x in 0..<canvasSize:
    sourceVector = (initPoint(-halfWall + x.float64 * pixelSize, halfWall - y.float64 * pixelSize, wallZ) - camera).normalize
    source = ray(camera, sourceVector)
    optHit = source.intersect(shape).hit

    if optHit.isSome:
      hit = optHit.get()
      shapePoint = source.position(hit.t)
      pointNormal = hit.obj.normalAt(shapePoint)
      eye = !(source.direction)

      color = hit.obj.material.lighting(light, shapePoint, eye, pointNormal)

      canva.writePixel(y, x, color)

  canva.save("exercices/rays3d.ppm")

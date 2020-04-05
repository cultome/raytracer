import math

import raytracerpkg/canvas
import raytracerpkg/tuples
import raytracerpkg/matrices
import raytracerpkg/spheres
import raytracerpkg/transformations
import raytracerpkg/materials
import raytracerpkg/lights
import raytracerpkg/world
import raytracerpkg/camera

var
  wallMaterial = initMaterial(color = initColor(1.0, 0.9, 0.9), specular = 0)
  wallScaling = scaling(10.0, 0.01, 10.0)
  leftWallTrans = translation(0 ,0, 5) * rotation(axisY, -PI/4) * rotation(axisX, PI/2) * wallScaling
  rightWallTrans = translation(0 ,0, 5) * rotation(axisY, PI/4) * rotation(axisX, PI/2) * wallScaling

  floor = initSphere(wallScaling, wallMaterial)
  leftWall = initSphere(leftWallTrans, wallMaterial)
  rightWall = initSphere(rightWallTrans, wallMaterial)

  middle = initSphere(translation(-0.5, 1.0, 0.5), initMaterial(color = initColor(0.1, 1.0, 0.5), diffuse = 0.7, specular = 0.3))

  light = initLightPoint(initPoint(-10, 10, -10), initColor(1, 1, 1))
  scene = initWorld(objects = @[floor, leftWall, rightWall, middle], light = light)

  cam = initCamera(500, 250, PI/3, viewTransformation(initPoint(0.0, 1.5, -5.0), initPoint(0, 1, 0), initVector(0, 1, 0)))
  # cam = initCamera(100, 50, PI/3, viewTransformation(initPoint(0.0, 1.5, -5.0), initPoint(0, 1, 0), initVector(0, 1, 0)))

  image = cam.render(scene)

image.save("exercices/camera.ppm")

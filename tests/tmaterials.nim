import unittest
import math

import raytracerpkg/lights
import raytracerpkg/materials
import raytracerpkg/tuples

suite "Materials":
  test "The default material":
    var m = initMaterial()

    check(m.color == initColor(1, 1, 1))
    check(m.ambient == 0.1)
    check(m.diffuse == 0.9)
    check(m.specular == 0.9)
    check(m.shininess == 200.0)

  test "Lighting with the eye between the light and the surface":
    var
      m = initMaterial()
      point = initPoint(0, 0, 0)
      eyev = initVector(0, 0, -1)
      normalv = initVector(0, 0, -1)
      light = initLightPoint(initPoint(0, 0, -10), initColor(1, 1, 1))
      r = m.lighting(light, point, eyev, normalv)

    check(r == initColor(1.9, 1.9, 1.9))

  #test "Lighting with the eye between light and surface, eye offset 45°":
    #var
      #m = initMaterial()
      #point = initPoint(0, 0, 0)
      #eyev = initVector(0, sqrt(2.0)/2, -sqrt(2.0)/2)
      #normalv = initVector(0, 0, -1)
      #light = initLightPoint(initPoint(0, 0, -10), initColor(1, 1, 1))
      #r = m.lighting(light, point, eyev, normalv)

    #check(r == initColor(1.0, 1.0, 1.0))

  #test "Lighting with eye opposite surface, light offset 45°":
    #var
      #m = initMaterial()
      #point = initPoint(0, 0, 0)
      #eyev = initVector(0, 0, -1)
      #normalv = initVector(0, 0, -1)
      #light = initLightPoint(initPoint(0, 10, -10), initColor(1, 1, 1))
      #r = m.lighting(light, point, eyev, normalv)

    #check(r == initColor(0.7364, 0.7364, 0.7364))

  #test "Lighting with eye in the path of the reflection vector":
    #var
      #m = initMaterial()
      #point = initPoint(0, 0, 0)
      #eyev = initVector(0, -sqrt(2.0)/2, -sqrt(2.0)/2)
      #normalv = initVector(0, 0, -1)
      #light = initLightPoint(initPoint(0, 10, -10), initColor(1, 1, 1))
      #r = m.lighting(light, point, eyev, normalv)

    #check(r == initColor(1.6364, 1.6364, 1.6364))

  #test "Lighting with the light behind the surface":
    #var
      #m = initMaterial()
      #point = initPoint(0, 0, 0)
      #eyev = initVector(0, 0, -1)
      #normalv = initVector(0, 0, -1)
      #light = initLightPoint(initPoint(0, 0, 10), initColor(1, 1, 1))
      #r = m.lighting(light, point, eyev, normalv)

    #check(r == initColor(0.1, 0.1, 0.1))

#test "Reflectivity for the default material":
  #var
    #m ← material()
#Then m.reflective = 0.0

#test "Transparency and Refractive Index for the default material":
  #var
    #m ← material()
#Then m.transparency = 0.0
#And m.refractive_index = 1.0

#test "Lighting with the surface in shadow":
  #var
    #eyev ← initVector(0, 0, -1)
#And normalv ← initVector(0, 0, -1)
#And light ← initLightPoint(initPoint(0, 0, -10), initColor(1, 1, 1))
#And in_shadow ← true
#When r ← m.lighting(light, point, eyev, normalv, in_shadow)
#Then r = initColor(0.1, 0.1, 0.1)

#test "Lighting with a pattern applied":
  #var
    #m.pattern ← stripe_pattern(initColor(1, 1, 1), initColor(0, 0, 0))
#And m.ambient ← 1
#And m.diffuse ← 0
#And m.specular ← 0
#And eyev ← initVector(0, 0, -1)
#And normalv ← initVector(0, 0, -1)
#And light ← initLightPoint(initPoint(0, 0, -10), initColor(1, 1, 1))
#When c1 ← m.lighting(light, initPoint(0.9, 0, 0), eyev, normalv, false)
#And c2 ← m.lighting(light, initPoint(1.1, 0, 0), eyev, normalv, false)
#Then c1 = initColor(1, 1, 1)
#And c2 = initColor(0, 0, 0)

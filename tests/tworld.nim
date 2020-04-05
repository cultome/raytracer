import unittest

import raytracerpkg/tuples
import raytracerpkg/spheres
import raytracerpkg/materials
import raytracerpkg/world
import raytracerpkg/lights
import raytracerpkg/transformations

suite "Feature World":
  test "Creating a world":
    var w = emptyWorld()

    check(w.objects.len == 0)
    check(w.light == nil)

  test "The default world":
    var
      light = initLightPoint(initPoint(-10, 10, -10), initColor(1, 1, 1))
      m1 = initMaterial()
      s1 = initSphere(m1)
      t1 = scaling(0.5, 0.5, 0.5)
      s2 = initSphere(t1)
      w = initWorld(@[s1, s2], light)

    m1.color = (0.8, 1.0, 0.6)
    m1.diffuse = 0.7
    m1.specular = 0.2

    check(w.light == light)
    check(s1 in w.objects)
    check(s2 in w.objects)

  #test "Intersect a world with a ray":
    #var
      #w = default_world()
      #r = ray(point(0, 0, -5), vector(0, 0, 1))
      #xs = intersect_world(w, r)

    #check(xs.count == 4)
    #check(xs[0].t == 4)
    #check(xs[1].t == 4.5)
    #check(xs[2].t == 5.5)
    #check(xs[3].t == 6)

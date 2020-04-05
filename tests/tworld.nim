import unittest

import raytracerpkg/tuples
import raytracerpkg/spheres
import raytracerpkg/materials
import raytracerpkg/rays
import raytracerpkg/world
import raytracerpkg/lights
import raytracerpkg/transformations
import raytracerpkg/intersections

suite "Feature World":
  test "Creating a world":
    var w = emptyWorld()

    check(w.objects.len == 0)
    check(w.light == nil)

  test "The default world":
    var
      light = initLightPoint(initPoint(-10, 10, -10), initColor(1, 1, 1))
      s1 = initSphere(material = initMaterial(color = (0.8, 1.0, 0.6), diffuse = 0.7, specular = 0.2))
      s2 = initSphere(scaling(0.5, 0.5, 0.5))
      w = initWorld()

    check(w.light == light)
    check(s1 in w.objects)
    check(s2 in w.objects)

  test "Intersect a world with a ray":
    var
      w = initWorld()
      r = initRay(initPoint(0, 0, -5), initVector(0, 0, 1))
      xs = r.intersect(w)

    check(xs.len == 4)
    check(xs[0].t == 4)
    check(xs[1].t == 4.5)
    check(xs[2].t == 5.5)
    check(xs[3].t == 6)

  test "Shading an intersection":
    var
      w = initWorld()
      r = initRay(initPoint(0, 0, -5), initVector(0, 0, 1))
      shape = w.objects[0]
      i = initIntersection(4, shape)
      comps = r.prepareComputation(i)
      c = w.shadeHit(comps)

    check(c == initColor(0.38066, 0.47583, 0.2855))

  test "Shading an intersection from the inside":
    var
      w = initWorld(light = initLightPoint(initPoint(0, 0.25, 0), initColor(1, 1, 1)))
      r = initRay(initPoint(0, 0, 0), initVector(0, 0, 1))
      shape = w.objects[1]
      i = initIntersection(0.5, shape)
      comps = r.prepareComputation(i)
      c = w.shadeHit(comps)

    check(c == initColor(0.90498, 0.90498, 0.90498))

  #test "There is no shadow when nothing is collinear with point and light":
  #Given w ← initWorld()
    #And p ← initPoint(0, 10, 0)
   #Then is_shadowed(w, p) is false

  #test "The shadow when an object is between the point and the light":
  #Given w ← initWorld()
    #And p ← initPoint(10, -10, 10)
   #Then is_shadowed(w, p) is true

  #test "There is no shadow when an object is behind the light":
  #Given w ← initWorld()
    #And p ← initPoint(-20, 20, -20)
   #Then is_shadowed(w, p) is false

  #test "There is no shadow when an object is behind the point":
  #Given w ← initWorld()
    #And p ← initPoint(-2, 2, -2)
   #Then is_shadowed(w, p) is false

  #test "shade_hit() is given an intersection in shadow":
  #Given w ← world()
    #And w.light ← point_light(initPoint(0, 0, -10), initColor(1, 1, 1))
    #And s1 ← sphere()
    #And s1 is added to w
    #And s2 ← sphere() with:
      #| transform | translation(0, 0, 10) |
    #And s2 is added to w
    #And r ← initRay(initPoint(0, 0, 5), initVector(0, 0, 1))
    #And i ← initIntersection(4, s2)
  #When comps ← r.prepareComputation(i)
    #And c ← w.shadeHit(comps)
  #Then c = initColor(0.1, 0.1, 0.1)

  #test "The reflected color for a nonreflective material":
  #Given w ← initWorld()
    #And r ← initRay(initPoint(0, 0, 0), initVector(0, 0, 1))
    #And shape ← the second object in w
    #And shape.material.ambient ← 1
    #And i ← initIntersection(1, shape)
  #When comps ← r.prepareComputation(i)
    #And color ← reflected_color(w, comps)
  #Then color = initColor(0, 0, 0)

  #test "The reflected color for a reflective material":
  #Given w ← initWorld()
    #And shape ← plane() with:
      #| material.reflective | 0.5                   |
      #| transform           | translation(0, -1, 0) |
    #And shape is added to w
    #And r ← initRay(initPoint(0, 0, -3), initVector(0, -√2/2, √2/2))
    #And i ← initIntersection(√2, shape)
  #When comps ← r.prepareComputation(i)
    #And color ← reflected_color(w, comps)
  #Then color = initColor(0.19032, 0.2379, 0.14274)

  #test "shade_hit() with a reflective material":
  #Given w ← initWorld()
    #And shape ← plane() with:
      #| material.reflective | 0.5                   |
      #| transform           | translation(0, -1, 0) |
    #And shape is added to w
    #And r ← initRay(initPoint(0, 0, -3), initVector(0, -√2/2, √2/2))
    #And i ← initIntersection(√2, shape)
  #When comps ← r.prepareComputation(i)
    #And color ← w.shadeHit(comps)
  #Then color = initColor(0.87677, 0.92436, 0.82918)

  #test "color_at() with mutually reflective surfaces":
  #Given w ← world()
    #And w.light ← point_light(initPoint(0, 0, 0), initColor(1, 1, 1))
    #And lower ← plane() with:
      #| material.reflective | 1                     |
      #| transform           | translation(0, -1, 0) |
    #And lower is added to w
    #And upper ← plane() with:
      #| material.reflective | 1                    |
      #| transform           | translation(0, 1, 0) |
    #And upper is added to w
    #And r ← initRay(initPoint(0, 0, 0), initVector(0, 1, 0))
  #Then r.colorAt(w) should terminate successfully

  #test "The reflected color at the maximum recursive depth":
  #Given w ← initWorld()
    #And shape ← plane() with:
      #| material.reflective | 0.5                   |
      #| transform           | translation(0, -1, 0) |
    #And shape is added to w
    #And r ← initRay(initPoint(0, 0, -3), initVector(0, -√2/2, √2/2))
    #And i ← initIntersection(√2, shape)
  #When comps ← r.prepareComputation(i)
    #And color ← reflected_color(w, comps, 0)
  #Then color = initColor(0, 0, 0)

  #test "The refracted color with an opaque surface":
  #Given w ← initWorld()
    #And shape ← the first object in w
    #And r ← initRay(initPoint(0, 0, -5), initVector(0, 0, 1))
    #And xs ← intersections(4:shape, 6:shape)
  #When comps ← prepare_computations(xs[0], r, xs)
    #And c ← refracted_color(w, comps, 5)
  #Then c = initColor(0, 0, 0)

  #test "The refracted color at the maximum recursive depth":
  #Given w ← initWorld()
    #And shape ← the first object in w
    #And shape has:
      #| material.transparency     | 1.0 |
      #| material.refractive_index | 1.5 |
    #And r ← initRay(initPoint(0, 0, -5), initVector(0, 0, 1))
    #And xs ← intersections(4:shape, 6:shape)
  #When comps ← prepare_computations(xs[0], r, xs)
    #And c ← refracted_color(w, comps, 0)
  #Then c = initColor(0, 0, 0)

  #test "The refracted color under total internal reflection":
  #Given w ← initWorld()
    #And shape ← the first object in w
    #And shape has:
      #| material.transparency     | 1.0 |
      #| material.refractive_index | 1.5 |
    #And r ← initRay(initPoint(0, 0, √2/2), initVector(0, 1, 0))
    #And xs ← intersections(-√2/2:shape, √2/2:shape)
  ## NOTE: this time you're inside the sphere, so you need
  ## to look at the second intersection, xs[1], not xs[0]
  #When comps ← prepare_computations(xs[1], r, xs)
    #And c ← refracted_color(w, comps, 5)
  #Then c = initColor(0, 0, 0)

  #test "The refracted color with a refracted ray":
  #Given w ← initWorld()
    #And A ← the first object in w
    #And A has:
      #| material.ambient | 1.0            |
      #| material.pattern | test_pattern() |
    #And B ← the second object in w
    #And B has:
      #| material.transparency     | 1.0 |
      #| material.refractive_index | 1.5 |
    #And r ← initRay(initPoint(0, 0, 0.1), initVector(0, 1, 0))
    #And xs ← intersections(-0.9899:A, -0.4899:B, 0.4899:B, 0.9899:A)
  #When comps ← prepare_computations(xs[2], r, xs)
    #And c ← refracted_color(w, comps, 5)
  #Then c = initColor(0, 0.99888, 0.04725)

  #test "shade_hit() with a transparent material":
  #Given w ← initWorld()
    #And floor ← plane() with:
      #| transform                 | translation(0, -1, 0) |
      #| material.transparency     | 0.5                   |
      #| material.refractive_index | 1.5                   |
    #And floor is added to w
    #And ball ← sphere() with:
      #| material.color     | (1, 0, 0)                  |
      #| material.ambient   | 0.5                        |
      #| transform          | translation(0, -3.5, -0.5) |
    #And ball is added to w
    #And r ← initRay(initPoint(0, 0, -3), initVector(0, -√2/2, √2/2))
    #And xs ← intersections(√2:floor)
  #When comps ← prepare_computations(xs[0], r, xs)
    #And color ← w.shadeHit(comps, 5)
  #Then color = initColor(0.93642, 0.68642, 0.68642)

  #test "shade_hit() with a reflective, transparent material":
  #Given w ← initWorld()
    #And r ← initRay(initPoint(0, 0, -3), initVector(0, -√2/2, √2/2))
    #And floor ← plane() with:
      #| transform                 | translation(0, -1, 0) |
      #| material.reflective       | 0.5                   |
      #| material.transparency     | 0.5                   |
      #| material.refractive_index | 1.5                   |
    #And floor is added to w
    #And ball ← sphere() with:
      #| material.color     | (1, 0, 0)                  |
      #| material.ambient   | 0.5                        |
      #| transform          | translation(0, -3.5, -0.5) |
    #And ball is added to w
    #And xs ← intersections(√2:floor)
  #When comps ← prepare_computations(xs[0], r, xs)
    #And color ← w.shadeHit(comps, 5)
  #Then color = initColor(0.93391, 0.69643, 0.69243)

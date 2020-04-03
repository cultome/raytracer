import unittest
import math

import raytracerpkg/rays
import raytracerpkg/tuples
import raytracerpkg/matrices
import raytracerpkg/transformations
import raytracerpkg/spheres

suite "Spheres":
  test "A ray intersects a sphere at two points":
    var
      r = ray(point(0, 0, -5), vector(0, 0, 1))
      s = sphere()
      xs = r.intersect(s)

    check(xs.len == 2)
    check(xs[0].t == 4.0)
    check(xs[1].t == 6.0)

  test "A ray intersects a sphere at a tangent":
    var
      r = ray(point(0, 1, -5), vector(0, 0, 1))
      s = sphere()
      xs = r.intersect(s)

    check(xs.len == 2)
    check(xs[0].t == 5.0)
    check(xs[1].t == 5.0)

  test "A ray misses a sphere":
    var
      r = ray(point(0, 2, -5), vector(0, 0, 1))
      s = sphere()
      xs = r.intersect(s)

    check(xs.len == 0)

  test "A ray originates inside a sphere":
    var
      r = ray(point(0, 0, 0), vector(0, 0, 1))
      s = sphere()
      xs = r.intersect(s)

    check(xs.len == 2)
    check(xs[0].t == -1.0)
    check(xs[1].t == 1.0)

  test "A sphere is behind a ray":
    var
      r = ray(point(0, 0, 5), vector(0, 0, 1))
      s = sphere()
      xs = r.intersect(s)

    check(xs.len == 2)
    check(xs[0].t == -6.0)
    check(xs[1].t == -4.0)

  test "Intersect sets the object on the intersection":
    var
      r = ray(point(0, 0, -5), vector(0, 0, 1))
      s = sphere()
      xs = r.intersect(s)

    check(xs.len == 2)
    check(xs[0].obj == s)
    check(xs[1].obj == s)

  test "A sphere's default transformation":
    var s = sphere()

    check(s.transformation == identity(4))

  test "Changing a sphere's transformation":
    var
      s = sphere()
      t = translation(2, 3, 4)

    s.transformation = t
    check(s.transformation == t)

  test "Intersecting a scaled sphere with a ray":
    var
      r = ray(point(0, 0, -5), vector(0, 0, 1))
      s = sphere()

    s.transformation = scaling(2, 2, 2)

    var xs = r.intersect(s)

    check(xs.len == 2)
    check(xs[0].t == 3)
    check(xs[1].t == 7)

  test "Intersecting a translated sphere with a ray":
    var
      r = ray(point(0, 0, -5), vector(0, 0, 1))
      s = sphere()

    s.transformation = translation(5, 0, 0)

    check(r.intersect(s).len == 0)

  test "The normal on a sphere at a point on the x axis":
    var
      s = sphere()
      n = s.normalAt(point(1, 0, 0))

    check(n == vector(1, 0, 0))

  test "The normal on a sphere at a point on the y axis":
    var
      s = sphere()
      n = s.normalAt(point(0, 1, 0))

    check(n == vector(0, 1, 0))

  test "The normal on a sphere at a point on the z axis":
    var
      s = sphere()
      n = s.normalAt(point(0, 0, 1))

    check(n == vector(0, 0, 1))

  test "The normal on a sphere at a nonaxial point":
    var
      s = sphere()
      n = s.normalAt(point(sqrt(3.0)/3, sqrt(3.0)/3, sqrt(3.0)/3))

    check(n == vector(sqrt(3.0)/3, sqrt(3.0)/3, sqrt(3.0)/3))

  test "The normal is a normalized vector":
    var
      s = sphere()
      n = s.normalAt(point(sqrt(3.0)/3, sqrt(3.0)/3, sqrt(3.0)/3))

    check(n == normalize(n))

  #test "Computing the normal on a translated sphere":
    #var s = sphere()

    #s.transformation = translation(0, 1, 0)

    #var n = s.normalAt(point(0, 1.70711, -0.70711))

    #check(n == vector(0, 0.70711, -0.70711))

  #test "Computing the normal on a transformed sphere":
    #var
      #s = sphere()
      #m = scaling(1, 0.5, 1) * rotation(axisZ, PI/5)

    #s.transformation = m

    #var n = s.normalAt(point(0, sqrt(2.0)/2, -sqrt(2.0)/2))

    #check(n == vector(0, 0.97014, -0.24254))

  #test "A sphere has a default material":
  #var
  #s ← sphere()
  #When m ← s.material
  #Then m = material()

  #test "A sphere may be assigned a material":
  # var
  # s ← sphere()
    #And m ← material()
    #And m.ambient ← 1
  #When s.material ← m
  #Then s.material = m

  #test "A helper for producing a sphere with a glassy material":
  # var
  # s ← glass_sphere()
  #Then s.transformation = identity(4)
    #And s.material.transparency = 1.0
    #And s.material.refractive_index = 1.5

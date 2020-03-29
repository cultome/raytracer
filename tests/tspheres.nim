import unittest

import raytracerpkg/rays
import raytracerpkg/tuples
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

  #test "A sphere's default transformation":
  # var
  # s ← sphere()
  #Then s.transform = identity_matrix

  #test "Changing a sphere's transformation":
  # var
  # s ← sphere()
    #And t ← translation(2, 3, 4)
  #When set_transform(t)
  #Then s.transform = t

  #test "Intersecting a scaled sphere with a ray":
  # var
  # r ← ray(point(0, 0, -5), vector(0, 0, 1))
    #And s ← sphere()
  #When set_transform(scaling(2, 2, 2))
    #And xs ← s.intersect(r)
  #Then xs.len = 2
    #And xs[0].t = 3
    #And xs[1].t = 7

  #test "Intersecting a translated sphere with a ray":
  # var
  # r ← ray(point(0, 0, -5), vector(0, 0, 1))
    #And s ← sphere()
  #When set_transform(translation(5, 0, 0))
    #And xs ← s.intersect(r)
  #Then xs.len = 0

  #test "The normal on a sphere at a point on the x axis":
  # var
  # s ← sphere()
  #When n ← normal_at(point(1, 0, 0))
  #Then n = vector(1, 0, 0)

  #test "The normal on a sphere at a point on the y axis":
  # var
  # s ← sphere()
  #When n ← normal_at(point(0, 1, 0))
  #Then n = vector(0, 1, 0)

  #test "The normal on a sphere at a point on the z axis":
  # var
  # s ← sphere()
  #When n ← normal_at(point(0, 0, 1))
  #Then n = vector(0, 0, 1)

  #test "The normal on a sphere at a nonaxial point":
  # var
  # s ← sphere()
  #When n ← normal_at(point(√3/3, √3/3, √3/3))
  #Then n = vector(√3/3, √3/3, √3/3)

  #test "The normal is a normalized vector":
  # var
  # s ← sphere()
  #When n ← normal_at(point(√3/3, √3/3, √3/3))
  #Then n = normalize(n)

  #test "Computing the normal on a translated sphere":
  # var
  # s ← sphere()
    #And set_transform(translation(0, 1, 0))
  #When n ← normal_at(point(0, 1.70711, -0.70711))
  #Then n = vector(0, 0.70711, -0.70711)

  #test "Computing the normal on a transformed sphere":
  # var
  # s ← sphere()
    #And m ← scaling(1, 0.5, 1) * rotation_z(π/5)
    #And set_transform(m)
  #When n ← normal_at(point(0, √2/2, -√2/2))
  #Then n = vector(0, 0.97014, -0.24254)

  #test "A sphere has a default material":
  # var
  # s ← sphere()
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
  #Then s.transform = identity_matrix
    #And s.material.transparency = 1.0
    #And s.material.refractive_index = 1.5

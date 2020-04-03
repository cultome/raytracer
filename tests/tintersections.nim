import unittest
import options

import raytracerpkg/spheres
import raytracerpkg/intersections

suite "Intersections":
  test "An intersection encapsulates t and object":
    var
      s = sphere()
      i = initIntersection(3.5, s)

    check(i.t == 3.5)
    check(i.obj == s)

  test "Aggregating intersections":
    var
      s = sphere()
      i1 = initIntersection(1, s)
      i2 = initIntersection(2, s)
      xs = intersections(i1, i2)

    check(xs.len == 2)
    check(xs[0].t == 1)
    check(xs[1].t == 2)

  test "The hit, when all intersections have positive t":
    var
      s = sphere()
      i1 = initIntersection(1, s)
      i2 = initIntersection(2, s)
      xs = intersections(i2, i1)
      i = hit(xs)

    check(i.get() == i1)

  test "The hit, when some intersections have negative t":
    var
      s = sphere()
      i1 = initIntersection(-1, s)
      i2 = initIntersection(1, s)
      xs = intersections(i2, i1)
      i = hit(xs)

    check(i.get() == i2)

  test "The hit, when all intersections have negative t":
    var
      s = sphere()
      i1 = initIntersection(-2, s)
      i2 = initIntersection(-1, s)
      xs = intersections(i2, i1)
      i = hit(xs)

    check(i == none(Intersection))

  test "The hit is always the lowest nonnegative intersection":
    var
      s = sphere()
      i1 = initIntersection(5, s)
      i2 = initIntersection(7, s)
      i3 = initIntersection(-3, s)
      i4 = initIntersection(2, s)
      xs = intersections(i1, i2, i3, i4)
      i = hit(xs)

    check(i.get() == i4)

  #test "Precomputing the state of an intersection":
  #var
    #r ← ray(initPoint(0, 0, -5), initVector(0, 0, 1))
    #And shape ← sphere()
    #And i ← initIntersection(4, shape)
  #When comps ← prepare_computations(i, r)
  #Then comps.t = i.t
    #And comps.obj = i.obj
    #And comps.point = initPoint(0, 0, -1)
    #And comps.eyev = initVector(0, 0, -1)
    #And comps.normalv = initVector(0, 0, -1)

  #test "Precomputing the reflection initVector":
  #var
    #shape ← plane()
    #And r ← ray(initPoint(0, 1, -1), initVector(0, -√2/2, √2/2))
    #And i ← initIntersection(√2, shape)
  #When comps ← prepare_computations(i, r)
  #Then comps.reflectv = initVector(0, √2/2, √2/2)

  #test "The hit, when an initIntersection occurs on the outside":
  #var
    #r ← ray(initPoint(0, 0, -5), initVector(0, 0, 1))
    #And shape ← sphere()
    #And i ← initIntersection(4, shape)
  #When comps ← prepare_computations(i, r)
  #Then comps.inside = false

  #test "The hit, when an intersection occurs on the inside":
  #var
    #r ← ray(initPoint(0, 0, 0), initVector(0, 0, 1))
    #And shape ← sphere()
    #And i ← initIntersection(1, shape)
  #When comps ← prepare_computations(i, r)
  #Then comps.point = initPoint(0, 0, 1)
    #And comps.eyev = initVector(0, 0, -1)
    #And comps.inside = true
    ## normal would have been (0, 0, 1), but is inverted!
    #And comps.normalv = initVector(0, 0, -1)

  #test "The hit should offset the point":
  #var
    #r ← ray(initPoint(0, 0, -5), initVector(0, 0, 1))
    #And shape ← sphere() with:
      #| transform | translation(0, 0, 1) |
    #And i ← initIntersection(5, shape)
  #When comps ← prepare_computations(i, r)
  #Then comps.over_point.z < -EPSILON/2
    #And comps.point.z > comps.over_point.z

  #test "The under point is offset below the surface":
  #var
    #r ← ray(initPoint(0, 0, -5), initVector(0, 0, 1))
    #And shape ← glass_sphere() with:
      #| transform | translation(0, 0, 1) |
    #And i ← initIntersection(5, shape)
    #And xs ← intersections(i)
  #When comps ← prepare_computations(i, r, xs)
  #Then comps.under_point.z > EPSILON/2
    #And comps.point.z < comps.under_point.z

  #test ": Finding n1 and n2 at various intersections":
  #var
    #A ← glass_sphere() with:
      #| transform                 | scaling(2, 2, 2) |
      #| material.refractive_index | 1.5              |
    #And B ← glass_sphere() with:
      #| transform                 | translation(0, 0, -0.25) |
      #| material.refractive_index | 2.0                      |
    #And C ← glass_sphere() with:
      #| transform                 | translation(0, 0, 0.25) |
      #| material.refractive_index | 2.5                     |
    #And r ← ray(initPoint(0, 0, -4), initVector(0, 0, 1))
    #And xs ← intersections(2:A, 2.75:B, 3.25:C, 4.75:B, 5.25:C, 6:A)
  #When comps ← prepare_computations(xs[<index>], r, xs)
  #Then comps.n1 = <n1>
    #And comps.n2 = <n2>

  #Examples:
    #| index | n1  | n2  |
    #| 0     | 1.0 | 1.5 |
    #| 1     | 1.5 | 2.0 |
    #| 2     | 2.0 | 2.5 |
    #| 3     | 2.5 | 2.5 |
    #| 4     | 2.5 | 1.5 |
    #| 5     | 1.5 | 1.0 |

  #test "The Schlick approximation under total internal reflection":
  #var
    #shape ← glass_sphere()
    #And r ← ray(initPoint(0, 0, √2/2), initVector(0, 1, 0))
    #And xs ← intersections(-√2/2:shape, √2/2:shape)
  #When comps ← prepare_computations(xs[1], r, xs)
    #And reflectance ← schlick(comps)
  #Then reflectance = 1.0

  #test "The Schlick approximation with a perpendicular viewing angle":
  #var
    #shape ← glass_sphere()
    #And r ← ray(initPoint(0, 0, 0), initVector(0, 1, 0))
    #And xs ← intersections(-1:shape, 1:shape)
  #When comps ← prepare_computations(xs[1], r, xs)
    #And reflectance ← schlick(comps)
  #Then reflectance = 0.04

  #test "The Schlick approximation with small angle and n2 > n1":
  #var
    #shape ← glass_sphere()
    #And r ← ray(initPoint(0, 0.99, -2), initVector(0, 0, 1))
    #And xs ← intersections(1.8589:shape)
  #When comps ← prepare_computations(xs[0], r, xs)
    #And reflectance ← schlick(comps)
  #Then reflectance = 0.48873

  #test "An intersection can encapsulate `u` and `v`":
  #var
    #s ← triangle(initPoint(0, 1, 0), initPoint(-1, 0, 0), initPoint(1, 0, 0))
  #When i ← intersection_with_uv(3.5, s, 0.2, 0.4)
  #Then i.u = 0.2
    #And i.v = 0.4

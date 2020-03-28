import unittest
import math

import raytracerpkg/transformations
import raytracerpkg/tuples
import raytracerpkg/matrices

suite "Matrix Transformations":
  test "Multiplying by a translation matrix":
    var
      t = translation(5, -3, 2)
      p = point(-3, 4, 5)

    check(t * p == point(2, 1, 7))

  test "Multiplying by the inverse of a translation matrix":
    var
      t = translation(5, -3, 2)
      inv = inverse(t)
      p = point(-3, 4, 5)

    check(inv * p == point(-8, 7, 3))

  test "Translation does not affect vectors":
    var
      t = translation(5, -3, 2)
      v = vector(-3, 4, 5)

    check(t * v == v)

  test "A scaling matrix applied to a point":
    var
      t = scaling(2, 3, 4)
      p = point(-4, 6, 8)

    check(t * p == point(-8, 18, 32))

  test "A scaling matrix applied to a vector":
    var
      t = scaling(2, 3, 4)
      v = vector(-4, 6, 8)

    check(t * v == vector(-8, 18, 32))

  test "Multiplying by the inverse of a scaling matrix":
    var
      t = scaling(2, 3, 4)
      inv = inverse(t)
      v = vector(-4, 6, 8)

    check(inv * v == vector(-2, 2, 2))

  test "Reflection is scaling by a negative value":
    var
      t = scaling(-1, 1, 1)
      p = point(2, 3, 4)

    check(t * p == point(-2, 3, 4))

  test "Rotating a point around the x axis":
    var
      p = point(0, 1, 0)
      half_quarter = rotation(axisX, PI / 4)
      full_quarter = rotation(axisX, PI / 2)

    check(half_quarter * p == point(0, sqrt(2.0)/2, sqrt(2.0)/2))
    check(full_quarter * p == point(0, 0, 1))

  test "The inverse of an x-rotation rotates in the opposite direction":
    var
      p = point(0, 1, 0)
      half_quarter = rotation(axisX, PI / 4)
      inv = inverse(half_quarter)

    check(inv * p == point(0, sqrt(2.0)/2, -sqrt(2.0)/2))

  test "Rotating a point around the y axis":
    var
      p = point(0, 0, 1)
      half_quarter = rotation(axisY, PI / 4)
      full_quarter = rotation(axisY, PI / 2)

    check(half_quarter * p == point(sqrt(2.0)/2, 0, sqrt(2.0)/2))
    check(full_quarter * p == point(1, 0, 0))

  test "Rotating a point around the z axis":
    var
      p = point(0, 1, 0)
      half_quarter = rotation(axisZ, PI / 4)
      full_quarter = rotation(axisZ, PI / 2)

    check(half_quarter * p == point(-sqrt(2.0)/2, sqrt(2.0)/2, 0))
    check(full_quarter * p == point(-1, 0, 0))

  #test "A shearing transformation moves x in proportion to y":
    #var
      #t = shearing(1, 0, 0, 0, 0, 0)
      #p = point(2, 3, 4)

    #check(transform * p == point(5, 3, 4))

  #test "A shearing transformation moves x in proportion to z":
    #var
      #t = shearing(0, 1, 0, 0, 0, 0)
      #p = point(2, 3, 4)

    #check(transform * p == point(6, 3, 4))

  #test "A shearing transformation moves y in proportion to x":
    #var
      #t = shearing(0, 0, 1, 0, 0, 0)
      #p = point(2, 3, 4)

    #check(transform * p == point(2, 5, 4))

  #test "A shearing transformation moves y in proportion to z":
    #var
      #t = shearing(0, 0, 0, 1, 0, 0)
      #p = point(2, 3, 4)

    #check(transform * p == point(2, 7, 4))

  #test "A shearing transformation moves z in proportion to x":
    #var
      #t = shearing(0, 0, 0, 0, 1, 0)
      #p = point(2, 3, 4)

    #check(transform * p == point(2, 3, 6))

  #test "A shearing transformation moves z in proportion to y":
    #var
      #t = shearing(0, 0, 0, 0, 0, 1)
      #p = point(2, 3, 4)

    #check(transform * p == point(2, 3, 7))

  #test "Individual transformations are applied in sequence":
    #var
      #p = point(1, 0, 1)
      #t1 = rotation(axisX, PI / 2)
      #t2 = scaling(5, 5, 5)
      #t3 = translation(10, 5, 7)

    ## apply rotation first
    #p2 = A * p
    #check(p2 == point(1, -1, 0))

    ## then apply scaling
    #p3 = B * p2
    #check(p3 == point(5, -5, 0))

    ## then apply translation
    #p4 = C * p3
    #check(p4 == point(15, 0, 7))

  #test "Chained transformations must be applied in reverse order":
    #var
      #p = point(1, 0, 1)
      #t1 = rotation(axisX, PI / 2)
      #t2 = scaling(5, 5, 5)
      #t3 = translation(10, 5, 7)
      #T = C * B * A

    #check(T * p == point(15, 0, 7))

  #test "The transformation matrix for the default orientation":
    #var
      #p = point(0, 0, 0)
      #to = point(0, 0, -1)
      #up = vector(0, 1, 0)
      #t = view_transform(from, to, up)

    #check(t == identity_matrix)

  #test "A view transformation matrix looking in positive z direction":
    #var
      #p = point(0, 0, 0)
      #to = point(0, 0, 1)
      #up = vector(0, 1, 0)
      #t = view_transform(from, to, up)

    #check(t == scaling(-1, 1, -1))

  #test "The view transformation moves the world":
    #var
      #p = point(0, 0, 8)
      #to = point(0, 0, 0)
      #up = vector(0, 1, 0)
      #t = view_transform(from, to, up)

    #check(t == translation(0, 0, -8))

  #test "An arbitrary view transformation":
    #var
      #p = point(1, 3, 2)
      #to = point(4, -2, 8)
      #up = vector(1, 1, 0)
      #t = p.view_transform(to, up)
      #m = matrix(
        #@[-0.50709, 0.50709, 0.67612, -2.36643],
        #@[0.76772, 0.60609, 0.12122, -2.82843],
        #@[-0.35857, 0.59761, -0.71714, 0.00000],
        #@[0.00000, 0.00000, 0.00000, 1.00000],
      #)

    #check(t == m)

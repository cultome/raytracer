import unittest

import raytracerpkg/tuples
import raytracerpkg/matrices

suite "matrices features":
  test "contructing and inspecting a 4x4 matrix":
    var m = initMatrix(
      @[1.0, 2.0, 3.0, 4.0],
      @[5.5, 6.5, 7.5, 8.5],
      @[9.0, 10.0, 11.0, 12.0],
      @[13.5, 14.5, 15.5, 16.5],
    )

    check(m.at(0,0) == 1.0)
    check(m.at(0,3) == 4.0)
    check(m.at(1,0) == 5.5)
    check(m.at(1,2) == 7.5)
    check(m.at(2,2) == 11.0)
    check(m.at(3,0) == 13.5)
    check(m.at(3,2) == 15.5)

  test "a 2x2 matrix ought to be representable":
    var m = initMatrix(
      @[-3.0, 5.0],
      @[1.0, -2.0],
    )

    check(m.at(0,0) == -3.0)
    check(m.at(0,1) == 5.0)
    check(m.at(1,0) == 1.0)
    check(m.at(1,1) == -2.0)

  test "a 3x3 matrix ought to be representable":
    var m = initMatrix(
      @[-3.0, 5.0, 0.0],
      @[1.0, -2.0, -7],
      @[0.0, 1.0, 1.0],
    )

    check(m.at(0,0) == -3.0)
    check(m.at(1,1) == -2.0)
    check(m.at(2,2) == 1.0)

  test "matrix equiality with identical matrices":
    var
      m1 = initMatrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

      m2 = initMatrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

    check(m1 == m2)

  test "matrix equiality with differences matrices":
    var
      m1 = initMatrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

      m2 = initMatrix(
        @[2.0, 3.0, 4.0, 5.0],
        @[6.0, 7.0, 8.0, 9.0],
        @[8.0, 7.0, 6.0, 5.0],
        @[4.0, 3.0, 2.0, 1.0],
      )

    check(m1 != m2)

  test "multiplying two matrices":
    var
      m1 = initMatrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

      m2 = initMatrix(
        @[-2.0, 1.0, 2.0, 3.0],
        @[3.0, 2.0, 1.0, -1.0],
        @[4.0, 3.0, 6.0, 5.0],
        @[1.0, 2.0, 7.0, 8.0],
      )

      r = initMatrix(
        @[20.0, 22.0,  50.0,  48.0],
        @[44.0, 54.0, 114.0, 108.0],
        @[40.0, 58.0, 110.0, 102.0],
        @[16.0, 26.0, 46.0,  42.0],
      )

    check(m1 * m2 == r)

  test "multiplying a matrix by a tuple":
    var
      m = initMatrix(
        @[1.0, 2.0, 3.0, 4.0,],
        @[2.0, 4.0, 4.0, 2.0,],
        @[8.0, 6.0, 4.0, 1.0,],
        @[0.0, 0.0, 0.0, 1.0,],
      )

      t = initTuple(1, 2, 3, 1)

    check(m * t == initTuple(18, 24, 33, 1))

  test "Multiplying a matrix by the identity matrix":
    var m = initMatrix(
      @[0.0, 1.0, 2.0, 4.0],
      @[1.0, 2.0, 4.0, 8.0],
      @[2.0, 4.0, 8.0, 16.0],
      @[4.0, 8.0, 16.0, 32.0],
    )

    check(m * identity(4) == m)

  test "Multiplying the identity matrix by a tuple":
    var t = initTuple(1, 2, 3, 4)

    check(identity(4) * t == t)

  test "Scenario: Transposing a matrix":
    var
      m = initMatrix(
        @[0.0, 9.0, 3.0, 0.0],
        @[9.0, 8.0, 0.0, 8.0],
        @[1.0, 8.0, 5.0, 3.0],
        @[0.0, 0.0, 5.0, 8.0],
      )

      r = initMatrix(
        @[0.0, 9.0, 1.0, 0.0],
        @[9.0, 8.0, 8.0, 0.0],
        @[3.0, 0.0, 5.0, 5.0],
        @[0.0, 8.0, 3.0, 8.0],
      )

    check(m.transpose == r)

  test "Transposing the identity matrix":
    var id = identity(4)

    check(id.transpose == id)

  test "Calculating the determinant of a 2x2 matrix":
    var m = initMatrix(
      @[1.0, 5.0],
      @[-3.0, 2.0],
    )

    check(m.determinant == 17)

  test "A submatrix of a 3x3 matrix is a 2x2 matrix":
    var
      m = initMatrix(
        @[1.0, 5.0, 0.0],
        @[-3.0, 2.0, 7.0],
        @[0.0, 6.0, -3.0],
      )

      s = initMatrix(
        @[-3.0, 2.0],
        @[0.0, 6.0],
      )

    check(m.submatrix(0, 2) == s)

  test "A submatrix of a 4x4 matrix is a 3x3 matrix":
    var
      m = initMatrix(
        @[-6.0, 1.0, 1, 6.0],
        @[-8.0, 5.0, 8, 6.0],
        @[-1.0, 0.0, 8, 2.0],
        @[-7.0, 1.0, -1.0, 1.0],
      )

      s = initMatrix(
        @[-6.0, 1.0, 6.0,],
        @[-8.0, 8.0, 6.0,],
        @[-7.0, -1.0, 1.0,],
      )

    check(m.submatrix(2, 1) == s)

  test "Calculating a minor of a 3x3 matrix":
    var
      m = initMatrix(
        @[3.0, 5.0, 0.0],
        @[2.0, -1.0, -7.0],
        @[6.0, -1.0, 5.0],
      )

      s = m.submatrix(1, 0)

    check(s.determinant == 25)
    check(m.minor(1, 0) == 25)

  test "Calculating a cofactor of a 3x3 matrix":
    var m = initMatrix(
      @[3.0, 5.0, 0.0],
      @[2.0, -1.0, -7.0],
      @[6.0, -1.0,  5.0],
    )

    check(m.minor(0, 0) == -12.0)
    check(m.cofactor(0, 0) == -12.0)

    check(m.minor(1, 0) == 25.0)
    check(m.cofactor(1, 0) == -25.0)

  test "Calculating the determinant of a 3x3 matrix":
    var m = initMatrix(
      @[1.0, 2.0, 6.0],
      @[-5.0, 8.0,-4.0],
      @[2.0, 6.0, 4.0],
    )

    check(m.cofactor(0, 0) == 56.0)
    check(m.cofactor(0, 1) == 12.0)
    check(m.cofactor(0, 2) == -46.0)
    check(m.determinant == -196.0)

  test "Calculating the determinant of a 4x4 matrix":
    var m = initMatrix(
      @[-2.0, -8.0, 3.0, 5.0],
      @[-3.0, 1.0, 7.0, 3.0],
      @[1.0, 2.0, -9.0, 6.0],
      @[-6.0,  7.0, 7.0, -9.0],
    )

    check(m.cofactor(0, 0) == 690.0)
    check(m.cofactor(0, 1) == 447.0)
    check(m.cofactor(0, 2) == 210.0)
    check(m.cofactor(0, 3) == 51.0)
    check(m.determinant == -4071.0)

  test "Testing an invertible matrix for invertibility":
    var m = initMatrix(
      @[6.0,  4.0,  4.0,  4.0],
      @[5.0,  5.0,  7.0,  6.0],
      @[4.0, -9.0,  3.0, -7.0],
      @[9.0,  1.0,  7.0, -6.0],
    )

    check(m.determinant == -2120.0)

  test "Testing a noninvertible matrix for invertibility":
    var m = initMatrix(
      @[-4.0, 2.0, -2.0, -3.0],
      @[9.0, 6.0, 2.0, 6.0],
      @[0.0, -5.0, 1.0, -5.0],
      @[0.0, 0.0, 0.0, 0.0],
    )

    check(m.determinant == 0.0)

  test "Calculating the inverse of a matrix":
    var
      m = initMatrix(
        @[-5.0, 2.0, 6.0, -8.0],
        @[1.0, -5.0, 1.0, 8.0],
        @[7.0, 7.0, -6.0, -7.0],
        @[1.0, -3.0, 7.0, 4.0],
      )

      r = m.inverse

      i = initMatrix(
        @[0.218050, 0.45113, 0.24060, -0.04511],
        @[-0.80827, -1.45677, -0.44361, 0.52068],
        @[-0.07895, -0.22368, -0.05263, 0.19737],
        @[-0.52256, -0.81391, -0.30075, 0.30639],
      )

    check(m.determinant == 532.0)
    check(m.cofactor(2, 3) == -160.0)
    check(r.at(3,2) == -160.0 / 532.0)
    check(m.cofactor(3, 2) == 105.0)
    check(r.at(2, 3) == 105.0 / 532.0)
    check(i == r)

  test "Calculating the inverse of another matrix":
    var
      m = initMatrix(
        @[8.0, -5.0, 9.0, 2.0],
        @[7.0, 5.0, 6.0, 1.0],
        @[-6.0, 0.0, 9.0, 6.0],
        @[-3.0, 0.0, -9.0, -4.0],
      )

      i = initMatrix(
        @[-0.15385, -0.15385, -0.28205, -0.53846],
        @[-0.07692, 0.12308, 0.02564, 0.03077],
        @[0.35897, 0.35897, 0.43590, 0.92308],
        @[-0.69231, -0.69231, -0.76923, -1.92308],
      )

    check(m.inverse == i)

  test "Calculating the inverse of a third matrix":
    var
      m = initMatrix(
        @[9.0,  3.0,  0.0,  9.0],
        @[-5.0, -2.0, -6.0, -3.0],
        @[-4.0,  9.0,  6.0,  4.0],
        @[-7.0,  6.0,  6.0,  2.0],
      )

      i = initMatrix(
        @[-0.04074, -0.07778,  0.14444, -0.22222],
        @[-0.07778,  0.03333,  0.36667, -0.33333],
        @[-0.02901, -0.14630, -0.10926,  0.12963],
        @[0.17778,  0.06667, -0.26667,  0.33333],
      )

    check(m.inverse == i)

  test "Multiplying a product by its inverse":
    var
      m1 = initMatrix(
        @[3.0, -9.0, 7.0, 3.0],
        @[3.0, -8.0, 2.0, -9.0],
        @[-4.0, 4.0, 4.0, 1.0],
        @[-6.0, 5.0, -1.0, 1.0],
      )

      m2 = initMatrix(
        @[8.0, 2.0, 2.0, 2.0],
        @[3.0, -1.0, 7.0, 0.0],
        @[7.0, 0.0, 5.0, 4.0],
        @[6.0, -2.0, 0.0, 5.0],
      )

      m3 = m1 * m2

    check(m3 * m2.inverse == m1)

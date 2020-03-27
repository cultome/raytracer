import unittest

import raytracerpkg/tuples
import raytracerpkg/matrices

suite "matrices features":
  test "contructing and inspecting a 4x4 matrix":
    var m = matrix(
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
    var m = matrix(
      @[-3.0, 5.0],
      @[1.0, -2.0],
    )

    check(m.at(0,0) == -3.0)
    check(m.at(0,1) == 5.0)
    check(m.at(1,0) == 1.0)
    check(m.at(1,1) == -2.0)

  test "a 3x3 matrix ought to be representable":
    var m = matrix(
      @[-3.0, 5.0, 0.0],
      @[1.0, -2.0, -7],
      @[0.0, 1.0, 1.0],
    )

    check(m.at(0,0) == -3.0)
    check(m.at(1,1) == -2.0)
    check(m.at(2,2) == 1.0)

  test "matrix equiality with identical matrices":
    var
      m1 = matrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

      m2 = matrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

    check(m1 == m2)

  test "matrix equiality with differences matrices":
    var
      m1 = matrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

      m2 = matrix(
        @[2.0, 3.0, 4.0, 5.0],
        @[6.0, 7.0, 8.0, 9.0],
        @[8.0, 7.0, 6.0, 5.0],
        @[4.0, 3.0, 2.0, 1.0],
      )

    check(m1 != m2)

  test "multiplying two matrices":
    var
      m1 = matrix(
        @[1.0, 2.0, 3.0, 4.0],
        @[5.0, 6.0, 7.0, 8.0],
        @[9.0, 8.0, 7.0, 6.0],
        @[5.0, 4.0, 3.0, 2.0],
      )

      m2 = matrix(
        @[-2.0, 1.0, 2.0, 3.0],
        @[3.0, 2.0, 1.0, -1.0],
        @[4.0, 3.0, 6.0, 5.0],
        @[1.0, 2.0, 7.0, 8.0],
      )

      r = matrix(
        @[20.0, 22.0,  50.0,  48.0],
        @[44.0, 54.0, 114.0, 108.0],
        @[40.0, 58.0, 110.0, 102.0],
        @[16.0, 26.0, 46.0,  42.0],
      )

    check(m1 * m2 == r)

  test "multiplying a matrix by a tuple":
    var
      m = matrix(
        @[1.0, 2.0, 3.0, 4.0,],
        @[2.0, 4.0, 4.0, 2.0,],
        @[8.0, 6.0, 4.0, 1.0,],
        @[0.0, 0.0, 0.0, 1.0,],
      )

      t = tp(1, 2, 3, 1)

    check(m * t == tp(18, 24, 33, 1))

  test "Multiplying a matrix by the identity matrix":
    var m = matrix(
      @[0.0, 1.0, 2.0, 4.0],
      @[1.0, 2.0, 4.0, 8.0],
      @[2.0, 4.0, 8.0, 16.0],
      @[4.0, 8.0, 16.0, 32.0],
    )

    check(m * identity(4) == m)

  test "Multiplying the identity matrix by a tuple":
    var t = tp(1, 2, 3, 4)

    check(identity(4) * t == t)

  test "Scenario: Transposing a matrix":
    var
      m = matrix(
        @[0.0, 9.0, 3.0, 0.0],
        @[9.0, 8.0, 0.0, 8.0],
        @[1.0, 8.0, 5.0, 3.0],
        @[0.0, 0.0, 5.0, 8.0],
      )

      r = matrix(
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
    var m = matrix(
      @[1.0, 5.0],
      @[-3.0, 2.0],
    )

    check(m.determinant == 17)

  test "A submatrix of a 3x3 matrix is a 2x2 matrix":
    var
      m = matrix(
        @[1.0, 5.0, 0.0],
        @[-3.0, 2.0, 7.0],
        @[0.0, 6.0, -3.0],
      )

      s = matrix(
        @[-3.0, 2.0],
        @[0.0, 6.0],
      )

    check(m.submatrix(0, 2) == s)

  test "A submatrix of a 4x4 matrix is a 3x3 matrix":
    var
      m = matrix(
        @[-6.0, 1.0, 1, 6.0],
        @[-8.0, 5.0, 8, 6.0],
        @[-1.0, 0.0, 8, 2.0],
        @[-7.0, 1.0, -1.0, 1.0],
      )

      s = matrix(
        @[-6.0, 1.0, 6.0,],
        @[-8.0, 8.0, 6.0,],
        @[-7.0, -1.0, 1.0,],
      )

    check(m.submatrix(2, 1) == s)

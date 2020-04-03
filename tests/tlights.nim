import unittest

import raytracerpkg/tuples
import raytracerpkg/lights

suite "Lights feature":
  test "A point light has a position and intensity":
    var
      intensity = initColor(1, 1, 1)
      position = initPoint(0, 0, 0)
      light = initLightPoint(position, intensity)

    check(light.position == position)
    check(light.intensity == intensity)

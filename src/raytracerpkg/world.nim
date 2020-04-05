import raytracerpkg/lights
import raytracerpkg/spheres

type
  World* = ref object
    objects*: seq[Sphere]
    light*: LightPoint

proc initWorld*(objects: seq[Sphere], light: LightPoint): World =
  World(objects: objects, light: light)

proc emptyWorld*(): World =
  initWorld(objects = @[], light = nil)

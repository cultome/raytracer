import raytracerpkg/tuples
import raytracerpkg/transformations
import raytracerpkg/lights
import raytracerpkg/spheres
import raytracerpkg/materials
import raytracerpkg/computation

type
  World* = ref object
    objects*: seq[Sphere]
    light*: LightPoint

proc defaultLightPoint(): LightPoint =
  initLightPoint(initPoint(-10, 10, -10), initColor(1, 1, 1))

proc defaultObjects(): seq[Sphere] =
  var
    s1 = initSphere(material = initMaterial(color = (0.8, 1.0, 0.6), diffuse = 0.7, specular = 0.2))
    s2 = initSphere(scaling(0.5, 0.5, 0.5))

  @[s1, s2]

proc initWorld*(objects = defaultObjects(), light = defaultLightPoint()): World =
  World(objects: objects, light: light)

proc emptyWorld*(): World =
  initWorld(@[], nil)

proc shadeHit*(w: World, c: Computation): Color =
  c.obj.material.lighting(w.light, c.point, c.eye, c.normal)

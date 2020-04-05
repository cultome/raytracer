import math

import raytracerpkg/tuples
import raytracerpkg/lights

type
  Material* = ref object
    color*: Color
    ambient*: float64 # 0..1
    diffuse*: float64 # 0..1
    specular*: float64 # 0..1
    shininess*: float64 # 10..200

proc initMaterial*(color = initColor(1, 1, 1), ambient = 0.1, diffuse = 0.9, specular = 0.9, shininess = 200.0): Material =
  Material(color: color, ambient: ambient, diffuse: diffuse, specular: specular, shininess: shininess)

proc `==`*(m1, m2: Material): bool =
    m1.color == m2.color and m1.ambient == m2.ambient and m1.diffuse == m2.diffuse and m1.specular == m2.specular and m1.shininess == m2.shininess

proc lighting*(m: Material, light: LightPoint, point: Point, eye, normal: Vector): Color =
  var
    blackColor = initColor(0, 0, 0)
    effectiveColor = m.color * light.intensity
    lightV = (light.position - point).normalize
    ambient = effectiveColor * m.ambient
    lightDotNormal = lightV.dot(normal)
    diffuse, specular: Color
    reflectV: Vector
    factor, reflectDotEye: float64

  if lightDotNormal < 0:
    diffuse = blackColor
    specular = blackColor
  else:
    diffuse = effectiveColor * m.diffuse * lightDotNormal
    reflectV = !lightV.reflect(normal)
    reflectDotEye = reflectV.dot(eye)

    if reflectDotEye <= 0:
      specular = blackColor
    else:
      factor = pow(reflectDotEye, m.shininess)
      specular = light.intensity * m.specular * factor

  ambient + diffuse + specular

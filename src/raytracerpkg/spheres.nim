import raytracerpkg/matrices
import raytracerpkg/tuples
import raytracerpkg/materials

type
  Sphere* = ref object
    transformation*: Matrix
    material*: Material

proc `$`*(s: Sphere): string =
  "Sphere"

proc `==`*(s1, s2: Sphere): bool =
  s1.transformation == s2.transformation and s1.material == s2.material

proc initSphere*(transformation = identity(4), material = initMaterial()): Sphere =
  Sphere(transformation: transformation, material: material)

proc normalAt*(s: Sphere, p: Point): Vector =
  var
    objPoint = s.transformation.inverse * p
    objNormal = objPoint - initPoint(0, 0, 0)
    worldNormal = s.transformation.inverse.transpose * objNormal

  worldNormal.w = 0
  worldNormal.normalize

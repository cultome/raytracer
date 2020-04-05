import raytracerpkg/matrices
import raytracerpkg/tuples
import raytracerpkg/materials

type
  Sphere* = ref object
    transformation*: Matrix
    material*: Material

proc initSphere*(transformation = identity(4), material = initMaterial()): Sphere =
  Sphere(transformation: transformation, material: material)

proc normalAt*(s: Sphere, p: Point): Vector =
  var
    objPoint = s.transformation.inverse * p
    objNormal = objPoint - initPoint(0, 0, 0)
    worldNormal = s.transformation.inverse.transpose * objNormal

  worldNormal.w = 0
  worldNormal.normalize

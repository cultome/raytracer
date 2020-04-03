import raytracerpkg/matrices
import raytracerpkg/tuples

type
  Sphere* = ref object
    transformation*: Matrix

proc initSphere*(transformation: Matrix): Sphere =
  Sphere(transformation: transformation)

proc initSphere*(): Sphere =
  initSphere(identity(4))

proc normalAt*(s: Sphere, p: Point): Vector =
  var
    objPoint = s.transformation.inverse * p
    objNormal = objPoint - initPoint(0, 0, 0)
    worldNormal = s.transformation.inverse.transpose * objNormal

  worldNormal.w = 0
  worldNormal.normalize

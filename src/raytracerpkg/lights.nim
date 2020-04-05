import raytracerpkg/tuples

type
  LightPoint* = ref object
    position*: Point
    intensity*: Color

proc `==`*(l1, l2: LightPoint): bool =
  if l1.isNil and l2.isNil:
    true
  elif l1.isNil or l2.isNil:
    false
  else:
    l1.position == l2.position and l1.intensity == l2.intensity

proc initLightPoint*(position: Point, intensity: Color): LightPoint =
  LightPoint(position: position, intensity: intensity)

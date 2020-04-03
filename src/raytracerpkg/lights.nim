import raytracerpkg/tuples

type
  LightPoint* = ref object
    position*: Point
    intensity*: Color

proc initLightPoint*(position: Point, intensity: Color): LightPoint =
  LightPoint(position: position, intensity: intensity)

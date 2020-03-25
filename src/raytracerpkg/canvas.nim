import raytracerpkg/core

type
  Canvas* = ref object
    width*: int
    height*: int
    pixels*: seq[seq[Color]]

proc canvas*(width, height: int): Canvas =
  var
    pixels: seq[seq[Color]]
    col: seq[Color]
    color = color(0, 0, 0)

  for x in 0..<width:
    col = @[]

    for y in 0..<height:
      col.add(color)

    pixels.add(col)

  Canvas(width: width, height: height, pixels: pixels)

proc writePixel*(c: Canvas, x, y: int, color: Color) =
  c.pixels[x][y] = color

proc pixelAt*(c: Canvas, x, y: int): Color =
  c.pixels[x][y]

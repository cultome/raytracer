import strutils
import algorithm

import raytracerpkg/tuples

type
  Canvas* = ref object
    width*: int
    height*: int
    pixels*: seq[seq[Color]] # pixels[y][x]

proc initCanvas*(width, height: int, color: Color): Canvas =
  var
    pixels: seq[seq[Color]]
    col: seq[Color]

  for _ in 0..<height:
    col = @[]

    for _ in 0..<width:
      col.add(color)

    pixels.add(col)

  Canvas(width: width, height: height, pixels: pixels)

proc initCanvas*(width, height: int): Canvas =
  initCanvas(width, height, initColor(0, 0, 0))

proc writePixel*(c: Canvas, x, y: int, color: Color) =
  c.pixels[y][x] = color

proc pixelAt*(c: Canvas, x, y: int): Color =
  c.pixels[y][x]

proc normalizeColor(val: float64): int =
  if val <= 0:
    0
  elif val >= 1:
    255
  else:
    int(255 * val + 0.5)

proc toPpm*(c: Canvas, invert = false): string =
  let header = "P3\n$1 $2\n255" % [$c.width, $c.height]
  var
    lines = @[""]
    currLine = 0
    normalized: string

  for row in c.pixels:
    for pixel in row:
      for val in [pixel.red, pixel.green, pixel.blue]:
        normalized = $normalizeColor(val)

        if not invert:
          if lines[currLine].len + normalized.len > 70:
            lines[currLine] = lines[currLine].strip
            lines.add("")
            currLine += 1

        lines[currLine] &= normalized & " "

    lines[currLine] = lines[currLine].strip
    lines.add("")
    currLine += 1

  if invert:
    lines.reverse

  header & "\n" & lines.join("\n")

proc save*(c: Canvas, filename: string) =
  writeFile(filename, c.toPpm(true))

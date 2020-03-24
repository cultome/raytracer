type
  Canvas* = object
    width*: int
    height*: int

proc canvas*(width, height: int): Canvas =
  Canvas(width: width, height: height)

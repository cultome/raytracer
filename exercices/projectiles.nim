import raytracerpkg/tuples
import gnuplot

type
  Projectile = object
    position: Point
    velocity: Vector

  Environment = object
    gravity: Vector
    wind: Vector

proc tick(env: Environment, pro: Projectile): Projectile =
  var
    nextPos = pro.position + pro.velocity
    nextVel = pro.velocity + env.gravity + env.wind

  Projectile(position: nextPos, velocity: nextVel)

proc launch*(position: Point, velocity: Vector, gravity: Vector, wind: Vector): (seq[float64], seq[float64]) =
  var
    initialProjectile = Projectile(position: position, velocity: velocity)
    env = Environment(gravity: gravity, wind: wind)
    nextProjectile: Projectile

  nextProjectile = tick(env, initialProjectile)
  var
    xs = @[nextProjectile.position.x]
    ys = @[nextProjectile.position.y]

  while nextProjectile.position.y > 0:
    nextProjectile = tick(env, nextProjectile)
    xs.add(nextProjectile.position.x)
    ys.add(nextProjectile.position.y)

  (xs, ys)

when isMainModule:
  let (xs, ys) = launch(point(0, 1, 0), vector(1, 1, 0), vector(0, -0.1, 0), vector(-0.01, 0, 0))
  plot xs, ys, "X Y"
  discard readChar stdin

import raytracerpkg/core

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

var
  p = Projectile(position: point(0, 1, 0), velocity: vector(1, 1, 0))
  e = Environment(gravity: vector(o, -0.1, 0), wind: vector(-0.01, 0, 0))
  nextP: Projectile

for step in 0..10:
 nextP = tick(e, p)
 echo nextP

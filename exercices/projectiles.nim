import raytracerpkg/core
import strutils

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
  initialProjectile = Projectile(position: point(0, 1, 0), velocity: vector(1, 1, 0))
  env = Environment(gravity: vector(0, -0.1, 0), wind: vector(-0.01, 0, 0))
  nextProjectile: Projectile

nextProjectile = tick(env, initialProjectile)
while nextProjectile.position.y > 0:
  nextProjectile = tick(env, nextProjectile)

# gnuplot -e 'plot "exercices/projectiles.data" with lines; pause 5'

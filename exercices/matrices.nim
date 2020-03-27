import raytracerpkg/matrices

var id = identity(4)

echo "==== id ===="
echo id
echo "==== id.inverse ===="
echo id.inverse.print(1)

echo "Same? " & $(id.inverse == id)

var m1 = matrix(
  @[3.0, -9.0, 7.0, 3.0],
  @[3.0, -8.0, 2.0, -9.0],
  @[-4.0, 4.0, 4.0, 1.0],
  @[-6.0, 5.0, -1.0, 1.0],
)

echo "==== m1 ======"
echo m1.print(1)
echo "==== m1.inverse ======"
echo m1.inverse.print(1)
echo "==== m1 * m2 ======"
echo m1 * m1.inverse
echo "Identity? " & $((m1 * m1.inverse) == id)


echo "====== transpose.inverse ========"
echo m1.transpose.inverse
echo "====== inverse.transpose ========"
echo m1.inverse.transpose

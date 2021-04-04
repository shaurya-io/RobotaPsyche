
PVector P1, P2, P3, V, B, VM;
P1 = new PVector(0, 0);
P2 = new PVector(0, 50);
P3 = new PVector(50, 30);

V = PVector.sub(P3, P1);
B = PVector.sub(P2, P1);

B.normalize();

VM = B.mult(V.dot(B));
println(VM);

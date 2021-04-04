size(800, 600);

int k = 10;


PVector P1, P2, P3, V, B, VM;
P1 = new PVector(k, k);
P2 = new PVector(k, 5*k);
P3 = new PVector(5*k, k);

V = PVector.sub(P3, P1);
B = PVector.sub(P1, P2);

V.normalize();

VM = B.mult(V.dot(B));
println(VM);

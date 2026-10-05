function Q = fQ(x,u,Q,T)

T2 = T^2/2;
h = x(4);
G = [T2*cos(h) 0;0 T2*sin(h);T 0;0 T2;0 T];

Q = G*Q*G';

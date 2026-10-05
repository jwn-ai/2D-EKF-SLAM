function xn = PropagateState(xn1,un,T)

h = xn1(4);
w = un(2);
v = un(1);



fx = v*T*sinc(w*T/2/pi)*cos(h+w*T/2);
fy = v*T*sinc(w*T/2/pi)*sin(h+w*T/2);

f = [fx fy 0 w*T 0]';

xn = xn1 + f;

xn(4) = AngleRange(xn(4));


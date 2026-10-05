function H = LinearizeMeasurement(x,m)


dy = m(2)-x(2);
dx = m(1)-x(1);
d = sqrt( dx^2 + dy^2 );
d2 = d^2;

H = [-dx/d -dy/d 0 0 0;
     dy/d2 -dx/d2 0 -1 0];





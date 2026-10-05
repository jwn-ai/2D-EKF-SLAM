function F = LinearizeStatePropagation(x,u,T)

w = u(2);
v = u(1);
h = x(4);

if w ~=0
    wT2 = w*T/2;
    S = T*sinc(wT2/pi);
    c = cos(h+wT2);
    s = sin(h+wT2);

    cs = T*w*cos(h+T*w) - sin(h+T*w)+sin(h);
    sc = T*w*sin(h+T*w) + cos(h+T*w)-cos(h);

    F = [1 0 S*c -v*S*s v/w^2*cs;
        0 1 S*s v*S*c v/w^2*sc;
        0 0 1 0 0;
        0 0 0 1 T
        0 0 0 0 1];

    % F = [1 0 -v*S*s;
    %     0 1 v*S*c;
    %     0 0 1];
else
    F = [1 0 T*cos(h) -v*T*sin(h) -v*T^2*sin(h);
         0 1 T*sin(h) v*T*cos(h) v*T^2*cos(h);
         0 0 1 0 0;
         0 0 0 1 T;
         0 0 0 0 1];
end





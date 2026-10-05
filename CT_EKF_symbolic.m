syms v T w h real;

fx = v*T*sinc(w*T/2/pi)*cos(h+w*T/2);
fy = v*T*sinc(w*T/2/pi)*sin(h+w*T/2);

fx_v = diff(fx,v)
fx_h = simplify(diff(fx,h))
fx_w = simplify(diff(fx,w))

fy_v = diff(fy,v)
fy_h = simplify(diff(fy,h))
fy_w = combine(simplify(diff(fy,w)))

fy_w2 = diff(diff(w^2*fy_w))

subs(fy_w2,w,0)

fx_w2 = diff(diff(w^2*fx_w))

subs(fx_w2,w,0)

syms u v x y real;

fr = sqrt( (u-x)^2 + (v-y)^2 );
fr_x = simplify(diff(fr,x))
fr_y = simplify(diff(fr,y))

fh = atan(v - y,u - x);
fh_x = simplify(diff(fh,x))
fh_y = simplify(diff(fh,y))
clear;close all;

T1 = 100;
Fs = 10;
T = 1/Fs;
N1 = T1*Fs;
t1 = 0:T:T1-T;
x10 = [0;0];
v1 = 1;

h1dot = 0;
h10 = 45;
h1 = h10 + h1dot*t1;
x1 = x10 + v1*[cosd(h1).*t1;sind(h1).*t1];


T2 = 10;
t2 = 0:T:T2;%T1+T2-T;
r2 = 10;
h2dot = -180/T2;
h20 = 90;
v2 = r2*h2dot;
x20 = 0;%x1(N1);
y20 = -r2;%y1(N1);
h2 = h20 + h2dot.*t2;

x2 = [x20;y20]+r2*[cosd(h2);sind(h2)];
figure,plot(x2(1,:),x2(2,:));axis equal;


c2 = FindCenter(h1(N1),x1(1,N1),x1(2,N1),r2);
R2 = [cosd(h1(N1)) -sind(h1(N1));sind(h1(N1)) cosd(h1(N1))];

x2 = x1(:,N1) + R2*x2;
figure,plot(x2(1,:),x2(2,:));axis equal;

x = [x1 x2];
figure,plot(x(1,:),x(2,:));axis equal;

plot(v2*cosd(h2).*t2,v2*sind(h2).*t2)






xn1 = [0 0 1 1 0]';
X = zeros(5,N);

for n=1:N

    w = ww(n);

wT = w*T;
S = T*sinc(wT/pi);
%C = (1 - cos(wT))/w;
C = -T*sinc(wT/pi)*sin(wT/pi);
s =  sin(wT);
c = cos(wT);

F = [1 0 S -C;
    0 1 C S;
    0 0 c -s;
    0 0 s c;];

F1 = blkdiag(F,1);

xn = F1*xn1;
xn(5) = w;
xn1 = xn;
X(:,n) = xn1;
end

figure,plot(X(1,:),X(2,:))

syms w h v T real;

f = sin(theta)*sin(w)+cos(theta)*(1-cos(w));

f2 = combine(simplify(f,'IgnoreAnalyticConstraints',true,'Steps', 500))

f3 = cos(w)-cos(w+theta);

simplify(f3,'All',true,'Steps', 10)
expand(f3, 'ArithmeticOnly', true)

gx = v*T*sinc(w*T/2/pi)*cos(h+w*T/2);
gy = v*T*sinc(w*T/2/pi)*sin(h+w*T/2);

gx_w = simplify(diff(gx,w),'Steps', 100)
gy_w = simplify(diff(gy,w),'Steps', 100)

gx_h = simplify(diff(gx,h),'Steps', 100)
gy_h = simplify(diff(gy,h),'Steps', 100)

gx_v = simplify(diff(gx,v),'Steps', 100)
gy_v = simplify(diff(gy,v),'Steps', 100)

function c = FindCenter(h,x,y,a)


r = sqrt(x^2+y^2);
alpha = 180/pi*atan(a/r);

r0 = sqrt(a^2+r^2);

phi = h-alpha;
cx = r0*cosd(phi);
cy = r0*sind(phi);

c = [cx;cy];

end
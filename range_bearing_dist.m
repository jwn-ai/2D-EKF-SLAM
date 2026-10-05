

p1 = [0;0];
p2 = [200;0];
N = 10000;
phi1 = pi/4 + .1*randn(N,1)';
phi2 = 3*pi/4 + .1*randn(N,1)';

r1 = 100*sqrt(2)+5*rand(N,1)';

r2 = 100*sqrt(2)+5*rand(N,1)';

hinv = @(p,r,phi) [p(1)+r.*cos(phi);p(2)+r.*sin(phi)];

x1 = hinv(p1,r1,phi1);
x2 = hinv(p2,r2,phi2);

figure,plot(x1(1,:),x1(2,:),'.');hold on;
plot(x2(1,:),x2(2,:),'.');





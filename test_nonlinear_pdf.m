
clear;
close all;
L = 10;
x0 = L*[-5 -4.5 -4   -3  0  1 3 5] 
y0 = L*[1 0 -0.7 -2  -.5  3  1.9 2]
dx = .00001;
x1 = -5*L:dx:5*L;
n = size(x1,2);
y1 = movmean(interp1(x0,y0,x1),1000000);


figure,plot(x0,y0,'o-');axis equal; hold on;
set(gca, 'YDir','reverse')
plot(x1,y1)
f = polyfit(x1,y1,6)
yf = polyval(f,x1);
plot(x1,yf);


N = 10000000;
mu = 0;
s = 2;
x = mu + s*randn(1,N);

yx = polyval(f,x);

figure,histogram(yx,1000)

py = zeros(1,N);
for i=1:N
    j = max(floor((x(i)+5*L)/dx),0) +1;
    j = min(j,n);
py(i) = y1(j);
end

figure,histogram(py,1000);

muy = sum(py)/N


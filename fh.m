function zhat = fh(x,m)


dy = m(2)-x(2);
dx = m(1)-x(1);
psi = atan2_0_2PI(dy,dx);

zhat = [sqrt( dx^2 + dy^2 ); AngleRange(psi- x(4))];


% %test function
% N = 1000000;
% r = @(x,y) sqrt(x.^2+y.^2);
% h = @(x,y) atan2(y,x);
% 
% x = 1+10*randn(1,N);
% y = 2+10*randn(1,N);
% 
% 
% figure,histogram(h(x,y)/N,1000)
% figure,histogram(r(x,y)/N,1000)
% 





function [x,ut,u] = TargetMotion(T,Q0)

T1 = 100;
T2 = 100;
Ts = T1+T2;
Fs = 1/T;
N1 = T1*Fs;
N2 = T2*Fs;
N = N1+N2 + N1/2;

%initizlize state
x0 = 0;
y0 =0;
h0 = pi/4;
v0 = 1;
w0 = 0;
x = zeros(5,N);

%maneuver parameters
v1 = 1;
R2 = 10;
w2 = pi/T2;
v2 = R2*w2;


u(1,:) = [v1*ones(1,N1) v2*ones(1,N2) v1*ones(1,N1/2)];
u(2,:) = [0*ones(1,N1) w2*ones(1,N2) 0*ones(1,N1/2)];
x(:,1) = [x0 y0 v0 h0 w0]';

ut = u + Q0*randn(2,N);
for n = 2:N
    x(:,n) = PropagateState(x(:,n-1),u(:,n),T);
end


function [xhatn,Pn] = InitFilter(u,z_psi,R,Q0,m)

for i=1:size(m,2)
h0(i) = AngleRange(atan2(m(2,i),m(1,i)) - z_psi(i,1)); 
end
h0 = mean(h0);
xhatn = [0 0 u(1,1) h0 u(2,1)]';
Pn = diag([1 1 Q0(1,1) R(1,1) Q0(2,2)]);
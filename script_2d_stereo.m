
clear;
close all;

R = @(x) [cosd(x) -sind(x);sind(x) cosd(x)];

%units mm
B = 200;

f1 = B/10;
f2 = .5*f1;
w = B/4;

C1 = B*[1/2;0];
C2 = B*[-1/2;0];

a1 = -10;
a2 = 20;
R1 =R(a1);
R2 = R(a2);

[C1end, c1 , pl1,pr1] = pcam(f1,w,C1,R1);
[C2end, c2 , pl2,pr2] = pcam(f2,w,C2,R2);


P0 = B/2*[.4;2];

P1 = R1*P0 + C1
P2 = R2*P0 + C2



%virtual measurement: take P2, convert to CF1, compare to P1
P21 = R1*(R2'*(P2-C2)) + C1 %=P1 if no noise


plot([P0(1),C1(1)],[P0(2),C1(2)],'-k');

plot([P0(1),C2(1)],[P0(2),C2(2)],'-k');
plot([C1(1),C2(1)],[C1(2),C2(2)],'-k');



function [Cend, c , pl,pr] = pcam(f,w,C,R)

c = R*[0;f] + C;
pl = R*[-w/2;f] + C;
pr = R*[w/2;f] + C;
Cend = R*[0;2*w] + C;

figure(1);
plot(C(1),C(2),'o'); grid on;hold on;axis equal;
plot([C(1),Cend(1)],[C(2),Cend(2)],'-k');
plot([pl(1),pr(1)],[pl(2),pr(2)],'-k');


end
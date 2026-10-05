

xi = [2,3]';
xj = [4,3]';

m = [5,6]';

thetai = atan2d( xi(2),xi(1))
thetaj = atan2d( xj(2),xj(1))


Psii = atan2d((m(2)-xi(2)),m(1)-xi(1))

Psij = atan2d((m(2)-xj(2)),m(1)-xj(1))

psii = Psii - thetai

psij = Psij - thetaj

R = @(x) [cosd(x) -sind(x);sind(x) cosd(x)];

Rij = R(psij-psii);
Ri = R(thetai);

y= Rij*Ri'*xi

atan2d(y(2),y(1))


thetaj-thetai+Psij
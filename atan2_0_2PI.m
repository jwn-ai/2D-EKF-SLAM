function h = atan2_0_2PI(x,y)

h = atan2(x,y);

if h < 0
    h = h + 2*pi;
end



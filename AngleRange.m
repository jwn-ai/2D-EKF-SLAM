function y = AngleRange(x)
y = x;
for i=1:length(x)
    xi = x(i);

    if xi >= 2*pi
        y(i) = xi - 2*pi;
    end
    if xi < 0
        y(i) = xi + 2*pi;
    end
end


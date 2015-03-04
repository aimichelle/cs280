function angle = anglewrap(x, y);
if (x == 0) & (y == 0)
    angle = 0;
elseif (x == 0)
    if (y > 0)
        angle = 0;
    elseif (y < 0)
        angle = pi;
    end
elseif (y == 0)
    if (x > 0)
        angle = pi/2;
    elseif (x < 0)
        angle = -pi/2;
    end
elseif (x > 0) & (y > 0)
    angle = atan(y/x);
elseif (x > 0) & (y < 0)
    angle = pi/2 + atan(-y/x);
elseif (x < 0) & (y > 0)
    angle = -pi/2 + atan(y/-x);
elseif (x < 0) & (y < 0)
    angle = -pi/2 - atan(y/x);
end
end

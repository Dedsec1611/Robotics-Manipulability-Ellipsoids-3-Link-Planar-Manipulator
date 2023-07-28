function [th] = CinematicaInversaGeometrico(x_pos,a1,a2,a3,phi)
px = x_pos(1);
py= x_pos(2);

wx = px - a3*cos(phi);
wy = py - a3*sin(phi);
c2 = (wx* wx + wy*wy  -a1*a1 -a2*a2)/(2*a1*a2);
theta2 = acos(c2);
alpha = atan2(wy,wx);
beta = acos((wx*wx + wy*wy + a1*a1 - a2*a2)/(2*a1*sqrt(wx*wx + wy*wy)));
if theta2 < 0
    theta1 = alpha + beta;
else
    theta1 = alpha - beta;
end

theta3 = phi -theta1 -theta2;

th = [theta1 theta2 theta3];

end


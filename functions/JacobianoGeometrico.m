function [J] = JacobianoGeometrico(a,q,A10,A20,A30)
p0 = [0;0;0];
p1 = [a*cos(q(1)); a*sin(q(1));0];
p2= [(a*cos(q(1))+ a*cos(q(1)+q(2)));
    (a*sin(q(1))+ a*sin(q(1)+q(2)));
    0];
p3= [(a*cos(q(1))+ a*cos(q(1)+q(2)) + a*cos(q(1)+q(2)+q(3)));
    (a*sin(q(1))+ a*sin(q(1)+q(2)) + a*sin(q(1)+q(2)+q(3)));
    0];
z0=[0;0;1];
z1 =[0;0;1];
z2 = [0;0;1];
J1 = [cross(z0,(p3-p0));z0];
J2 = [cross(z1,(p3-p1));z1];
J3 = [cross(z2,(p3-p2));z2];
JTot=[J1,J2,J3];
%%----- sola parte posizionale ----%%%
J = JTot(1:2,:);
end
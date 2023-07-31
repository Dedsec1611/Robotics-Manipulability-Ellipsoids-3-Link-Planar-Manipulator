function [theta1_1, theta2_1,theta3_1] = CinematicaInversaAnalitico(a1,a2,a3,x_pos,phi)
px = x_pos(1);
py = x_pos(2);
wx = px - a3*cos(phi);
wy = py - a3*sin(phi);
c2 = (wx^2 + wy^2 - a1^2 -a2^2)/ (2*a1*a2);

if c2 <= 1 
    s2_1 = sqrt(1-c2^2);
    s2_2 = - sqrt(1-c2^2);
    theta2_1 = atan2(s2_1,c2);
    theta2_2 = atan2(s2_2,c2);
    denom_1 = a1^2 + a2^2 + 2*a1*a2*cos(theta2_1);
    denom_2 = a1^2 + a2^2 + 2*a1*a2*cos(theta2_2);
    s1_1 = (wy*(a1+a2*cos(theta2_1)) -a2*sin(theta2_1)*wx)/denom_1;
    s1_2 = (wy*(a1+a2*cos(theta2_2)) -a2*sin(theta2_2)*wx)/denom_2;
    c1_1 = (wx*(a1+a2*cos(theta2_1))+ a2*sin(theta2_1)*wy)/denom_1;
    c1_2 = (wx*(a1+a2*cos(theta2_2))+ a2*sin(theta2_2)*wy)/denom_2;
    theta1_1 = atan2(s1_1,c1_1); %Prima soluzione
    theta1_2 = atan2(s1_2,c1_2); %Seconda soluzione
    theta3_1 = phi -theta1_1 - theta2_1;
    theta3_2 = phi -theta1_2 - theta2_2;
end
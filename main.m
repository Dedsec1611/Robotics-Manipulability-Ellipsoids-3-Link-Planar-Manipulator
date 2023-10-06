%% Path
current_path = genpath(pwd);
addpath(current_path);
close all; clear; clc;

%% Starting configuration manipulator
a = 1;
ti = 0;
tf = 5;
delta_t = 0.4;

%% Start point
theta1_deg = 90; 
theta2_deg = 90;
theta3_deg = -90; 
theta1_rad = deg2rad(theta1_deg);
theta2_rad = deg2rad(theta2_deg);
theta3_rad = deg2rad(theta3_deg);
q=[theta1_rad,theta2_rad,theta3_rad];

%% Final point
theta1_deg = 0; 
theta2_deg = 0;
theta3_deg = 0;
theta1_rad = deg2rad(theta1_deg);
theta2_rad = deg2rad(theta2_deg);
theta3_rad = deg2rad(theta3_deg);
q2=[theta1_rad,theta2_rad,theta3_rad];

%% Direct  Kinematic - Starting point 
[A10, A20,A30,A40] = CinematicaDiretta(a,q);
x_pos1 = [A40(1,4),A40(2,4)];

%% Direct  Kinematic - Arrival point 
[A10, A20,A30,A40] = CinematicaDiretta(a,q2);
x_pos2 = [A40(1,4),A40(2,4)];

%% Temp variables
q_grafico = [];
q_der_grafico =[];
pos_e = [];
manip =  [];
x_pos = x_pos1;

%% Trajectory configuration
mat_uno =  pinv([tf^3,tf^2;3*tf^2,2*tf]);
mat_due = [q2-q;0,0,0];
a32 = mat_uno*mat_due;
a3 = a32(1,:);
a2 = a32(2,:);
a0 = q;
a1 = 0;

for t = ti : delta_t : tf
     %% Trajectory calculation
    q_tra = a3*t^3 + a2*t^2 +a1*t+ a0;
    q_der_tra = 3*a3*t^2 +2*a2*t+a1;
    q_der_grafico =[q_der_grafico;q_der_tra];
    q_grafico = [q_grafico;q_tra];
    [A10, A20,A30,A40] = CinematicaDiretta(a,q_tra);
    x_pos = [A40(1,4),A40(2,4)];
    pos_e=[pos_e;x_pos];
    [J] = JacobianoGeometrico(a,q_tra);
    Jinv = pinv(J);
 
    %% Chart 
    plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',8)
    hold on
    plot([0,a*cos(q_tra(1)),a*cos(q_tra(2)+q_tra(1))+a*cos(q_tra(1)),x_pos(1)],[0,a*sin(q_tra(1)),a*sin(q_tra(2)+q_tra(1))+a*sin(q_tra(1)),x_pos(2)],'r-o','linewidth',1.5,'MarkerfaceColor','r','MarkerSize',5)
    plot(x_pos(1),x_pos(2),'+')

    %% Velocity ellipsoid
    %% Eigenvalue calculation-> Axis dir
    %% ----- positional part only ----%%%
    J_pos = J(1:2,:);
    [V,D] = eig(J_pos*J_pos');
    t1 = atan2(V(2,2),V(1,2));
    %% Axis lenght
    ev = eig(J_pos*J_pos');
    xe = sqrt(max(abs(ev)));
    ye = sqrt(min(abs(ev)));
    aa = [cos(t1), -sin(t1); sin(t1), cos(t1)]* [xe*cosd(0:360)/ xe; ye*sind(0:360)/xe];
    plot(x_pos(1)+aa(1,:), x_pos(2)+aa(2,:),'b-');


    %% Manipulability
    J_map =[J_pos;1,1,1];
    sigma = sqrt(det(J_map*J_map'));
    manip = [manip;sigma];

    hold off
    grid on
    axis square
    pause(0.5)
end



%% Charts data
t=ti:delta_t:tf;

figure
hold on; 
plot( t, q_grafico(:,1), 'r', 'LineWidth', 4);
plot( t, q_grafico(:,2), 'g', 'LineWidth', 2);
plot( t, q_grafico(:,3), 'b', 'LineWidth', 2);
title('Position of joints: q1,q2,q3')
legend('q1', 'q2','q3');
xlabel('[s]')
ylabel('[rad]')
grid on
axis square
hold on;

figure
hold on; 
plot( t, q_der_grafico(:,1), 'r', 'LineWidth', 4);
plot( t, q_der_grafico(:,2), 'g', 'LineWidth', 2);
plot( t, q_der_grafico(:,3), 'b', 'LineWidth', 2);
title('Velocity of joints: q1,q2,q3')
legend('q1', 'q2','q3');
xlabel('[s]')
ylabel('[rad/s]')
grid on
axis square
hold on;


f = figure;
hold on; 
plot( pos_e(:,1), pos_e(:,2), 'x');
title('Position e')
xlabel('x')
ylabel('y')
grid on
axis square
hold on;


figure
hold on; 
plot( t,manip, 'r', 'LineWidth', 4);
title('Manipulability')
xlabel('[s]')
ylabel('[rad]')
grid on
axis square
hold on;





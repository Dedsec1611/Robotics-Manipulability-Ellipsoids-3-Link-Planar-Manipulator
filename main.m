%% Path
current_path = genpath(pwd);
addpath(current_path);
close all; clear; clc;

%% Starting configuration manipulator
a = 1;
ti = 0;
tf = 5;
delta_t = 0.5;

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

%% Velocity and Accelleration starting - final
q_der_init = [0,0,0];
q_der_final = [0,0,0];
q_der2_init =[0,0,0];
q_der2_final = [0,0,0];

%% Direct  Kinematic - Starting point 
[A10, A20,A30,A40] = CinematicaDiretta(a,q);
x_pos1 = [A40(1,4),A40(2,4)];

%% Direct  Kinematic - Arrival point 
[A10, A20,A30,A40] = CinematicaDiretta(a,q2);
x_pos2 = [A40(1,4),A40(2,4)];

%% Temp variables
q_grafico = [];
q_der_grafico =[];
q_der2_grafico =[];
pos_e = [];
manip =  [];
x_pos = x_pos1;

%% Trajectory configuration
mat_uno =  pinv([tf^5,tf^4, tf^3; 
                 5*tf^4, 4*tf^3, 3*tf^2; 
                 20*tf^3,12*tf^2, 6*tf]);
mat_due = [q2-q - (q_der2_final/2)* tf^2 - q_der_init*tf;
           q_der_final - q_der2_init*tf - q_der_init;
           q_der2_final - q_der2_init;];
a543 = mat_uno*mat_due;
a5 = a543(1,:)
a4 = a543(2,:)
a3 = a543(3,:)
a0 = q;
a1 = 0;
a2=0;

for t = ti : delta_t : tf
    %% Trajectory calculation
    q_tra = a5*t^5+a4*t^4+ a3*t^3 + a2*t^2 +a1*t+ a0;
    q_der_tra =5*a5*t^4+ 4*a4*t^3+ 3*a3*t^2 +2*a2*t+a1;
    q_der2_tra = 20*a5*t^3 + 12*a4*t^2 +6*a3*t +2*a2;

    q_der2_grafico =[q_der2_grafico; q_der2_tra];
    q_der_grafico =[q_der_grafico;q_der_tra];
    q_grafico = [q_grafico;q_tra];
    [A10, A20,A30,A40] = CinematicaDiretta(a,q_tra);
    x_pos = [A40(1,4),A40(2,4)];
    pos_e=[pos_e;x_pos];
    [J] = JacobianoGeometrico(a,q_tra);
    J_pos = J(1:2,:);
    Jinv = pinv(J_pos);
 
    %% Chart 
    %% plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',8)
    hold on
    plot([0,a*cos(q_tra(1)),a*cos(q_tra(2)+q_tra(1))+a*cos(q_tra(1)),x_pos(1)],[0,a*sin(q_tra(1)),a*sin(q_tra(2)+q_tra(1))+a*sin(q_tra(1)),x_pos(2)],'r-o','linewidth',1.5,'MarkerfaceColor','r','MarkerSize',5)
    plot(x_pos(1),x_pos(2),'+')

    %% Velocity ellipsoid
    %% Eigenvalue calculation-> Axis dir
    %% ----- positional part only ----%%%
    
    [V,D] = eig(J_pos*J_pos');
    t1 = atan2(V(2,2),V(1,2));

    %% Axis lenght
    ev = eig(J_pos*J_pos');
    xe = sqrt(max(abs(ev)));
    ye = sqrt(min(abs(ev)));
    aa = [cos(t1), -sin(t1); sin(t1), cos(t1)]* [xe*cosd(0:360)/ xe; ye*sind(0:360)/xe];
    plot(x_pos(1)+aa(1,:), x_pos(2)+aa(2,:),'b-');


    %% Manipulability
    sigma = sqrt(det(J_pos*J_pos'));
    manip = [manip;sigma]

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

figure
hold on; 
plot( t, q_der2_grafico(:,1), 'r', 'LineWidth', 4);
plot( t, q_der2_grafico(:,2), 'g', 'LineWidth', 2);
plot( t, q_der2_grafico(:,3), 'b', 'LineWidth', 2);
title('Acceleration of joints: q1,q2,q3')
legend('q1', 'q2','q3');
xlabel('[s]')
ylabel('[rad/s^2]')
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





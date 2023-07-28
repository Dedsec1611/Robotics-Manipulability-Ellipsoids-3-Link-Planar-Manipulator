close all; clear all; clc;

%%---- Configurazione iniziale manipolatore ---%%
a = 1;
I = eye(4,4);
%% PUNTO INIZIALE
theta1_deg = 90; 
theta2_deg = 90;
theta3_deg = -90;
theta1_rad = deg2rad(theta1_deg);
theta2_rad = deg2rad(theta2_deg);
theta3_rad = deg2rad(theta3_deg);
q=[theta1_rad,theta2_rad,theta3_rad];

%% PUNTO FINALE
theta1_deg = 0; 
theta2_deg = 0;
theta3_deg = 0;
theta1_rad = deg2rad(theta1_deg);
theta2_rad = deg2rad(theta2_deg);
theta3_rad = deg2rad(theta3_deg);
q2=[theta1_rad,theta2_rad,theta3_rad];

%% CONFIGURAZIONE TRAIETTORIA
ti = 0;
tf=5;
delta_t = 0.4;
k = [1,0;
    0,1];

[A10, A20,A30,A40] = CinematicaDiretta(a,q);
x_pos1 = [A40(1,4),A40(2,4)];
x_pos = x_pos1;
[J] = JacobianoGeometrico(a,q,A10,A20,A30);
Jinv = pinv(J);

[A10, A20,A30,A40] = CinematicaDiretta(a,q2);
x_pos2 = [A40(1,4),A40(2,4)];

errori=[];
for t = ti : delta_t : tf

Pe = x_pos1 + ((-2*(t^3) +15*(t^2))/125)*(x_pos2-x_pos1);
Pe_der = (-(6/125)*(t^2) + (6/25)*t) * (x_pos2-x_pos1);
errore = Pe - x_pos
errori = [errori;errore];
q_der = Jinv *( (Pe_der') + k*errore');
q = q + (q_der * delta_t)';
[A10, A20,A30,A40] = CinematicaDiretta(a,q);
x_pos = [A40(1,4),A40(2,4)];
[J] = JacobianoGeometrico(a,q,A10,A20,A30);
Jinv = pinv(J);

plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',8)
hold on
plot([0,a*cos(q(1)),a*cos(q(2)+q(1))+a*cos(q(1)),x_pos(1)],[0,a*sin(q(1)),a*sin(q(2)+q(1))+a*sin(q(1)),x_pos(2)],'r-o','linewidth',1.5,'MarkerfaceColor','r','MarkerSize',5)
plot(Pe(1),Pe(2),'o')
plot(x_pos(1),x_pos(2),'+')

%% Ellissoide velocita
[V,D] = eig(J*J');
ev = eig(J*J');
t1 = atan2(V(2,2),V(1,2));
xe = sqrt(max(abs(ev)));
ye = sqrt(min(abs(ev)));
aa = [cos(t1), -sin(t1); sin(t1), cos(t1)]* [xe*cosd(0:360)/ xe; ye*sind(0:360)/xe];
%%plot(x_pos(1)+aa(1,:), x_pos(2)+aa(2,:),'b-');


hold off
grid on
axis square
pause(1)

end



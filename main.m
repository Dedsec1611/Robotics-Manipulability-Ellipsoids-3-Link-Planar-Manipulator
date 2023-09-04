%% Path
current_path = genpath(pwd);
addpath(current_path);
close all; clear; clc;

%% Configurazione iniziale manipolatore
a = 1;
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
%% CINEMATICA DIRETTA PUNTO DI PARTENZA
[A10, A20,A30,A40] = CinematicaDiretta(a,q);
x_pos1 = [A40(1,4),A40(2,4)]
%% CINEMATICA DIFFERENZIALE
[J] = JacobianoGeometrico(a,q,A10,A20,A30);
Jinv = pinv(J);
%% CINEMATICA DIRETTA PUNTO DI ARRIVO
[A10, A20,A30,A40] = CinematicaDiretta(a,q2);
x_pos2 = [A40(1,4),A40(2,4)]

%% VARIABILI DI APPOGGIO
errori=[];
q_appoggio = q;
x_pos = x_pos1;
[J] = JacobianoGeometrico(a,q_appoggio,A10,A20,A30);
Jinv = pinv(J);
%% CONFIGURAZIONE TRAIETTORIA
ti = 0;
tf = 5;
delta_t = 0.4;
k = [4,0;
     0, 4];
for t = ti : delta_t : tf
    %% CALCOLO DELLA TRAIETTORIA
    Px = -1 + (60/125)*t^2 - (8/125)*t^3;
    Py = 2 +(4/125)*t^3 - (30/125)*t^2;
    Pe =[Px,Py];

    Pe_derx =  (-24/125)*t^2 + (120/125)*t;
    Pe_dery =  (12/125)*(t^2) - (60/125)*t ;
    Pe_der = [Pe_derx,Pe_dery];

    errore = Pe - x_pos;
    errori = [errori;errore];
    q_der = Jinv * ((Pe_der') + (k*errore'));
    q_appoggio = q_appoggio + (q_der * delta_t)';

    [A10, A20,A30,A40] = CinematicaDiretta(a,q_appoggio);
    x_pos = [A40(1,4),A40(2,4)];
    [J] = JacobianoGeometrico(a,q_appoggio,A10,A20,A30);
    Jinv = pinv(J);
    
    %% GRAFICHIAMO
    plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',8)
    hold on
    plot([0,a*cos(q_appoggio(1)),a*cos(q_appoggio(2)+q_appoggio(1))+a*cos(q_appoggio(1)),x_pos(1)],[0,a*sin(q_appoggio(1)),a*sin(q_appoggio(2)+q_appoggio(1))+a*sin(q_appoggio(1)),x_pos(2)],'r-o','linewidth',1.5,'MarkerfaceColor','r','MarkerSize',5)
    plot(Pe(1),Pe(2),'o')
    plot(x_pos(1),x_pos(2),'+')

    %% Elissoide velocita
    [V,D] = eig(J*J');
    ev = eig(J*J');
    t1 = atan2(V(2,2),V(1,2));
    xe = sqrt(max(abs(ev)));
    ye = sqrt(min(abs(ev)));
    aa = [cos(t1), -sin(t1); sin(t1), cos(t1)]* [xe*cosd(0:360)/ xe; ye*sind(0:360)/xe];
    plot(x_pos(1)+aa(1,:), x_pos(2)+aa(2,:),'b-');
    

    %%MANIPOLABILITA
  


    hold off
    grid on
    axis square
    pause(1)
end

errori



function [A10, A20,A30,A40] = CinematicaDiretta(a,q)
%%---------- a => lunghezza dei bracci --------------- %%
A10 = [cos(q(1)), -sin(q(1)), 0, a*cos(q(1));
       sin(q(1)), cos(q(1)), 0 , a*sin(q(1));
       0,0,1,0;
       0,0,0,1];
A21 = [cos(q(2)), -sin(q(2)), 0, a*cos(q(2));
    sin(q(2)), cos(q(2)), 0 , a*sin(q(2));
    0,0,1,0;
    0,0,0,1];
A20 = A10*A21;
A32 = [cos(q(3)), -sin(q(3)), 0, a*cos(q(3));
    sin(q(3)), cos(q(3)), 0 , a*sin(q(3));
    0,0,1,0;
    0,0,0,1];
A30 =  A20*A32;
A43 =[0,0,1,0; 
    0,1,0,0;
    -1,0,0,0;
    0,0,0,1];
A40 = A30*A43;
end
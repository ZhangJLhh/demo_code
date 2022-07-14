function [ xkf,P ] = Standard( P_last,x_current_last,Ob,G_U_p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function of Demo1 & Demo2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s_d = 1;               
Q = ( 1 - s_d ) / s_d;
A=1;
C=1;
I=eye(1);
x_pre = x_current_last;                    
p_pre = P_last  + Q;                  
Kg = p_pre / ( p_pre + G_U_p );        
xkf = x_pre + Kg * ( Ob - x_pre );
P = ( I - Kg ) * G_U_p;  
 
end
 
 
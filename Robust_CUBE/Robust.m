function [ R_xx,Dx ] = Robust( P_last,x_last,Ob,G_U_p )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function of Demo1 & Demo2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B = 1;                 
F = 1;                               
Tk = 1;                            
Dk = 0;
Z = 0;                  
Dl = G_U_p;             

[n,m] = size(B);    
X_ = F * x_last;           
Dx_ = F * P_last * inv(F) + Tk * Dk * Tk';    

P = inv(Dl);               
Px_ = pinv(Dx_);            
P_ = P;

BTmp = [eye(m);B];
PTmp = [Px_ 0;0 P];
mv = zeros(n,1);
for j=1:n              
    mv(j) = 1*sqrt(1/P(j,j)+1/Px_); 
end

X_pr = 10000000*ones(m,1);
while 1
    
   J = Dx_*B'*inv(B*Dx_*B'+inv(P_+0.00001*eye(n)));            
   X = X_ - J * ( B*X_ + Z - Ob );        
   Dx = Dx_ - J * B * Dx_;                        
   
   V = B*X - Ob;                                    
   Vx = X - X_;                              
   
   temV = V;
   for i=1:n
       if(P_(i,i) == 0)
           temV(i) = 0;
       end
   end
   
   dx = X_pr - X;
   X_pr = X;                  
   if(sqrt(dx'*dx) < 1E-10)
       break;
   end
   
   for k=1:n 
       Mod_V = abs(V(k)/mv(k));       
       Mod_MaxV = max(abs(V./mv));
       if(Mod_V == Mod_MaxV)
          P_(k,k) = P(k,k)*Wi(Mod_V);         
          break;
       end
   end
       
end

R_xx = X;

function w = Wi(Mod_V)
   d = (1.5-Mod_V) / (2.5-1.5);
   if(Mod_V <= 1.5)
       w = 1;
   elseif(Mod_V > 1.5 && Mod_V < 2.5) 
       w = (1.5/Mod_V)*d*d;
   else
       w = 1e-3;
   end
end

end
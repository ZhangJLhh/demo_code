function [ Es_d,Ab ] = Robust_Es(Ide,...
                    ii,S_point,Sort,...
                    Bn,he,L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function of Demo1 & Demo2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Es_d = [Sort(1,:),Ide];   
Ab = [];                    
P_l = [];
for i = 2:1:S_point    
    
   n_Esd = size( Es_d,1 );     
   d_all = [];
   d_s = [];
   for j=1:1:n_Esd                   
       d = Sort(i,10) - Es_d(j,10); 
       d = [j,d];                                        
       d_all = [d_all;d];
   end
   d_s = abs(d_all);
   d_s = sortrows(d_s,2);
   O_d_a = d_s(1,:);       
   De = sqrt( O_d_a(1,2)^2 + Sort(i,6)^2 ); % 分母
   en = O_d_a(1,2) / De;

   if ( en >= 0 )
       X = ( he^2 - 2 * he * en ) / 2;
       Bn = exp(X);
   else
       X = ( he^2 + 2 * he * en ) / 2;
       Bn = exp(X);
   end

   if ( Bn >= Bn )      
       if (( ii >= L))
           Ide = Ide + 1;
           E_d_n = [Sort(i,:),Ide];
           Es_d = [Es_d;E_d_n];
           ii = 0;      
       else    
           Ab_t = [Sort(i,:),O_d_a(1,1)];
           Ab = [Ab;Ab_t];
           ii = ii + 1;

           if ( isempty ( P_l ) )         
              P_l = O_d_a(1,2)^2;
              aa = O_d_a(1,1);
              x_l = Es_d(aa,10);   
              Ob = Ab_t(1,10);
              G_U_p = Ab_t(1,9);
              [ xx,P ] = Robust( P_l,x_l,Ob,G_U_p );  
              Es_d(aa,10) = xx;
              P_l = P;
           else
              aa = O_d_a(1,1);
              x_l = Es_d(aa,10);   
              Ob = Ab_t(1,10);
              G_U_p = Ab_t(1,9);
              [ xx,P ] = Robust( P_l,x_l,Ob,G_U_p );
              Es_d(aa,10) = xx;
              P_l = P;
           end
       end
       
   else     
      
       Ide = Ide + 1;
       E_d_n = [Sort(i,:),Ide];
       Es_d = [Es_d;E_d_n];
       ii = 0;
       
   end
    
end

end
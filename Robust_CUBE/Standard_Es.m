function [ Es_d,Ab ] = Standard_Es(Ide,...
                    ii,S_point,Sort,...
                    Bn_threshold,he,L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function of Demo1 & Demo2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Es_d = [Sort(1,:),Ide];   
Ab = [];                  
P_last = [];
for i = 2:1:S_point    
    
   Es_d_num = size( Es_d,1 );     
   d_all = [];
   d_sort = [];
   for j=1:1:Es_d_num                   
       d = Sort(i,10) - Es_d(j,10); 
       d = [j,d];                                       
       d_all = [d_all;d];
   end
   d_sort = abs(d_all);
   d_sort = sortrows(d_sort,2);
   O_ds = d_sort(1,:);       
   De = sqrt( O_ds(1,2)^2 + Sort(i,6)^2 ); % 分母
   en = O_ds(1,2) / De;

   if ( en >= 0 )
       X = ( he^2 - 2 * he * en ) / 2;
       Bn = exp(X);
   else
       X = ( he^2 + 2 * he * en ) / 2;
       Bn = exp(X);
   end
   
   if ( Bn >= Bn_threshold )      

       if (( ii >= L)) 
           Ide = Ide + 1;
           aa = [Sort(i,:),Ide];
           Es_d = [Es_d;aa];
           ii = 0;      
       else    
           Ab_t = [Sort(i,:),O_ds(1,1)];
           Ab = [Ab;Ab_t];
           ii = ii + 1;
           
           if ( isempty ( P_last ) )         
              P_last = O_ds(1,2)^2;
              Es_index = O_ds(1,1);
              xx = Es_d(Es_index,10);   
              Ob = Ab_t(1,10);
              gg = Ab_t(1,9);
              [ x_current,P ] = Standard( P_last,xx,Ob,gg) ;
              Es_d(Es_index,10) = x_current;
              P_last = P;
           else
              Es_index = O_ds(1,1);
              xx = Es_d(Es_index,10);  
              Ob = Ab_t(1,10);
              gg = Ab_t(1,9);
              [ x_current,P ] = Standard( P_last,xx,Ob,gg) ;
              Es_d(Es_index,10) = x_current;
              P_last = P;
           end
       end
       
   else      
      
       Ide = Ide + 1;
       aa = [Sort(i,:),Ide];
       Es_d = [Es_d;aa];
       ii = 0;
       
   end
    
end

end
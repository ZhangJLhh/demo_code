function [Es_d] = st_of_Es_d(Es_d,Absorbed,n_point,i_zong,j_zong)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function of Demo1 & Demo2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

logical_n_p = isempty(n_point);
switch(logical_n_p)     
    
    case{1}        
        
        switch( size( Es_d,1 ) )
            
            case{1}      
                n_Absorbed = size(Absorbed,1);
                Es_d = [Es_d,n_Absorbed,6];            
            otherwise   
                ii = 1;
                scan_Es_d_flag = 1;
                number_all = [];
                while( scan_Es_d_flag )
                   index_of_Es_d = Es_d(ii,11);   
                   if ( isempty(find( Absorbed(:,11) == index_of_Es_d )) )
                       Es_d(ii,:) = [];    
                   else
                       index_of_Es_d = Es_d(ii,11);
                       s_point_i = find( Absorbed(:,11) == index_of_Es_d );
                       s_point_n = size(s_point_i,1);
                       number_all = [number_all;s_point_n];   
                       ii = ii + 1;
                   end
                   
                   if ( ii > size( Es_d,1 ) )
                       scan_Es_d_flag = 0;
                   end
                end
                
                Es_d = [Es_d,number_all];    
                
                Es_d = sortrows( Es_d,12,'descend');
                number_of_Es_d = size( Es_d,1 );
                st_Es_d = [];    
                
                switch( number_of_Es_d )
                    case {1}         
                        n_Absorbed = size(Absorbed,1);
                        Es_d = [Es_d,6];            
                    otherwise     
                        for i = 1:1:number_of_Es_d-1
                           index_of_Es_d = Es_d(i,11);
                           Next_index_of_Es_d = Es_d(i+1,11);
                           current_s_point_n = find( Absorbed(:,11) == index_of_Es_d );
                           next_s_point_n = find( Absorbed(:,11) == Next_index_of_Es_d );
                           ss = 5 - ( size(current_s_point_n,1) / size( next_s_point_n,1) );
                           ss1 = [index_of_Es_d,ss];      
                           st_Es_d = [st_Es_d;ss1];
                        end
                        s_extend = [Next_index_of_Es_d,5.1];   
                        st_Es_d = [st_Es_d;s_extend];   
                        Es_d = [Es_d,st_Es_d(:,2)]; 
                end
                
        end
        
    case{0}       
        
        Es_d = zeros( 1,13 );               
        Es_d(1,1) = i_zong;                  
        Es_d(1,2) = j_zong;
        Es_d(1,10) = n_point;
        Es_d(1,13) = 7;                      
        
end

end
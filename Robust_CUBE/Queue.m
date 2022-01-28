function [ sorted_U_p_c ] = Queue(q,U_p_c,S_point)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function of Demo1 & Demo2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sorted_U_p_c = [];         
logical_S = size(U_p_c,1) >= q;

switch(logical_S)  
    case{1}    
        
        Quene = U_p_c(1:q,:);  
        sorted_U_p_c = [];        
        
        switch( S_point )   
            case {q}   
                Quene = sortrows(Quene,10);       
                sorted_U_p_c = [sorted_U_p_c;Quene(5,:);Quene(4,:);Quene(6,:);Quene(3,:);Quene(7,:);Quene(2,:);Quene(8,:);Quene(1,:);Quene(9,:)];
            otherwise      
                for i = q+1:1:S_point
                    Quene = sortrows(Quene,10);       
                    middle_value = Quene(5,:);       
                    sorted_U_p_c = [sorted_U_p_c;middle_value];  
                    Quene(5,:) = U_p_c(i,:);   
                end

                if (i == S_point)
                   sorted_U_p_c = [sorted_U_p_c;Quene(5,:);Quene(4,:);Quene(6,:);Quene(3,:);Quene(7,:);Quene(2,:);Quene(8,:);Quene(1,:);Quene(9,:)]; 
                end
            
        end
        
    case{0}  
        
        Quene = U_p_c;  
        sorted_U_p_c = [];         
        
        switch( S_point )  
           
            case {8}
                sorted_U_p_c = [sorted_U_p_c;Quene(4,:);Quene(5,:);Quene(3,:);Quene(6,:);Quene(2,:);Quene(7,:);Quene(1,:);Quene(8,:)]; 
            case {7}
                sorted_U_p_c = [sorted_U_p_c;Quene(4,:);Quene(3,:);Quene(5,:);Quene(2,:);Quene(6,:);Quene(1,:);Quene(7,:)]; 
            case {6}
                sorted_U_p_c = [sorted_U_p_c;Quene(3,:);Quene(4,:);Quene(2,:);Quene(5,:);Quene(1,:);Quene(6,:)]; 
            case {5}
                sorted_U_p_c = [sorted_U_p_c;Quene(3,:);Quene(2,:);Quene(4,:);Quene(1,:);Quene(5,:)];
            case {4}
                sorted_U_p_c = [sorted_U_p_c;Quene(2,:);Quene(3,:);Quene(1,:);Quene(4,:)];
            case {3}
                sorted_U_p_c = [sorted_U_p_c;Quene(2,:);Quene(1,:);Quene(3,:)];
            case {2}
                sorted_U_p_c = [sorted_U_p_c;Quene(1,:);Quene(2,:)];
            
        end
        
end

end
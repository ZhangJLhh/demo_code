function [ O_b_h ]= Se_o_Es(c,Es_d,O_b_h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function of Demo1 & Demo2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sed_Es_d = [];
n_Es_d = size( Es_d,1 );

switch( n_Es_d )
    
    case{1}     
        O_b_h = [O_b_h;Es_d];
    otherwise     
        index_Sed_Es_d = find( Es_d(:,13) < c );   
        if ( ~ isempty( index_Sed_Es_d ) )  
            Sed_Es_d = Es_d(index_Sed_Es_d,:);
            Sed_Es_d = sortrows( Sed_Es_d,13);   
            O_b_h = [O_b_h;Sed_Es_d(1,:)];
        else       
            O_b_h = [O_b_h;Es_d(1,:)];      
        end
end

end

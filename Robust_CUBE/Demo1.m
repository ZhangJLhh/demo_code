%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Code Author: Zhang Jiali
%  Institute: Tianjin University
%  Date: 2022.04.25
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all

load('Data1.mat');
load('EstimatedNodeDepth.mat');

U_p = Data1;
[row,col] = size( EstimatedNodeDepth );    % Size of artificial seafloor
O_b_h = [];                                % Store the optimal bathymetric hypotheses

tic
for i_index = 1 : 1 : row
    for j_index = 1 : 1 : col
        index1 = find( U_p(:,1) == i_index );
        temporary = U_p(index1,:);
        index2 = find( temporary(:,2) == j_index );
        U_p_c = temporary(index2,:);
        n_point = [];
        q = 9; 
        
        switch(size(U_p_c,1))
            
            case{0}  
                
                n_point = EstimatedNodeDepth( i_index, j_index );  
                Absorbed = [];
                
            case{1}   
                
                Ide = 1;        
                Sort = [];         
                Sort = U_p_c;
                Es_d = [Sort,Ide];
                Absorbed = Es_d;
                
            otherwise    
                
                S_point = size(U_p_c,1);   
                Sort = Queue(q,U_p_c,S_point);
                
                Ide = 1;        
                ii = 0;
                Bn = 0.3;          
                he = 1.2;       
                L = 5;         
                
                [Es_d,Absorbed] = Robust_Es(Ide,...
                    ii,S_point,Sort,...
                    Bn,he,L);
                
        end
        
        Es_d = st_of_Es_d(Es_d,Absorbed,n_point,i_index,j_index);
        c = 2;       
        O_b_h = Se_o_Es(c,Es_d,O_b_h);
        
    end
end
toc

% Bathymetric hypotheses to plot

col_index = [1,2,10];
B_h = O_b_h(:,10);          
B_h = reshape(B_h,[col row]);
B_h = B_h';

x = 1 : 1 : row;
y = 1 : 1 : col;
[X,Y]=meshgrid(x,y);

figure
surf(X,Y,B_h);
colormap jet;
set(gca,'ZDir','reverse')
set(gca,'FontSize',15)
xlabel('X(m)'),ylabel('Y(m)'),zlabel('Depth(m)')
alpha(.9)
shading interp
axis tight;
set(findobj(gca,'type','surface'),'FaceLighting','phong','AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',200);
h = colorbar; 
set(h,'FontSize',13);
h = colorbar; 
t = get(h,'YTickLabel');
t = strcat(t,'m');
set(h,'YTickLabel',t);
set(h,'Direction','reverse');
title('Robust CUBE');

figure
mesh(X,Y,B_h);
colormap jet;
set(gca,'ZDir','reverse')%对Y方向反转
set(gca,'FontSize',15)
xlabel('X(m)'),ylabel('Y(m)'),zlabel('Depth(m)')
alpha(.9)
shading interp
axis tight;
set(findobj(gca,'type','surface'),'FaceLighting','phong','AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',200);
h = colorbar; 
set(h,'FontSize',13);
t = get(h,'YTickLabel');
t = strcat(t,'m');
set(h,'YTickLabel',t);
set(h,'Direction','reverse');
title('Robust CUBE');



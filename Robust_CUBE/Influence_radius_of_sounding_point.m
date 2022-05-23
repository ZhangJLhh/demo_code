%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Code Author: Zhang Jiali
%  Institute: Tianjin University
%  Date: 2022.04.25
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

load('Sounding.mat');
load('Spital_outliers.mat');

figure
subplot(1,1,1)
scatter3(Sounding(:,1),Sounding(:,2),Sounding(:,3),'filled');
xlabel('X(m)'),ylabel('Y(m)'),zlabel('Depth(m)')
set(gca,'ZDir','reverse')
set(gca,'FontSize',15)
hold on
scatter3(Sounding(Spital_outliers(:,1),1),Sounding(Spital_outliers(:,1),2),Spital_outliers(:,2),'r','filled');
set(gca,'ZDir','reverse')

%%%%%%%%%%%%%%%%%%%%%%% Influence radius of sounding points
res = 1;                % Grid resolution
                        
a = 0.5;                % Order 1a
b = 0.013;
DistExp = 2;            % User defined parameters, here we use the default value
xx1 = Sounding(:,1);
yy1 = Sounding(:,2);
vertU1 = Sounding(:,4);       % TVU
posionU1 = Sounding(:,5);       % THU
depth1 = Sounding(:,3);

sigma_vertMax_square = ( a^2 + ( b .* depth1 ).^2 ) / 1.96^2;
vertU_square = vertU1 .^2;
sigma_square_divide = sigma_vertMax_square ./ vertU_square;

zz = find( sigma_square_divide <1 );
nn = size(zz,1);
j = 0;
jj = zeros(nn,1);
for i = 1:1:length(sigma_square_divide)
    if ( sigma_square_divide(i) < 1 )
        j=j+1;
        jj(j) = i;
    end
end

xx1(jj) = [];
yy1(jj) = [];
depth1(jj) = [];
vertU1(jj) = [];
posionU1(jj) = [];

sigma_vertMax_square = ( a^2 + ( b .* depth1 ).^2 ) / 1.96^2;
vertU_square = vertU1 .^2;
sigma_square_divide = sigma_vertMax_square ./ vertU_square;
sigma_square_divide_DistExp = ( sigma_square_divide - 1 ) .^ ( 1/DistExp );
r = ( res * sigma_square_divide_DistExp ) - 2.962 .* posionU1;

xx2 = xx1;
yy2 = yy1;
depth2 = depth1;
vertU2 = vertU1;
posionU2 = posionU1;

aa = find ( r < res );
xx2(aa) = [];                         
yy2(aa) = [];                         
depth2(aa) = [];
vertU2(aa) = [];
posionU2(aa) = [];
r(aa) = [];

r_max = 2.925 * posionU2;
for i_r = 1:1:size( posionU2,1 )  
    if ( r(i_r) > r_max(i_r) )
        r(i_r) = r_max(i_r);
    end 
end

data = [xx2,yy2,depth2,r];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Residual_index = [];
for kk = 1 : 1 : size( Spital_outliers,1 )
    aa = find( data(:,3) == Spital_outliers(kk,2));
   if ( aa )
       Residual_index = [Residual_index;aa];
   end
end
Residual_Spital_outliers = data(Residual_index,3);

figure
scatter3(data(:,1),data(:,2),data(:,3),'filled');
xlabel('X(m)'),ylabel('Y(m)'),zlabel('Depth(m)');
set(gca,'ZDir','reverse')
set(gca,'FontSize',15)
hold on
scatter3(data(Residual_index,1),data(Residual_index,2),Residual_Spital_outliers,'r','filled');
set(gca,'ZDir','reverse')






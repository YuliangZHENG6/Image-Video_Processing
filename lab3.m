% Image and Video Processing
% Lab 3: Edge and contour detection
% Author: Yuliang Zheng, Valentine Ghislaine Gilda Santarelli 
% Nov.2016 
clc;
clear all;
close all;

addpath('...');
% input the two images
Imag1 = imread('lena.png');
Imag2 = imread('rice.png');
Imag3 = imread('road.png');

[row1, col1] = size(Imag1);
[row2, col2] = size(Imag2);
[row3, col3] = size(Imag2);

Imag1_5 = imnoise(Imag1,'gaussian',0,(5/255).^2);
Imag1_11 = imnoise(Imag1,'gaussian',0,(11/255).^2);
Imag1_25 = imnoise(Imag1,'gaussian',0,(25/255).^2);

Imag2_5 = imnoise(Imag2,'gaussian',0,(5/255).^2);
Imag2_11 = imnoise(Imag2,'gaussian',0,(11/255).^2);
Imag2_25 = imnoise(Imag2,'gaussian',0,(25/255).^2);

Imag3_5 = imnoise(Imag3,'gaussian',0,(5/255).^2);
Imag3_11 = imnoise(Imag3,'gaussian',0,(11/255).^2);
Imag3_25 = imnoise(Imag3,'gaussian',0,(25/255).^2);

%% 1. Template method

g_Sobel_1=(1/4).*[1,0,-1;
    2,0,-2;
    1,0,-1];

g_Sobel_2=(1/4).*[-1 -2 -1;0 0 0 ;1 2 1];

g_Prewitt_1=(1/3).*[1 0 -1 ; 1 0 -1; 1 0 -1];
g_Prewitt_2=(1/3).*[-1 -1 -1; 0 0 0; 1 1 1];

g_Roberts_1=[0 0 -1; 0 1 0; 0 0 0];
g_Roberts_2=[-1 0 0;0 1 0; 0 0 0];

T=30;%30,70,100

for i=1:1:2
    if (i==1)
        L=1;
    end
    if(i==2)
        L=2;
    end
    
Edge_1=template_method(g_Sobel_1, g_Sobel_2,  Imag1,L, T);
Edge_1_5=template_method(g_Sobel_1, g_Sobel_2,  Imag1_5,L, T);
Edge_1_11=template_method(g_Sobel_1, g_Sobel_2,  Imag1_11,L, T);
Edge_1_25=template_method(g_Sobel_1, g_Sobel_2,  Imag1_25,L', T);

if(i==1)
   Edge_1_temp_L1=Edge_1; 
end

if(i==2)
   Edge_1_temp_L2=Edge_1; 
end

figure('Name',['Edges of Lena with the template method with T = ', num2str(T), ' and L= ', num2str(L) ])
subplot(2,2,1), imshow(Edge_1);
title('clean')
subplot(2,2,2), imshow(Edge_1_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_1_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_1_25);
title('\sigma=25')



Edge_2=template_method(g_Sobel_1, g_Sobel_2,  Imag2,L, T);
Edge_2_5=template_method(g_Sobel_1, g_Sobel_2,  Imag2_5,L, T);
Edge_2_11=template_method(g_Sobel_1, g_Sobel_2,  Imag2_11,L, T);
Edge_2_25=template_method(g_Sobel_1, g_Sobel_2,  Imag2_25,L, T);

figure('Name',['Edges of Rice with the template method with T = ', num2str(T), ' and L= ', num2str(L) ])
subplot(2,2,1), imshow(Edge_2);
title('clean')
subplot(2,2,2), imshow(Edge_2_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_2_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_2_25);
title('\sigma=25')

Edge_3=template_method(g_Sobel_1, g_Sobel_2,  Imag3,L, T);
Edge_3_5=template_method(g_Sobel_1, g_Sobel_2,  Imag3_5,L, T);
Edge_3_11=template_method(g_Sobel_1, g_Sobel_2,  Imag3_11,L, T);
Edge_3_25=template_method(g_Sobel_1, g_Sobel_2,  Imag3_25,L, T);

figure('Name',['Edges of Road with the template method with T = ', num2str(T), ' and L= ', num2str(L) ])
subplot(2,2,1), imshow(Edge_3);
title('clean')
subplot(2,2,2), imshow(Edge_3_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_3_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_3_25);
title('\sigma=25')

end



%% 2. Compass operator
T=30; %T=70 ,100

Edge_1_comp=compass_operator(Imag1,T);
Edge_1_5=compass_operator(Imag1_5,T);
Edge_1_11=compass_operator(Imag1_11,T);
Edge_1_25=compass_operator(Imag1_25,T);

figure('Name',['Edges of Lena with the Compass operator with T = ', num2str(T)])
subplot(2,2,1), imshow(Edge_1_comp);
title('clean')
subplot(2,2,2), imshow(Edge_1_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_1_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_1_25);
title('\sigma=25')

Edge_2=compass_operator(Imag2,T);
Edge_2_5=compass_operator(Imag2_5,T);
Edge_2_11=compass_operator(Imag2_11,T);
Edge_2_25=compass_operator(Imag2_25,T);

figure('Name',['Edges of Rice with the Compass operator with T = ', num2str(T) ])
subplot(2,2,1), imshow(Edge_2);
title('clean')
subplot(2,2,2), imshow(Edge_2_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_2_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_2_25);
title('\sigma=25')


Edge_3=compass_operator(Imag3,T);
Edge_3_5=compass_operator(Imag3_5,T);
Edge_3_11=compass_operator(Imag3_11,T);
Edge_3_25=compass_operator(Imag3_25,T);

figure('Name',['Edges of Road with the Compass operator with T = ', num2str(T) ])
subplot(2,2,1), imshow(Edge_3);
title('clean')
subplot(2,2,2), imshow(Edge_3_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_3_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_3_25);
title('\sigma=25')

%% 3. Laplace operator
s=2;  % s= 2, 2.5,3
T=15; % T=1 15 30
Edge_1_lap=laplace_operator(Imag1,s,T);
Edge_1_5=laplace_operator(Imag1_5,s,T);
Edge_1_11=laplace_operator(Imag1_11,s,T);
Edge_1_25=laplace_operator(Imag1_25,s,T);

figure('Name',['Edges of Lena with the Laplace operator with sigma = ', num2str(s)])
subplot(2,2,1), imshow(Edge_1_lap);
title('clean')
subplot(2,2,2), imshow(Edge_1_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_1_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_1_25);
title('\sigma=25')

Edge_2=laplace_operator(Imag2,s,T);
Edge_2_5=laplace_operator(Imag2_5,s,T);
Edge_2_11=laplace_operator(Imag2_11,s,T);
Edge_2_25=laplace_operator(Imag2_25,s,T);

figure('Name',['Edges of Rice with the Laplace operator with sigma  = ', num2str(s)])
subplot(2,2,1), imshow(Edge_2);
title('clean')
subplot(2,2,2), imshow(Edge_2_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_2_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_2_25);
title('\sigma=25')

Edge_3=laplace_operator(Imag3,s,T);
Edge_3_5=laplace_operator(Imag3_5,s,T);
Edge_3_11=laplace_operator(Imag3_11,s,T);
Edge_3_25=laplace_operator(Imag3_25,s,T);

figure('Name',['Edges of Road with the Laplace operator with sigma  = ', num2str(s)])
subplot(2,2,1), imshow(Edge_3);
title('clean')
subplot(2,2,2), imshow(Edge_3_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_3_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_3_25);
title('\sigma=25')

%% 4. Frei-Chen Method
T=30; % T=30,70,100
Edge_1_frei=frei_chen(Imag1,T);
Edge_1_5=frei_chen(Imag1_5,T);
Edge_1_11=frei_chen(Imag1_11,T);
Edge_1_25=frei_chen(Imag1_25,T);

figure('Name',['Edges of Lena with the Frei Chen method with T = ', num2str(T)])
subplot(2,2,1), imshow(Edge_1_frei);
title('clean')
subplot(2,2,2), imshow(Edge_1_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_1_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_1_25);
title('\sigma=25')

Edge_2=frei_chen(Imag2,T);
Edge_2_5=frei_chen(Imag2_5,T);
Edge_2_11=frei_chen(Imag2_11,T);
Edge_2_25=frei_chen(Imag2_25,T);

figure('Name',['Edges of Rice with the Frei Chen method with T = ', num2str(T)])
subplot(2,2,1), imshow(Edge_2);
title('clean')
subplot(2,2,2), imshow(Edge_2_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_2_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_2_25);
title('\sigma=25')

Edge_3=frei_chen(Imag3,T);
Edge_3_5=frei_chen(Imag3_5,T);
Edge_3_11=frei_chen(Imag3_11,T);
Edge_3_25=frei_chen(Imag3_25,T);

figure('Name',['Edges of Road with the Frei Chen method with T = ', num2str(T)])
subplot(2,2,1), imshow(Edge_3);
title('clean')
subplot(2,2,2), imshow(Edge_3_5);
title('\sigma=5')
subplot(2,2,3), imshow(Edge_3_11);
title('\sigma=11')
subplot(2,2,4), imshow(Edge_3_25);
title('\sigma=25')

%% Comparison

figure('Name','Comparison for the clean lena image with T=30')
subplot(2,3,1), imshow(Edge_1_temp_L1);
title('Template L1')
subplot(2,3,2), imshow(Edge_1_temp_L2);
title('Template L2')
subplot(2,3,3), imshow(Edge_1_comp);
title('Compass')
subplot(2,3,4), imshow(Edge_1_lap);
title('Laplace')
subplot(2,3,5), imshow(Edge_1_frei);
title('Frei')

error=Edge_1_temp_L2 - Edge_1_comp;



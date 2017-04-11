% Image and Video Processing
% Lab 4: Light Field Imaging
% Author: Yuliang Zheng, Valentine Ghislaine Gilda Santarelli 
% Nov.2016 
clc;
clear all;
close all;


addpath('...');
load('Bikes.mat');
load('Fountain.mat');
load('Friends.mat');

imag1 = Bikes_4DLF;
imag2 = Fountain_4DLF; 
imag3 = Friends_4DLF;



%% Refocusing of LF Images
X = 8;

imag1_refocus = refocus(imag1, X);
imag2_refocus = refocus(imag2, X);
imag3_refocus = refocus(imag3, X);

figure
subplot(2,2,1),imshow(imag1_refocus);
hold on
subplot(2,2,2),imshow(imag2_refocus);
hold on 
subplot(2,2,3),imshow(imag3_refocus);
hold on 

% figure 
% imshow(imag1_refocus)


%% Depth of Field of LF Images

X = 3;

for A = [1, 5, 10, 15]

imag1_refocusA = refocusA(imag1, X, A);
imag2_refocusA = refocusA(imag2, X, A);
imag3_refocusA = refocusA(imag3, X, A);

figure
subplot(2,2,1),imshow(imag1_refocusA);
hold on
subplot(2,2,2),imshow(imag2_refocusA);
hold on 
subplot(2,2,3),imshow(imag3_refocusA);
hold on 

end



%% Depth of Field Measurement
Blur=[];
A=[3,5,7,9,11,13];

for i = [1,2,3]
    if i==1
        imag=imag1;
        X=5;
    end
    if i==2
        imag=imag2;
        X=5;
    end
    if i==3
        imag=imag3;
        X=-4;
    end
    
    for j=1:1:6
    imag_refocusA = refocusA(imag, X, A(1,j));
    
    image = double(imag_refocusA); 
    Y=rgb2ycbcr(image);
    Y=Y(:,:,1);

    [blur_index_ver,blur_index_hor] = NR_blur(Y);
    blur_index= (blur_index_ver + blur_index_hor)/2;
    
    Blur(i,j)=blur_index;
    end 
end

plot(A,Blur(1,:), 'LineWidth',2)
hold on
plot(A,Blur(2,:), 'LineWidth',2)
hold on
plot(A,Blur(3,:), 'LineWidth',2)
hold on
legend('Bikes.mat','Fountains.mat','Friends.mat')
%set(legende, 'FontSize',14);
legend('show','FontSize',14)
xlabel('Aperture size','FontSize',14)
ylabel('Blur index','FontSize',14)



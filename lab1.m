% Image and Video Processing
% Lab 1: Getting Started with Matlab, Quantization, Sampling, Filtering, 2DFT, Weber Law
% Author: Yuliang Zheng, Valentine Ghislaine Gilda Santarelli 
% Oct.2016 

clear all;
close all;
addpath('...');

%% 2.1 Images and color tables

% 1. read and show the two images

% for trees.tif
[Y1, map1] = imread('trees.tif');

figure('name', 'trees.tif original');
imshow(Y1, map1);

% for lena.tif
[Y2, map2] = imread('lena.tif');

figure('name', 'lena.tif original')
imshow(Y2, []);


% 2. Show the images in gray level and invert them

% for tree.tif
% colormap of tree
Y1g = ind2gray(Y1, map1);

figure('name', 'trees.tif grayscale')
imshow(Y1g);

% build a matrix with all in 255
M = [255]
M = repmat(M,258, 350);
M = uint8(M);

Y1i = M-Y1g;

figure('name', 'trees.tif inverted')
imshow(Y1i)

% for lena.tif
Y2g = rgb2gray(Y2);

figure('name', 'lena.tif grayscale')
imshow(Y2g, []);

M = 255;
M = repmat(M, 512,512);
M = uint8(M);

Y2i = M-Y2g;

figure('name', 'lena.tif inverted')
imshow(Y2i, []);
 
% Show the modified images for different values
% for tree
figure('name', 'tree.tif with different gamma');
n = 1;
A = [0.5; 1; 1.5; 2];
for i = 1:1:4
gamma = A(i);
map1=map1.^gamma;
subplot(2,2,n)
subimage(Y1,map1);
title(['\fontsize{16} gamma is ' num2str(A(i))]);
n = n+1;
end

% for lena
figure('name', 'lena.tif with different gamma');

% to centralize the figure
Y2=double(Y2);
Y2=Y2./255;

n = 1;
for i = 1:1:4
gamma = A(i);
Y2c = Y2.^gamma;
subplot(2,2,n)
subimage(Y2c);
title(['\fontsize{16} gamma is ' num2str(A(i))]);
n = n+1;
end

% 4. Create the image of a chess board (8x8) with blue and yellow squares 

% truecolor
% create a blue square
bluesquare = zeros(20,20,3);
bluesquare(:,:,1) = 0;
bluesquare(:,:,2) = 0;
bluesquare(:,:,3) = 255;
% create a yellow square 
ysquare= zeros(20,20,3);
ysquare(:,:,1) = 255;
ysquare(:,:,2) = 255;
ysquare(:,:,3) = 0;

G=[bluesquare, ysquare; ysquare, bluesquare];
chess=repmat(G,4,4);

figure('name', 'Chess Board in truecolor')
imshow(chess, []);

imwrite(chess, 'ChessBoard_truecolor.tif');

%indexed

map=zeros(2,3);
map=[0,0,1;1,1,0];

bluesquare= ones(20,20);
ysquare= 2.*ones(20,20);

G2=[bluesquare, ysquare; ysquare, bluesquare];
chess2=repmat(G2,4,4);

figure('name', 'Chess Board of indexed')
imshow(chess2,map)
imwrite(chess, 'ChessBoard_indexed.tif');



%% 2.2 Image quantization

X3 = imread('lena-y.png');

% Adjust the quantization step to obtain successively 128, 64, 32, 16, 8, 4 and 2 gray level
step = [2,4,8,16,32,64,128];
figure('name', 'Image Quantization in different gray level')
for i=1:1:7
   stepsize = step(i);
   gray_level = 256/stepsize;
   X3q=floor(double(X3)./stepsize).*stepsize;
   subplot(2,4,i);
   imshow(X3q,[]);
   title(['gray level is ' num2str(gray_level)]);
end

% false colors appears at 16 levels of gray




%% 2.3 Filtering

% Create the 5*5 2D filter
a = [0.0357;0.2411;0.4464;0.2411;0.0357];
b = a';
M1 = a*b;
% Show the filter's frequency response
[H1,Fx,Fy] = freqz2(M1,5,5);
H1

% Calculate and show the frequency response (magnitude only) of this filter
figure('name', 'frequency response of filter 5*5');
h = fwind1(H1, bartlett(16));
colormap(jet(64));
freqz2(h, [10 10]); 
% axis ([-1 1 -1 1 0 1]);
title('\fontsize{16} frequency response of filter 5*5');

% % Calculate and show the frequency response (magnitude only) of this filter
% figure('name', 'frequency response of filter 5*5');
% h = surfc(H1);
% set(h(1), 'edgecolor', 'none');
% shg;
% title('\fontsize{16} frequency response of filter 5*5');

% the original gold-text.png image
X4 = imread('gold-text.png');
figure('name', 'gold-text.png original');
imshow(X4, []);

% gold-text.png after the 5*5 2D filter 
X4 = double(X4);
% Apply the filter to the image, is doing a convolution
Y4c = conv2(M1,X4);
Y4c = uint8(Y4c);
figure('name', 'gold-text.png after the 5*5 2D filter')
imshow(Y4c);
% Result: the image is blurred

% Create the 3*3 2D filter
M2 = (1/6).*[-1 ,-4,-1;-4,26,-4;  -1,-4,-1];
% Show the filter's frequency response
[H2,Fx,Fy] = freqz2(M2,5,5);
H2

% Calculate and show the frequency response (magnitude only) of this filter
figure('name', 'frequency response of filter 3*3');
h = fwind1(H2, bartlett(16));
colormap(jet(64));
freqz2(h, [6 6]); 
% axis ([-1 1 -1 1 0 1]);
title('\fontsize{16} frequency response of filter 3*3');

% % Calculate and show the frequency response (magnitude only) of this filter
% figure('name', 'frequency response of filter 5*5');
% h = surfc(H2);
% set(h(1), 'edgecolor', 'none');
% shg;
% title('frequency response of filter 3*3');

% Apply the filter to the image
Y4c2 = conv2(M2,Y4c);
Y4c2 = uint8(Y4c2);
figure('name', 'gold-text.png after the 3*3 2D filter' )
imshow(Y4c2, []); 
% Result: Compared to the previous one, the filtered image is sharper



%% 2.4 Correlation

% the original gold-text.png and the g-letter.png
X5=imread('gold-text.png');
figure('name', 'the original gold-text.png');
imshow(X5,[]);

% do a flip of the object image
X6=imread('g-letter.png');
X6r=imrotate(X6,180);
% figure
% imshow(X6r);

% to centralize the images
[row1, col1] = size(X5);
[row2, col2] = size(X6);
M5 = -128 * ones(row1,col1);
M6 = -128 * ones(row2,col2);

X6r = M6 + double(X6r);
X5 = M5 + double(X5);

% 1. find the position of letter g in the spatial domain
% implement the correlation function
Ycorr=conv2(X6r,X5);

% find the central point of letter g
Ymax=max(max(Ycorr));
[row,col]=find(Ycorr==Ymax,1);
row= floor(row - size(X6,1)/2);
col= floor(col - size(X6,2)/2);

% show the place in a all black picture with white point be the center of g
test=zeros(row1,col1);
test(row,col) = 1;
figure('name', 'the position of g(spatial)');
imshow(test);

% find the position of letter g in the frequency domain
% find the corresponding frequency response
Y5 = fft2(X5,size(X5, 1) + size(X6r, 1) - 1, size(X5,2) + size(X6r, 2) -1);
Y6r = fft2(X6r,size(X5, 1) + size(X6r, 1) - 1, size(X5,2) + size(X6r, 2) -1);
% implement the correlation
Ycorr_freq = Y6r.*Y5;
Ycorr_spat=ifft2(Ycorr_freq ,size(X5, 1) + size(X6r, 1) - 1, size(X5,2) + size(X6r, 2) -1);

% find the position of g
Ymax = max(max(Ycorr_spat));
[row3,col3] = find(Ycorr_spat == Ymax,1);

row3 = floor(row3 - size(X6,1)/2);
col3 = floor(col3 - size(X6,2)/2);

test2 = zeros(row1, col1);
test2(row3,col3) = 1;

figure('name', 'the position of g (frequency) ')
imshow(test2, []);

% Add a noise to the image
% the optional standard deviations
V=[5,10,25,40,50]

% build a null cell to save the siye
size_spat = zeros(2,5);
size_freq = zeros(2,5);

figure('name', 'gold-text.png with different noises');
images_noise = cell(1,5);
for i = 1:1:5
% add the noises
J = X5+ sqrt(V(i))*randn(size(X5));
subplot(2,3,i);
imshow(J,[]);
title(['\fontsize{16} deviation = ' num2str(V(i))]);
% save the imnoised images
images_noise{i} = J;
end

figure('name', ' Correlation with noise (spatial domain)');
for i = 1:1:5
J = images_noise{i};
Ycorr_spat=conv2(X6r,J);

size_spat(1,i) =  size(Ycorr_spat,1);
size_spat(2,i) =  size(Ycorr_spat,2);

subplot(2,3,i);
imshow(Ycorr_spat,[]);
title(['\fontsize{16} deviation = ' num2str(V(i))]);
end

figure('name', ' Correlation with noise (frequency domain)');
for i = 1:1:5
J = images_noise{i};
Y5=fft2(J,size(J, 1) + size(X6r, 1) - 1, size(J,2) + size(X6r, 2) -1);
Y6r=fft2(X6r,size(J, 1) + size(X6r, 1) - 1, size(J,2) + size(X6r, 2) -1);

Ycorr_freq= Y6r.*Y5;

size_freq(1,i) =  size(Ycorr_freq,1);
size_freq(2,i) =  size(Ycorr_freq,2);

subplot(2,3,i);
imshow(Ycorr_spat, []);
title(['\fontsize{16} deviation = ' num2str(V(i))]);   
end


%% 2.5 Resampling

% load the image sub4.tif
Xsub4 = imread('sub4.tif');

% the original sub4.tif
figure('name', 'the original sub4.tif');
imshow(Xsub4);

% Down sample by a factor of 2
Xsub4_2 = downsample(Xsub4, 2);
Xsub4_2 = downsample(Xsub4_2',2);
Xsub4_2 = Xsub4_2';

figure('name', 'Down sample by a factor of 2');
imshow(Xsub4_2);

% Down sample by a factor of 4
Xsub4_4 = downsample(Xsub4, 4);
Xsub4_4 = downsample(Xsub4_4',4);
Xsub4_4 = Xsub4_4';


figure('name', 'Down sample by a factor of 4');
imshow(Xsub4_4);



%% 2.6 Phase and magnitude of the 2DFT

% lena-y.png 
X7 = imread('lena-y.png');

figure('name', 'lena-y.png original');
imshow(X7, []);

Y7 = fft2(X7);

X7_real = ifft2(Y7-j*imag(Y7));
figure('name', 'lena-y.png deleting the imaginary part');
imshow(X7_real,[]);

X7_im = ifft2(Y7- real(Y7));
figure('name', 'lena-y.png deleting the real part');
imshow(X7_im,[]);

X7_mag = log(ifft2(abs(Y7)));
figure('name', 'lena-y.png phase is zero');
imshow(X7_mag,[]);

X7_phase = ifft2(Y7./abs(Y7));
figure('name', 'lena-y.png magnitude is 1')
imshow(X7_phase,[]);



%% 2.7 Weber law

% 1. Use the weber function to create the matrix, weber(L1, L2, Lb)
L1 =100;
Lb = 10;
for l = 1:1:10
    L2 = L1 + l;
    A = weber(L1, L2, Lb);
    figure;
    imshow(A, [0 255]);
end

% 2. The two experiments done with different Lb:

% Lb = 10:
% L1 = 1, L2 = 17
% L1 = 10, L2 = 17
% L1 = 20, L2 = 13
% L1 = 35, L2 = 37
% L1 = 50, L2 = 52
% L1 = 100, L2 = 102
% L1 = 150, L2 = 152
% L1 = 200, L2 = 202
% L1 = 230, L2 = 232
% L1 = 250, L2 = 252

% Lb = 200:
% L1 = 1, L2 = 19
% L1 = 10, L2 = 19
% L1 = 20, L2 = 25
% L1 = 35, L2 = 37
% L1 = 50, L2 = 52
% L1 = 100, L2 = 102
% L1 = 150, L2 = 152
% L1 = 200, L2 = 202
% L1 = 230, L2 = 232
% L1 = 250, L2 = 252


% to calculate the weber constant and plot the figure
L1 = [1, 10, 20, 35, 50, 100, 150, 200, 230, 250];
L2_1 = [17, 17, 13, 37, 52, 102, 152, 202, 232, 252];
L2_2 = [19,19, 25, 37, 52, 102, 152, 202, 232, 252];
% the weber constant
alpha_1 = (L2_1 - L1)./L1;
alpha_2 = (L2_2 - L1)./L1;
figure('name', 'The weber constant');
plot(L1, alpha_1,'r-*', 'LineWidth', 2);
hold on;
plot( L1, alpha_2, 'g-o','LineWidth', 2);
legend('Lb = 10','Lb = 200');
grid on;
title('The weber constant with Lb = 10, 200');
xlabel('L1');
ylabel('weber constant');
legend('show');

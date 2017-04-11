% Image and Video Processing
% Lab 2: Dithering
% Author: Yuliang Zheng, Valentine Ghislaine Gilda Santarelli 
% Oct.2016 

clear all;
close all;

addpath('...');


% input the two images
Imag1 = imread('lena-y.png');
Imag2 = imread('wool.png');

A = double(Imag1)/255;
B = double(Imag2)/255;

figure('name', 'lena-y original');
imshow(Imag1);

figure('name', 'wool original');
imshow(Imag2);

[row1, col1] = size(Imag1);
[row2, col2] = size(Imag2);


%% 1. Fixed threshold method

% for lena-y.png
Imag1_fixed = zeros(row1, col1);

profile on;

for i = 1:1:row1
    for j = 1:1:col1
        if Imag1(i,j) < 128
            Imag1_fixed(i,j) = 0;
        else
            Imag1_fixed(i,j) = 255;
        end
end
end

figure('name', 'lena-y with Fixed threshold');
imshow(Imag1_fixed);

err_Image1_fixed = immse(A, Imag1_fixed/255)

% for wool.png
Imag2_fixed = zeros(row2, col2);

for i = 1:1:row2
    for j = 1:1:col2
        if Imag2(i,j) < 128
            Imag2_fixed(i,j) = 0;
        else
            Imag2_fixed(i,j) = 255;
        end
end
end

figure('name', 'wool with Fixed threshold');
imshow(Imag2_fixed);

err_Image2_fixed = immse(B, Imag2_fixed/255)



%% 2. Random threshold method

noise_range = [10; 30; 60; 90; 120];

% for lena-y.png
Imag2_rand = zeros(row1, col1);

figure('name', 'lena-y with Random threshold');

err_Image1_random = zeros(5,1);

for m = 1:1:5
    noise_imag1 = unidrnd(noise_range(m), row1, col1);
    Imag2_new = double(Imag1) + noise_imag1 - noise_range(m)/2;
    for i = 1:1:row1
        for j = 1:1:col1
            if Imag2_new(i,j) < 128
                Imag2_rand(i,j) = 0;
            else
                Imag2_rand(i,j) = 255;
            end
        end
    end
    subplot(2,3,m);
    imshow(Imag2_rand);
    title(['noise range is ' num2str(noise_range(m))]);
    err_Image1_random(m) = immse(A, Imag2_rand/255);
end

err_Image1_random

% for wool.png
Imag2_rand = zeros(row2, col2);

figure('name', 'wool with Random threshold');

err_Image2_random = zeros(5,1);

for m = 1:1:5
    noise_imag2 = unidrnd(noise_range(m), row2, col2);
    Imag2_new = double(Imag2) + noise_imag2 - noise_range(m)/2;
    for i = 1:1:row2
        for j = 1:1:col2
            if Imag2_new(i,j) < 128
                Imag2_rand(i,j) = 0;
            else
                Imag2_rand(i,j) = 255;
            end
        end
    end
    subplot(2,3,m);
    imshow(Imag2_rand);
    title(['noise range is ' num2str(noise_range(m))]);
    err_Image2_random(m) = immse(B, Imag2_rand/255);
end

err_Image2_random

%% 3. Ordered threshold method

% 1. Quantization
% Quantization for lena-y.png
Quantized_imag1 = quantization(Imag1, 37);
figure('name', 'the quantized lena image');
imshow(Quantized_imag1,[]);

% Quantization for wool.png
Quantized_imag2 = quantization(Imag2, 37);
figure('name', 'the quantized wool image');
imshow(Quantized_imag2,[]);

% 2. Create the paving table
% the small S matrix
s = [34, 29, 17, 21, 30, 35;
    28, 14, 9, 16, 20, 31;
    13, 8, 4, 5, 15, 19;
    12, 3, 0, 1, 10, 18;
    27, 7, 2, 6, 23, 24;
    33, 26, 11, 22, 25, 32];

% implement the ordered threshold method
% for lena
Ordered_imag1 = ordered_threshold(Quantized_imag1, s);
% for wool
Ordered_imag2 = ordered_threshold(Quantized_imag2, s);

figure('name','ordered threshold: lena');
imshow(Ordered_imag1, []);

err_Image1_ordered = immse(A, double(Ordered_imag1/255))

figure('name','ordered threshold: wool');
imshow(Ordered_imag2, []);

err_Image2_ordered = immse(B, double(Ordered_imag2/255))


%% Ordered matrix with centered points

% create the two matrix

C = [34, 25, 21, 17, 29, 33;
     30, 13, 9, 5, 12, 24;
     18, 6, 1, 0, 8, 20;
     22, 10, 2, 3, 4, 16;
     26, 14, 7, 11, 15, 28;
     35, 31, 19, 23, 27, 32];
 
 E = [30, 22, 16, 21, 33, 35;
      24, 11, 7, 9, 26, 28;
      13, 5, 0, 2, 14, 19;
      15, 3, 1, 4, 12, 18;
      27, 8, 6, 10, 25, 29;
      32, 20, 17, 23, 31, 34];
  
  
% apply the two matrix to the images
% for lena
C_imag1 = ordered_threshold(Quantized_imag1, C);
E_imag1 = ordered_threshold(Quantized_imag1, E);
% for wool
C_imag2 = ordered_threshold(Quantized_imag2, C);
E_imag2 = ordered_threshold(Quantized_imag2, E);

figure('name','ordered threshold: lena with C');
imshow(C_imag1, []);

err_Image1_C = immse(A, double(C_imag1/255))

figure('name','ordered threshold: lena with E');
imshow(E_imag1, []);

err_Image1_E = immse(A, double(E_imag1/255))

figure('name','ordered threshold: wool with C');
imshow(C_imag2, []);

err_Image2_C = immse(B, double(C_imag2/255))

figure('name','ordered threshold: wool with E');
imshow(E_imag2, []);

err_Image2_E = immse(B, double(E_imag2/255))

% with C: star shape: with E: circles


%% 5. Diagonal ordered matrix with balanced centered points

O_81 = [13, 9, 5, 12;
        6, 1, 0, 8;
        10, 2, 3, 4;
        14, 7, 11, 15];
    
O_82 = [18, 22, 26, 19;
        25, 30, 31, 23;
        21, 29, 28, 27;
        17, 24, 20, 16];
    
O_8 = [O_81, O_82;
       O_82, O_81];
   
% apply the two matrix to the images
% for lena
O_imag1 = ordered_threshold(Quantized_imag1, O_8);
% for wool
O_imag2 = ordered_threshold(Quantized_imag2, O_8);

figure('name','ordered threshold: lena with O_8');
imshow(O_imag1, []);

err_Image1_O = immse(A, double(O_imag1/255))

figure('name','ordered threshold: wool with O_8');
imshow(O_imag2, []);

err_Image2_O = immse(B, double(O_imag2/255))


%% 6. Ordered matrix with dispersed dots

% create the matrix
U_3 = ones(3,3);

D_3 = [8, 4, 5;
       3, 0, 1;
       7, 2, 6];
   
D_6 = [4*D_3, 4*D_3+2*U_3;
       4*D_3+3*U_3, 4*D_3+U_3];
   
% apply the two matrix to the images
% for lena
D_imag1 = ordered_threshold(Quantized_imag1, D_6);
% for wool
D_imag2 = ordered_threshold(Quantized_imag2, D_6);

figure('name','ordered threshold: lena with D_6');
imshow(D_imag1, []);

err_Image1_D = immse(A, double(D_imag1/255))

figure('name','ordered threshold: wool with D_6');
imshow(D_imag2, []);

err_Image2_D = immse(B, double(D_imag2/255))

%% 7. Error diffusion method

% Error diffusion Maxtrix to use 

Floyd= [0,0,7;3,5,1];

Diff_imag1_F=err_diff(Imag1,Floyd);
Diff_imag2_F=err_diff(Imag2,Floyd);

figure('name','Diffusion threshold: lena with Floyd');
imshow(Diff_imag1_F);

err_Image1_Floyd = immse(A, double(Diff_imag1_F/255))

figure('name','Diffusion threshold: wool with Floyd');
imshow(Diff_imag2_F);

err_Image2_Floyd = immse(B, double(Diff_imag2_F/255))

Stucki=[0,0,0,8,4; 2,4,8,4,2;1,2,4,2,1];
Diff_imag1_S=err_diff(Imag1,Stucki);
Diff_imag2_S=err_diff(Imag2,Stucki);

figure('name','Diffusion threshold: lena with Stucki');
imshow(Diff_imag1_S);

err_Image1_Stucki = immse(A, double(Diff_imag1_S/255))

figure('name','Diffusion threshold: wool with Stucki');
imshow(Diff_imag2_S);

err_Image2_Stucki = immse(B, double(Diff_imag2_S/255))

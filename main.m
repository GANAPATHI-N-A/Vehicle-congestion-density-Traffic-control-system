clc;
close all;
clear all;
%%%%%%%%%%Reference Image%%%%%%%%%%
RGB1 = imread('free.jpeg');
%figure; 
imshow(RGB1); 
title('Reference Image');
%RGB to Gray Conversion
I1 = rgb2gray(RGB1);
ID1=im2double(I1);
%figure;
subplot(221)
imshow(I1);
subplot(223)
imshow(ID1); 
title('Reference Image: Gray Image');

%Image Resizing
IR1 = imresize(ID1, [512 512]);
figure;
subplot(221)
imshow(IR1); 
title('Resized Reference Image');
%Image Enhancement Power Law Transformation
c = 2;g =0.9;
for p = 1 : 512
    for q = 1 : 512
        IG1(p, q) = c * IR1(p, q).^ 0.9;
    end
end

%figure;

imshow(IG1);
title('Enhanced Reference Image');
%Edge Detection% The algorithm parameters:
% 1. Parameters of edge detecting filters:
% X-axis direction filter:
Nx1=10;
Sigmax1=1;
Nx2=10;
Sigmax2=1;
Theta1=pi/2;
% Y-axis direction filter:
Ny1=10;
Sigmay1=1;
Ny2=10;
Sigmay2=1;
Theta2=0;
% 2. The thresholding parameter alfa:
alfa=0.1;
% Get the initial Reference Imagefigure;
subplot(3,2,1);
imagesc(IG1);
title('Image: Reference Image');
% X-axis direction edge detection
subplot(3,2,2);
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(IG1,filterx,'same');
imagesc(Ix);
title('Ix');
% Y-axis direction edge detection
subplot(3,2,3);
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(IG1,filtery,'same');
imagesc(Iy);
title('Iy');
% Norm of the gradient (Combining the X and Y directional derivatives)
subplot(3,2,4);
NVI1=sqrt(Ix.*Ix+Iy.*Iy);
%%%%%%%%%%Captured Image%%%%%%%%%%
RGB2 = imread('lot.jpeg');
%figure; imshow(RGB2); title('Captured Image');
%RGB to Gray Conversion: Captured Image
I2 = rgb2gray(RGB2);
ID2=im2double(I2);
%figure;
imshow(ID2); 
title('Captured Image:Gray Image');
%Image Resizing: Captured Image
IR2 = imresize(ID2, [512 512]);
%figure; imshow(IR2); title('Resized Captured Image');
%Image Enhancement Power Law Transformation: Captured Image
for p = 1 : 512
 for q = 1 : 512
 IG2(p, q) = abs(c * IR2(p, q).^ 0.9);
 end
end
%figure; imshow(IG2); 
title('Enhanced Captured Image');
%Edge Detection
% Get the initial Captured Image
figure;
subplot(3,2,1);
imagesc(IG2);
title('Image: Captured Image');
% X-axis direction edge detection
subplot(3,2,2);
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(IG2,filterx,'same');
imagesc(Ix);
title('Ix');
% Y-axis direction edge detection
subplot(3,2,3)
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(IG2,filtery,'same');
imagesc(Iy);
title('Iy');
% Norm of the gradient (Combining the X and Y directional derivatives)
subplot(3,2,4);
NVI2=sqrt(Ix.*Ix+Iy.*Iy);
%%%%%%%%%%Image Matching%%%%%%%%%%
match = 0;
BW1 = im2bw(NVI1);
BW2 = im2bw(NVI2);
for p = 1 : 512
 for q = 1 : 512
 if (BW1(p, q) == BW2(p,q))
 match = match +1;
 end
 end
end
match;
%%%%%%%%%%Output Display%%%%%%%%%%
if(match>=236000 && match<=240000)
 disp('Green signal will be displayed for 60 second');
 disp('Red signal will be displayed for 30 seconds');
elseif(match<236000)
 disp('Green signal will be displayed for 40 second');
 disp('Red signal will be displayed for 30 seconds');
else
 disp('Green signal will be displayed for 15 second');
 disp('Red signal will be displayed for 30 seconds');
 
end
%%%%%%% The functions used in the main.m file %%%%%%%
% Function "d2dgauss.m":
% This function returns a 2D edge detector (first order derivative
% of 2D Gaussian function) with size n1*n2; theta is the angle that
% the detector rotated counter clockwise; and sigma1 and sigma2 are the
% standard deviation of the gaussian functions.


% Function "dgauss.m"(first order derivative of gauss function):

%%%%%%%%%%%%%% end of the functions %%%%%%%%%%%%%
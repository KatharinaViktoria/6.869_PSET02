%% load images
calibration_image = imread('pictures/DSC_0243.jpg');
pinhole_image = imread('pictures/DSC_0210.jpg');
pinhole_image2 = imread('pictures/DSC_0191.jpg');
phone_image = imread('pictures/phone_statue.JPG');
%% initialized coordinates

% figure
% subplot(121)
% imshow(calibration_image)
% subplot(122)
% imshow(pinhole_image)


% we want to transform points a (a1-a2) to be in the same coordinate systems as
% points in image b (b1-b4)
% see additional sketch provided in the write-up

b1 = [996,778];
b2 = [3046,693];
b3 = [1080, 2322];
b4 = [3070,2249];

% coordinates for image 1
a3 = [525, 139];
a4 = [3275, 126];
a1 = [501, 2310];
a2 = [3396, 2261];

% coordinates for image 2 
a_3 = [834, 90];
a_4 = [3178, 75];
a_1 = [806, 1930];
a_2 = [3234, 1926];

%%  perform calibration with horizontal flip on pinhole_image

H= calculate_homography(a1,b1,a2,b2,a3,b3,a4,b4);
calibrated_image = imwarp(pinhole_image, affine2d(H));



figure
subplot(221)
imshow(calibration_image)
title('calibration image')
subplot(222)
imshow(phone_image)
title('taken with a phone camera')
subplot(223)
imshow(pinhole_image)
title('original pinhole camera image')
subplot(224)
imshow(calibrated_image)
title('transformed pinhole camera image')

imwrite(calibrated_image, 'statue_calibrated.jpg')

%% calibration of pinhole_image2 

H= calculate_homography(a_1,b1,a_2,b2,a_3,b3,a_4,b4);
calibrated_image2 = imwarp(pinhole_image2, affine2d(H));

figure
imshow(calibrated_image2)
imwrite(calibrated_image2,'stata_calibrated.jpg')

%% homography function


function H_inv = calculate_homography(a1,b1,a2,b2,a3,b3,a4,b4)
% input: coordinates of corresponding points 
% a (pinhole image) and b (calibration image) (preferably the corners of the white paper) 
% returns h: entries for transformation matrix in vector form

% transfer points from image A into x,y coordinates (as used in matrix A)
    x_1 = a1(1);
    y_1 = a1(2);
    x_2 = a2(1);
    y_2 = a2(2);
    x_3 = a3(1);
    y_3 = a3(2);
    x_4 = a4(1);
    y_4 = a4(2);


    % transfer points from image b into x0,y0 coordinates (as used in matrix A)
    x0_1 = b1(1);
    y0_1 = b1(2);
    x0_2 = b2(1);
    y0_2 = b2(2);
    x0_3 = b3(1);
    y0_3 = b3(2);
    x0_4 = b4(1);
    y0_4 = b4(2);
       
    % define matrix A (A*h = 0)
    A = [-x_1,-y_1,-1,0,0,0,x_1*x0_1, y_1*x0_1, x0_1;
    0,0,0,-x_1,-y_1,-1,x_1*y0_1, y_1*y0_1, y0_1;
    -x_2,-y_2,-1,0,0,0,x_2*x0_2, y_2*x0_2, x0_2;
    0,0,0,-x_2,-y_2,-1,x_2*y0_2, y_2*y0_2, y0_2;
    -x_3,-y_3,-1,0,0,0,x_3*x0_3, y_3*x0_3, x0_3;
    0,0,0,-x_3,-y_3,-1,x_3*y0_3, y_3*y0_3, y0_3;
    -x_4,-y_4,-1,0,0,0,x_4*x0_4, y_4*x0_4, x0_4;
    0,0,0,-x_4,-y_4,-1,x_4*y0_4, y_4*y0_4, y0_4];


    % singular value decomposition of A 
%   h will be the eigenvec with the smallest sigma
%   the singular vector that corresponds to sigma_min is the last column of
%   V
%     [U,S,V] = svd(A);
%     h = V(:,8);


    % alternative way: solve linear system (add another row (0 0 0 0 0 0 0 0 1) to A and solve for A*h = b)
  A(9,:) = [0 0 0 0 0 0 0 0 1]
  b = zeros(9,1);
  b(9,1) = 1;

  h = A\b

    H = [h(1:3,1)';h(4:6,1)';h(7:9,1)'];
    H_inv = H';
    H_inv = H_inv./H_inv(3,3); % normalize such that H(3,3) = 1
    % we have to set make sure that H(1,3) and H(2,3) are exactly zero otherwise H cannot be converted into an affine2d object
    % (it would be preferred if this step would not be necessary)
    H_inv(:,3) = round(H_inv(:,3));
 
end






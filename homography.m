anaglyph_image = imread('pictures/DSC_0225.jpg');
% figure
% imshow(anaglyph_image)

a1 = [2602,1786];
b1 = [2878,1790];
a2 = [3026,850];
b2 = [3298,838];
a3 = [2050,2174];
b3 = [2326,2178];
a4 = [2166,794];
b4 = [2430,798];

h= calculate_homography(a1,b1,a2,b2,a3,b3,a4,b4);

% conversion of vec h to homography matrix H
H = [h(1:3,1)';h(4:6,1)';h(7:9,1)']
H_inv = H';
H_inv = H_inv./H_inv(3,3)
H_inv(:,3) = [0;0;1] % find more elegant solution!!!!
B = imwarp(anaglyph_image(:,:,3), affine2d(H_inv));


figure
subplot(221)
imshow(anaglyph_image)
subplot(222)
imshow(anaglyph_image(:,:,1))
subplot(223)
imshow(B)


function h = calculate_homography(a1,b1,a2,b2,a3,b3,a4,b4)
% input: coordinates of corresponding points 
% a and b coordinates of the same object in image A (red) and image B (blue)

% transfer points from image A into x,y coordinates (as used in matrix A)
    x_1 = a1(1);
    y_1 = a1(2);
    x_2 = a2(1);
    y_2 = a2(2);
    x_3 = a3(1);
    y_3 = a3(2);
    x_4 = a4(1);
    y_4 = a4(2);


    % transfer points from image b into x0,y0 coordinates
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
    0,0,0,-x_4,-y_4,-1,x_4*y0_4, y_4*y0_4, y0_4;
    0 0 0 0 0 0 0 0 1];


    % we are looking for the eigenvector of A with the minimum 'eigenvalue'
    % (eigenvalue as close to zero as possible)
    % singular value decomposition of A 
    
%     [U,S,V] = svd(A);
    
%   h will be the eigenvec with the smallest eigenvalue
%   singular vectors of 
%     h = V(:,8);

    % alternative way: solve linear system (set )
    b = zeros(9,1);
    b(9,1) = 1;
    
    h = A\b
 
end

% [x_1,y_1]=;
% [x0_1,y0_1] = ;
% [x_2,y_2]=;
% [x0_2,y0_2] = ;
% [x_3,y_3]=;
% [x0_3,y0_3] = ;
% [x_4,y_4]=;
% [x0_4,y0_4] = ;

% perform SVD of A



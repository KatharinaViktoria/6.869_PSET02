% A = [-x_1,-y_1,-1,0,0,0,x_1*x0_1, y_1*x0_1, x0_1;
%     0,0,0,-x_1,-y_1,-1,x_1*y0_1, y_1*y0_1, y0_1;
%     -x_2,-y_2,-1,0,0,0,x_2*x0_2, y_2*x0_2, x0_2;
%     0,0,0,-x_2,-y_2,-1,x_2*y0_2, y_2*y0_2, y0_2;
%     -x_3,-y_3,-1,0,0,0,x_3*x0_3, y_3*x0_3, x0_3;
%     0,0,0,-x_3,-y_3,-1,x_3*y0_3, y_3*y0_3, y0_3;
%     -x_4,-y_4,-1,0,0,0,x_4*x0_4, y_4*x0_4, x0_4;
%     0,0,0,-x_4,-y_4,-1,x_4*y0_4, y_4*y0_4, y0_4];

% h = [a;b;c;d;c;d;e;f;g;h;k];
% compute SVD of A and take smallest eigenvalue

% define input points (as corresponding pairs; [x_1,y_1] and [x0_1,y0_1])
% to do: find a way to elegantly read in the datapoints
% a1 = [];
% b1 = [];
% a2 = [];
% b2 = [];
% c1= [];
% c2= [];
% d1= [];
% d2= [];

a1 = [1,1];
b1 = a1;
a2 = [1,1];
b2 = a2;
a3 = [1,1];
b3 = a3;
a4 = [1,1];
b4 = a4;

calculate_homography(a1,b1,a2,b2,a3,b3,a4,b4)

function calculate_homography(a1,b1,a2,b2,a3,b3,a4,b4)
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
    0,0,0,-x_4,-y_4,-1,x_4*y0_4, y_4*y0_4, y0_4];


    % we are looking for the eigenvector of A with the minimum eigenvalue
    % (eigenvalue as close to zero as possible)
    % singular value decomposition of A with lambda being the smallest
    % eigenvalue
    [U,S,V] = svd(A);
%     lambda = sqrt(S(8,8));
%     eigenvals = sqrt(diag(S))
 

    
    

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



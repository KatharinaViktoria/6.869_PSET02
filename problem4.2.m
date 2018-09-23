% 6.869 Advances in Computer Vision
% PSET 2-4.2

%%
%Problem 3 - Calibration
%img1 = imread('DSC_0166.JPG');
%img2 = imread('DSC_0226.JPG');

%imshow(img1)
%[x1, y1] = ginput(4)
%imshow(img2)
%[x2, y2] = ginput(4)

%transm = pinv([x1,y1])* [x2, y2]

%tform = affine2d([transm(1:2), 0; transm(3:4), 0; 0, 0, 1])


%transm = pinv([x2,y2].')*[x1, y1].'

%imgn = imwarp(img2, tform)
%%

%Problem 4.2 

img = imread('DSC_0221.JPG');

% 5 pairs of points 
% redpoints are the locations of red spots
% bluepoints are the locations of blue spots.
%imshow(img)
%redpoints = ginput(20)
%imshow(img)
%bluepoints = ginput(20)

save('redpoints.mat','redpoints')
save('bluepoints.mat','bluepoints')

%load redpoints.mat
%load bluepoints.mat


x1 = redpoints(:, 1)
x2 = bluepoints(:, 1)

% distances is an array of distances in pixels between red spot and
% blue spot
distances = abs(x1 - x2)

% depths is an array of calculated distances between the camera and THE
% objects

x = 16;
p = 1;
calibration_constant = 0.0033

depths = []
for i = 1:size(x1,1)
    depths(i) = x * p / (distances(i) * calibration_constant - p)
end

[r, c] = size(img(:, :, 2));
[xq, yq] = meshgrid(1:r, 1:c);
%touse = inpolygon(xq, yq, x1(inds), y1(inds));
%xq = xq(touse);
%yq = yq(touse);
vq = griddata(redpoints(:,1), redpoints(:, 2), depths, xq, yq);


%img(:, :, 2) is for the red channel
warp(xq, yq, vq,img(:, :, 2))






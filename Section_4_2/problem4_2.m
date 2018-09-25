% 6.869 Advances in Computer Vision
% PSET 2-4.2
%%

%Problem 4.2 

img = imread('calibrated_0221.JPG');
% 5 pairs of points 
% redpoints are the locations of red spots
% bluepoints are the locations of blue spots.

%imshow(img(:, :, 1))
%redpoints = ginput(40)

%x1 = redpoints(:, 1)
%y1 = redpoints(:, 2)


% show the red channel and the selected points
%imshow(img(:, :, 1));
%hold on
%scatter(x1, y1, 'filled', 'r')
%for i=1:size(x1)
%    t = text(x1(i), y1(i), num2str(i))
%    t.Color = 'red'
%    t.FontSize = 14
%end

% select the points at the same locations on blue channel
%imshow(img(:, :, 2))
%bluepoints = ginput(40)

%x2 = bluepoints(:, 1)
%y2 = bluepoints(:, 2)


% show the red channel and the selected points
%imshow(img(:, :, 2));
%hold on
%scatter(x2, y2, 'filled', 'r')
%for i=1:size(x2)
%    t = text(x2(i), y2(i), num2str(i))
%    t.Color = 'red'
%    t.FontSize = 14
%end

%save('redpoints.mat','redpoints')
%save('bluepoints.mat','bluepoints')

load redpoints.mat
load bluepoints.mat


x1 = redpoints(:, 1)
y1 = redpoints(:, 2)

x2 = bluepoints(:, 1)
y2 = bluepoints(:, 2)

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

% create the 3d image
[r, c] = size(img(:, :, 2));
[xq, yq] = meshgrid(1:r, 1:c);
%touse = inpolygon(xq, yq, x1(inds), y1(inds));
%xq = xq(touse);
%yq = yq(touse);

vq = griddata(bluepoints(:,1), bluepoints(:, 2), depths, xq, yq);

%img(:, :, 2) is for the blue channel
warp(xq, yq, vq,img(:, :, 2))









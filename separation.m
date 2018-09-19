% points.mat is an array of 12 pairs of (point1, point2) of the 12 images
% where point1 is location of red spot, point2 is location of blue spot
load points.mat

% distances.mat is an array of distances in pixels between red spot and
% blue spot of the 12 images
load distances.mat

% x is distance between pinhole wall and back image wall
% x = 16"
x = 16;

% p is distance between pinholes
% p = 1"
p = 1;

% Z is an array of calculated distances between the camera and light
Z = [];

for i = 1:size(distances,2)
    Z(i) = x * p / (distances(1,i) - p);
end

figure
scatter(distances, Z, 'filled')
ylabel('Distance between camera and light (Z)') 
xlabel('Distance between 2 spots in pixels (d)')
title('Relationship between Z and d')
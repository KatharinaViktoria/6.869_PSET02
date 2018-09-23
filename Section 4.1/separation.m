% points is an array of 12 pairs of (point1, point2) of the 12 images
% (DSC_0230.JPG to DSC_0241.JPG) where point1 is location of red spot,
% point2 is location of blue spot
load points.mat

% measured_distances is an array of distances in pixels between red spot and
% blue spot
load measured_distances.mat

% calibration_distance is the distance in pixels of the 11" long-side
% of the white sheet in DSC_0242.JPG
load calibration_distance.mat

% calibration_constant relates inches to pixels
calibration_constant = 11 / calibration_distance;

% x is distance between pinhole wall and back image wall
% x = 16"
x = 16;

% p is distance between pinholes
% p = 1"
p = 1;

% d is an array of calibrated measured distances
d = measured_distances * calibration_constant;

% Z is an array of calculated distances between the camera and light
Z = [];

for i = 1:size(distances,2)
    Z(i) = x * p / (d(1,i) - p);
end

figure
scatter(d, Z, 'filled')
hold on;
err = 8*ones(size(Z));
errorbar(d, Z, err, 'LineStyle','none');
xlabel('Measured distance between 2 spots in inches (d)')
ylabel('Calculated distance between camera and light in inches (Z)') 
title('Relationship between Z and d')
% points is an array of 12 pairs of (point1, point2) of the 12 images
% (DSC_0230.JPG to DSC_0241.JPG) where point1 is location of red spot,
% point2 is location of blue spot
load points.mat

% measured_distances is an array of distances in pixels between red spot and
% blue spot
load distances.mat

% calibration_distance is the distance in pixels of the 11" long-side
% of the white sheet in DSC_0242.JPG
load calibration_distance.mat

% gold is the experimental data we measured between the light and the
% pinholes wall, which we use to compare with our calculated predictions
load gold.mat

% calibration_constant relates inches to pixels
calibration_constant = 11 / calibration_distance;

% x is distance between pinhole wall and back image wall
% x = 16"
x = 16;

% p is distance between pinholes
% p = 1"
p = 1;

% d is an array of calibrated measured distances
d = distances * calibration_constant;

% Z is an array of calculated distances between the camera and light
Z = [];

for i = 1:size(distances,2)
    Z(i) = x * p / (d(1,i) - p);
end

figure
scatter(d, Z, 'filled')
hold on;
scatter(d, gold, 'filled')
legend('Prediction data (d)','Experiemental data (gold)');
temp = gold - Z;
yneg = zeros(size(temp));
ypos = zeros(size(temp));
for i = 1:size(temp,2)
    if (temp(i) < 0)
        yneg(i) = -temp(i);
    else
        ypos(i) = temp(i);
    end
end
% errorbar(d, Z, yneg, ypos, 'LineStyle','none');
xlabel('Measured distance between 2 spots in inches (d)')
ylabel('Calculated distance between camera and light in inches (Z)')
ylim([2.5 55])
title('Relationship between Z and d')
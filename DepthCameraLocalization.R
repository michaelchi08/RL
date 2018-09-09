library("plot3D");
library("plot3Drgl");
# filePath = file.choose();
data = read.csv(filePath);
############ parameters and data features ########
# Get the data range for x and y coordinates
x_min = min(data[,1]);
x_max = max(data[,1]);
y_min = min(data[,2]);
y_max = max(data[,2]);
x_r = x_max - x_min;
y_r = y_max - y_min;
# Get the x and y of the object and the range of values
x_p = 339;
y_p = 360;
R_x = 500;
R_y = 500;
# Convert the x and y coordinates to point cloud coordinates
x = (x_r/R_x)*x_p + x_min;
y = (y_r/R_y)*y_p + y_min;
x = 0;
################ Data Cleaning ############
# Remove points that are too far
farPoints = which(abs(data[,3]) > 1.0);
data = data[-farPoints,];
################ Analysis #################
# Define a tolerance of 5 cm
kTolerance = 0.05;
# Find all the points in the vicinity of the x and y point
surfacePoints = data %>%
                subset(abs(data[,1] - x) < kTolerance &
                         abs(data[,2] - y) < kTolerance);

scatter3D(data[,1], data[,2], data[,3],
          phi = 250, theta = 15, col = 'blue',
          pch = 18, ticktype = "detailed");

scatter3D(surfacePoints[,1], surfacePoints[,2], surfacePoints[,3],
          col='red',
          pch = 19, ticktype = "detailed");

plotrgl()

rect3D(x0 = 0, y0 = 0.5, z0 = 0, x1 = 1, z1 = 5, 
       ylim = c(0, 1), bty = "g", facets = TRUE, 
       border = "red", col ="#7570B3", alpha=0.5,
       lwd = 2, phi = 20)

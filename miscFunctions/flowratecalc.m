fps = [11,14,21];

for z = 1:length(fps)
    distanceTraveled = centroid1.Centroid(1) - centroid2.Centroid(1);
    distConverted = (1/(28.25))*distanceTraveled;
    velocity = distConverted/(1/fps(z)); % velocity of 1 particle traveling
    volWater = (4/3)*pi*(70)^2; % volume of planar disk; 140 mm diameter assumed
    volVelocity = volWater*velocity; % mm^3 per second
    volVelocity = volVelocity/1000; % mililiter per second
    litersPerSec = volVelocity/1000; % liters per sec
    fprintf("%0.2f liters/s assuming an FPS of %g\n",litersPerSec,fps(z))
end
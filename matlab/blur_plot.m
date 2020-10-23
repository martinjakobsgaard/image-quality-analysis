%% Plot all data
clc; clear; close;

data = readtable("data.csv");

f = @(b,x) b(1).*exp(b(2).*x)+b(3);                                   
B = fminsearch(@(b) norm(data.blur - f(b,data.exposure)), [-200; -1; 100]) 

hold on
scatter(data.exposure, data.blur)
plot(data.exposure, f(B,data.exposure), '-r')
hold off

%% Sequence plotter
clc; clear; close;

data = readtable("data.csv");

size(data.exposure,1)

datasetBlur = [];
datasetExposure = [];

for c = 1:size(data.exposure,1)
    if ((data.sequence(c)) == 1)
        datasetBlur = [datasetBlur; data.blur(c)];
        datasetExposure = [datasetExposure; data.exposure(c)];
    end
end

scatter(datasetExposure, datasetBlur);
xlim([5 250])
ylim([0 6000])

%% Average plot
clc; clear; close;

data = readtable("data.csv");

size(data.exposure,1)

averageBlur = [];

currentExposure = 5;
tempBuffer = [];

exposureVal = [currentExposure];

for c = 1:size(data.exposure,1)
    if ((data.exposure(c)) == currentExposure)
        tempBuffer = [tempBuffer; data.blur(c)];
    else 
        currentExposure = data.exposure(c);
        averageBlur = [averageBlur; mean(tempBuffer)];
        exposureVal = [exposureVal; currentExposure];
        tempBuffer = [];
        tempBuffer = [tempBuffer; data.blur(c)];
    end
end

averageBlur = [averageBlur; mean(tempBuffer)];

f = @(b,x) b(1).*exp(b(2).*x)+b(3);                                   
B = fminsearch(@(b) norm(averageBlur - f(b,exposureVal)), [-200; -1; 100]) 

hold on
scatter(exposureVal, averageBlur)
plot(exposureVal, f(B,exposureVal), '-r')
hold off

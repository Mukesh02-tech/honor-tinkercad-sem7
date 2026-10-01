clc;
clear;
close all;
%% Read Sensor Data
data = csvread('SensorData.csv');
LDR = data(:,1);
POT = data(:,2);
Samples = 1:length(LDR);
%% Plot Original Sensor Data
figure;
plot(Samples,LDR,'b');
hold on;
plot(Samples,POT,'r');
grid on;
title('Original Sensor Data');
xlabel('Samples');
ylabel('Sensor Values');
legend('LDR','Potentiometer');
%% Edge Processing
% Moving Average Filter
FilteredLDR = movmean(LDR,5);
FilteredPOT = movmean(POT,5);
figure;
plot(Samples,FilteredLDR,'b','LineWidth',2);
hold on;
plot(Samples,FilteredPOT,'r','LineWidth',2);
grid on;
title('Filtered Sensor Data');
xlabel('Samples');
ylabel('Filtered Values');
legend('LDR','Potentiometer');
%% Threshold Detection
LDRthreshold = 600;
POTthreshold = 350;
disp(' ');
disp('Threshold Detection');
for i=1:length(LDR)
    if LDR(i)>LDRthreshold
        fprintf('Sample %d : High Light Detected\n',i);
    end
    if POT(i)>POTthreshold
        fprintf('Sample %d : Potentiometer Threshold Exceeded\n',i);
    end
end
%% Anomaly Detection
disp(' ');
disp('Anomaly Detection');
MeanLDR = mean(LDR);
StdLDR = std(LDR);
for i=1:length(LDR)
    if abs(LDR(i)-MeanLDR)>2*StdLDR
        fprintf('Abnormal LDR Reading at Sample %d\n',i);
    end
end
%% Data Reduction
disp(' ');
disp('Edge Transmission');
Previous = LDR(1);
for i=2:length(LDR)
    if abs(LDR(i)-Previous)>20
        fprintf('Transmit Sample %d : %d\n',i,LDR(i));
        Previous=LDR(i);
    end
end
%% Compression Ratio
OriginalPackets = length(LDR);
ReducedPackets = 0;
Previous = LDR(1);
for i=2:length(LDR)
    if abs(LDR(i)-Previous)>20
        ReducedPackets = ReducedPackets + 1;
        Previous=LDR(i);
    end
end
fprintf('\n');
fprintf('Original Packets : %d\n',OriginalPackets);
fprintf('Packets Sent     : %d\n',ReducedPackets);
fprintf('Reduction        : %.2f %%\n', ...
100*(OriginalPackets-ReducedPackets)/OriginalPackets);

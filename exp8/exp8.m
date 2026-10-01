clc;
clear;
close all;

data = csvread('SensorData.csv');
LDR = data(:,1);
POT = data(:,2);

N = length(LDR);
W = 5;
G = floor(N/W);

AvgLDR = zeros(G,1);
AvgPOT = zeros(G,1);
MaxLDR = zeros(G,1);
MinLDR = zeros(G,1);

for i = 1:G
    x = LDR((i-1)*W+1:i*W);
    y = POT((i-1)*W+1:i*W);

    AvgLDR(i) = mean(x);
    AvgPOT(i) = mean(y);
    MaxLDR(i) = max(x);
    MinLDR(i) = min(x);
end

OriginalPackets = N;
AggregatedPackets = G;
PacketReduction = (N-G)/N*100;

figure;
plot(LDR,'LineWidth',1.5);
grid on;
xlabel('Sample Number');
ylabel('LDR Value');
title('Raw LDR Data');

figure;
plot(AvgLDR,'-o','LineWidth',2);
grid on;
xlabel('Aggregation Group');
ylabel('Average LDR');
title('Aggregated LDR Data');

figure;
plot(LDR,'LineWidth',1.2);
hold on;
pos = W/2:W:G*W;
plot(pos,AvgLDR,'-o','LineWidth',2);
grid on;
xlabel('Sample Number');
ylabel('LDR Value');
legend('Raw','Aggregated');

figure;
bar([N G]);
grid on;
set(gca,'XTickLabel',{'Before','After'});
ylabel('Packets');
title('Packet Reduction');
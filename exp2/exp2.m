clc;
clear;
close all;
%% Read Sensor Data
data = csvread('SensorData.csv');
LDR = data(:,1);
POT = data(:,2);
Samples = 1:length(LDR);
%% Plot Sensor Readings
figure;
plot(Samples,LDR,'b','LineWidth',2);
hold on;
plot(Samples,POT,'r','LineWidth',2);
grid on;
xlabel('Sample Number');
ylabel('Sensor Value');
title('Sensor Readings');
legend('LDR','Potentiometer');
%% Protocol Parameters
 
Protocols = {'Bluetooth','ZigBee','LoRa'};
Range = [10 100 15000];          % meters
DataRate = [2 0.25 0.05];        % Mbps
Power = [100 40 25];             % mW
Latency = [10 35 300];           % ms
PDR = [98 98 96];                % %
%% Display Protocol Details
fprintf('\n');
disp('-----------------------------------------------');
disp('      IoT Protocol Simulation');
disp('-----------------------------------------------');
for i = 1:length(Protocols)
    fprintf('\nProtocol : %s\n',Protocols{i});
    fprintf('Range                : %.2f m\n',Range(i));
    fprintf('Data Rate            : %.2f Mbps\n',DataRate(i));
    fprintf('Power Consumption    : %.2f mW\n',Power(i));
    fprintf('Latency              : %.2f ms\n',Latency(i));
    fprintf('Packet Delivery      : %.2f %%\n',PDR(i));
end
%% Communication Range
figure;
bar(Range);
grid on;
title('Communication Range');
ylabel('Range (m)');
set(gca,'XTickLabel',Protocols);
%% Data Rate
figure;
bar(DataRate);
grid on;
title('Data Rate');
ylabel('Mbps');
set(gca,'XTickLabel',Protocols);
%% Power Consumption
figure;
bar(Power);
grid on;
title('Power Consumption');
ylabel('Power (mW)');
set(gca,'XTickLabel',Protocols);
%% Latency
figure;
bar(Latency);
grid on;
title('Latency');
ylabel('Milliseconds');
set(gca,'XTickLabel',Protocols);
%% Packet Delivery Ratio
figure;
bar(PDR);
grid on;
title('Packet Delivery Ratio');
ylabel('PDR (%)');
ylim([90 100]);
set(gca,'XTickLabel',Protocols);
%% Packet Transmission Simulation
disp(' ');
disp('-----------------------------------------');
disp('Packet Transmission');
disp('-----------------------------------------');
for i = 1:length(LDR)
    fprintf('\nPacket %d\n',i);
    fprintf('LDR Value           : %d\n',LDR(i));
    fprintf('Potentiometer Value : %d\n',POT(i));
    fprintf('\n');
    fprintf('Bluetooth  : Packet Sent Successfully\n');
    pause(0.1);
    fprintf('ZigBee     : Packet Sent Successfully\n');
    pause(0.1);
    fprintf('LoRa       : Packet Sent Successfully\n');
    pause(0.1);
end
%% Best Protocol
[~,r]=max(Range);
[~,d]=max(DataRate);
[~,p]=min(Power);
disp(' ');
disp('-----------------------------------------');
fprintf('Best Long Range Protocol : %s\n',Protocols{r});
fprintf('Highest Data Rate        : %s\n',Protocols{d});
fprintf('Lowest Power Protocol    : %s\n',Protocols{p});
disp('-----------------------------------------');
disp('Simulation Completed Successfully');




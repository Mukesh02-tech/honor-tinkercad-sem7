clc;
clear;
close all;
D = 0:10:100;
RSSI = -40-0.5*D;
PDR = 100-0.15*D;
Loss = 100-PDR;
Delay = 10+0.25*D;
fprintf('Distance\tRSSI(dBm)\tPDR(%%)\tLoss(%%)\tDelay(ms)\n');
for i = 1:length(D)
    fprintf('%5d\t\t%6.1f\t\t%6.1f\t%6.1f\t%6.1f\n', ...
        D(i),RSSI(i),PDR(i),Loss(i),Delay(i));
end
figure;
plot(D,RSSI,'-o','LineWidth',2);
grid on;
xlabel('Distance (m)');
ylabel('RSSI (dBm)');
title('RSSI vs Distance');
figure;
plot(D,PDR,'-s','LineWidth',2);
grid on;
xlabel('Distance (m)');
ylabel('Packet Delivery Ratio (%)');
title('PDR vs Distance');
ylim([70 100]);
figure;
plot(D,Loss,'-^','LineWidth',2);
grid on;
xlabel('Distance (m)');
ylabel('Packet Loss (%)');
title('Packet Loss vs Distance');
figure;
plot(D,Delay,'-d','LineWidth',2);
grid on;
xlabel('Distance (m)');
ylabel('Delay (ms)');
title('Communication Delay vs Distance');
fprintf('\nConnectivity Status\n');
for i = 1:length(D)
    if RSSI(i) > -60
        Status = 'Excellent';
    elseif RSSI(i) > -75
        Status = 'Good';
    elseif RSSI(i) > -90
        Status = 'Weak';
    else
        Status = 'Disconnected';
    end
    fprintf('Distance = %3d m   RSSI = %5.1f dBm   %s\n', ...
        D(i),RSSI(i),Status);
end
Duser = input('\nEnter Communication Distance (m): ');
R = -40-0.5*Duser;
P = 100-0.15*Duser;
L = 100-P;
T = 10+0.25*Duser;
fprintf('\nConnectivity Report\n');
fprintf('Distance            : %.1f m\n',Duser);
fprintf('RSSI                : %.2f dBm\n',R);
fprintf('PDR                 : %.2f %%\n',P);
fprintf('Packet Loss         : %.2f %%\n',L);
fprintf('Communication Delay : %.2f ms\n',T);
if R > -60
    disp('Link Quality : Excellent');
elseif R > -75
    disp('Link Quality : Good');
elseif R > -90
    disp('Link Quality : Weak');
else
    disp('Link Quality : Connection Lost');
end
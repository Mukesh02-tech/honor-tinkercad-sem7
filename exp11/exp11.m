clc;
clear;
close all;
N = 50;
pot = zeros(1,N);
RSSI = zeros(1,N);
zone = zeros(1,N);
for i = 1:N
    pot(i) = randi([0 1023]);
    RSSI(i) = -40 - pot(i)/1023*50;
    if RSSI(i) >= -50
        zone(i) = 1;
        location = 'Zone 1 - Very Near';
    elseif RSSI(i) >= -60
        zone(i) = 2;
        location = 'Zone 2 - Near';
    elseif RSSI(i) >= -70
        zone(i) = 3;
        location = 'Zone 3 - Medium';
    elseif RSSI(i) >= -80
        zone(i) = 4;
        location = 'Zone 4 - Far';
    else
        zone(i) = 5;
        location = 'Zone 5 - Very Far';
    end
    fprintf('Sample %2d | Potentiometer = %4d | RSSI = %6.2f dBm | %s\n', ...
        i,pot(i),RSSI(i),location);

    pause(0.2);
end
figure;
plot(pot,'o-','LineWidth',1.5);
grid on;
xlabel('Sample Number');
ylabel('Potentiometer Value');
title('Simulated Potentiometer Sensor Data');
figure;
plot(RSSI,'o-','LineWidth',1.5);
hold on;
plot([1 N],[-50 -50],'--');
plot([1 N],[-60 -60],'--');
plot([1 N],[-70 -70],'--');
plot([1 N],[-80 -80],'--');
grid on;
xlabel('Sample Number');
ylabel('RSSI (dBm)');
title('Simulated BLE Signal Strength');
figure;
stairs(zone,'LineWidth',2);
grid on;
xlabel('Sample Number');
ylabel('Localization Zone');
title('IoT Device Localization Based on BLE RSSI');
set(gca,'YTick',1:5);
set(gca,'YTickLabel',{'Very Near','Near','Medium','Far','Very Far'});
ylim([0.5 5.5]);
clc;
clear;
close all;

%% Read Sensor Data

data = csvread('SensorData.csv');

LDR = data(:,1);
POT = data(:,2);

%% Display Original Data

disp('Original Sensor Data');
disp('LDR        POT');

disp([LDR POT]);

%% Encryption Key

Key = 85;       % Decimal key

%% Encrypt Sensor Data

EncryptedLDR = bitxor(uint16(LDR), uint16(Key));
EncryptedPOT = bitxor(uint16(POT), uint16(Key));

disp(' ');
disp('Encrypted Data');
disp('Encrypted LDR        Encrypted POT');

disp([double(EncryptedLDR) double(EncryptedPOT)]);

%% Decrypt Data

DecryptedLDR = bitxor(EncryptedLDR, uint16(Key));
DecryptedPOT = bitxor(EncryptedPOT, uint16(Key));

disp(' ');
disp('Decrypted Data');
disp('Decrypted LDR        Decrypted POT');

disp([double(DecryptedLDR) double(DecryptedPOT)]);

%% Integrity Verification

if isequal(LDR,double(DecryptedLDR)) && ...
   isequal(POT,double(DecryptedPOT))

    disp(' ');
    disp('Integrity Verification : SUCCESS');

else

    disp(' ');
    disp('Integrity Verification : FAILED');

end

%% Visualization

figure;

subplot(2,1,1);

plot(LDR,'LineWidth',2);
hold on;

plot(double(DecryptedLDR),'--','LineWidth',2);

grid on;

title('Original vs Decrypted LDR');
xlabel('Sample');
ylabel('LDR Value');

legend('Original','Decrypted');

subplot(2,1,2);

plot(POT,'LineWidth',2);
hold on;

plot(double(DecryptedPOT),'--','LineWidth',2);

grid on;

title('Original vs Decrypted Potentiometer');
xlabel('Sample');
ylabel('POT Value');

legend('Original','Decrypted');
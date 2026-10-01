clc;
clear;
close all;
[FileName,FilePath] = uigetfile('*.csv','Select SensorData.csv');
if isequal(FileName,0), return; end
data = csvread(fullfile(FilePath,FileName));
LDR = data(:,1);
POT = data(:,2);
N = length(LDR);
DeviceID = 'NODE001';
Location = 'IoT Laboratory';
Unit = 'Sensor Value';
Timestamp = now+(0:N-1)'/(24*60);
fprintf('Input File : %s\n',FileName);
fprintf('Number of Sensor Samples : %d\n',N);
fprintf('\nLDR Annotated Data\n');
fprintf('DeviceID\tTimestamp\tLocation\tSensor\tUnit\tValue\n');
for i = 1:N
    fprintf('%s\t%.6f\t%s\tLDR Sensor\t%s\t%.2f\n', ...
        DeviceID,Timestamp(i),Location,Unit,LDR(i));
end
fprintf('\nPotentiometer Annotated Data\n');
fprintf('DeviceID\tTimestamp\tLocation\tSensor\tUnit\tValue\n');
for i = 1:N
    fprintf('%s\t%.6f\t%s\tPotentiometer\t%s\t%.2f\n', ...
        DeviceID,Timestamp(i),Location,Unit,POT(i));
end
OutputFolder = uigetdir(FilePath,'Select Folder to Save Annotated Data');
if isequal(OutputFolder,0), return; end
LDRFile = fullfile(OutputFolder,'Annotated_LDR_Data.csv');
POTFile = fullfile(OutputFolder,'Annotated_POT_Data.csv');
fid = fopen(LDRFile,'w');
fprintf(fid,'DeviceID,Timestamp,Location,Sensor,Unit,Value\n');
for i = 1:N
    fprintf(fid,'%s,%.6f,%s,LDR Sensor,%s,%.2f\n', ...
        DeviceID,Timestamp(i),Location,Unit,LDR(i));
end
fclose(fid);
fid = fopen(POTFile,'w');
fprintf(fid,'DeviceID,Timestamp,Location,Sensor,Unit,Value\n');
for i = 1:N
    fprintf(fid,'%s,%.6f,%s,Potentiometer,%s,%.2f\n', ...
        DeviceID,Timestamp(i),Location,Unit,POT(i));
end
fclose(fid);
fprintf('\nAnnotated Data Saved Successfully\n');
fprintf('LDR File : %s\n',LDRFile);
fprintf('POT File : %s\n',POTFile);
figure;
plot(LDR,'LineWidth',1.5);
grid on;
xlabel('Sample Number');
ylabel('LDR Sensor Value');
title('Raw LDR Data');
figure;
plot(LDR,'-o','LineWidth',1.5);
grid on;
xlabel('Sample Number');
ylabel('LDR Sensor Value');
title('LDR Data after Semantic Annotation');
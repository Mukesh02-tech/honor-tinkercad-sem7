clc;
clear;
close all;
CurrentVersion = 1.2;
LatestVersion = 1.5;
fprintf('Current Firmware Version : %.1f\n',CurrentVersion);
fprintf('Latest Firmware Version  : %.1f\n',LatestVersion);
if LatestVersion > CurrentVersion
    disp('New Firmware Available');
    disp('Checking Update...');
    pause(1);
    disp('Downloading Firmware...');
    pause(2);
    DownloadStatus = 1;
    ChecksumServer = 54893;
    ChecksumDownloaded = 54893;
    if DownloadStatus && ChecksumServer == ChecksumDownloaded
        disp('Firmware Integrity Verified');
        pause(1);
        disp('Installing Firmware...');
        pause(2);
        CurrentVersion = LatestVersion;
        disp('Restarting IoT Device...');
        pause(2);
        disp('Firmware Update Successful');
    else
        disp('Firmware Verification Failed');
    end
else
    disp('Device Already Updated');
end
fprintf('Current Firmware Version : %.1f\n',CurrentVersion);
Stages = {'Check','Download','Verify','Install','Restart','Complete'};
Progress = [10 30 50 70 90 100];
figure;
plot(Progress,'-o','LineWidth',2);
grid on;
set(gca,'XTick',1:6,'XTickLabel',Stages);
xlabel('Firmware Update Stages');
ylabel('Completion (%)');
title('Firmware Update Progress');
figure;
pie([1 5],{'Updated','Remaining Tasks'});
title('Firmware Update Status');
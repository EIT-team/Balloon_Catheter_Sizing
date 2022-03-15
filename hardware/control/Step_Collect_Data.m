%% Settings
Frames=1; % how many EIT frames to collect each move - 3 for EIT and 10? for 4Elec
StepsPerFrame=1500; % how many steps on the actuator between each move
Moves=10; % how many FORWARD moves (stepper movements) to do
EITdelay=0.01; % how much time to wait to collect EIT data - check on Eliko software % 2 FOR EIT AND 0.5 FOR SIMPLE 4ELEC

TotalSteps=Moves*StepsPerFrame;

fname='TEST';

fprintf('Doing %d moves of %d steps, %d total\n',Moves,StepsPerFrame,TotalSteps);

%% connect to arduinos

disp(["Ports available:" serialportlist("available")]);

fprintf('Connecting to arduinos...');

ArdMicro=serialport("COM6",115200);
UStepper=serialport("COM7",115200);
pause(1);
flush(ArdMicro);
flush(UStepper);

pause(1);
flush(UStepper);
pause(1);
flush(UStepper);
fprintf('done!\n');

%% create log file


fid=fopen(['logs\' fname datestr(datetime,30) '.txt'],'w');

fprintf(fid,'# Control log data for syringe pump %s\n',datetime);
fprintf(fid,'# StepsPerRotation %d, Moves %d, Total steps %d,  Frames %d, EITDelay %d\n',StepsPerFrame,Moves,TotalSteps,Frames,EITdelay);
fprintf(fid,'# Time\tSteps\tPressure\tComment\n');

%% initialise

curSteps=0;
pressure=0;
tstart=tic;

pReps=10;
direction=1;

curPressure=zeros(pReps,1);

flush(ArdMicro);
flush(UStepper);

[pressure, UPressErr]=UStepperGetPressure(UStepper);

elapsed=toc(tstart);

fprintf(fid,'%f,%d,%f,%s\n',elapsed,curSteps,pressure,'start');

%% run the loop

for iMove = 1:(Moves*2)
    fprintf('Move %d ',iMove);
    % trigger EIT
    fprintf('EIT...');
    for iFrame = 1:Frames
        AMerr=TriggerEliko(ArdMicro);
        if AMerr
            disp("Pro Micro Error!");
            break
        end
        pause(EITdelay);
    end
    fprintf('pressure...');
    
    % get pressure
    for iRep = 1:pReps
        flush(UStepper);
        [curPressure(iRep), UPressErr] = UStepperGetPressure(UStepper);
        pressure=mean(curPressure);
    end
    
    if (UPressErr)
        disp("Ustepper Pressure Error!");
        break
    end
    fprintf('done\n');
    
    %move motor
    flush(UStepper);
    if (direction)
        USerr=UStepperMoveSteps(UStepper,StepsPerFrame);
        curSteps=curSteps+StepsPerFrame;
    else
        USerr=UStepperMoveSteps(UStepper,-StepsPerFrame);
        curSteps=curSteps-StepsPerFrame;
    end
    
    if USerr
        disp("Ustepper Error!");
        break
    end
    
    if (iMove>=Moves)
        direction=0;
    end
    
    elapsed=toc(tstart);    
    fprintf(fid,'%f,%d,%f,%s\n',elapsed,curSteps,pressure,'');

    
end
fprintf('All Done!\n');

%% close things nicely
fclose(fid);
clear UStepper
clear ArdMicro




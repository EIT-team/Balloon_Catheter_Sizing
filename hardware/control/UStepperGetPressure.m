function [pressure,err] = UStepperGetPressure(ArdObject)
%USTEPPERGETPRESSURE Summary of this function goes here
%   Detailed explanation goes here


% Note from Mark: I deleted unused "inputArg2" from function declaration -
% 30/09/21
% Also noticed that just the pressure was being saved to a variable in main
% code, "err" wasn't being assigned.

pressure=0;
err=0;


write(ArdObject,"p",'char');

while(ArdObject.NumBytesAvailable < 2)
end

instr=readline(ArdObject);
% fprintf(instr);
if strtrim(instr) ~= "p"
    err=1;
    fprintf("instr: %s",instr);
    
    return
end

instr=readline(ArdObject);

pressure=str2double(instr);

end


function [err] = UStepperMoveSteps(ArdObject,Steps)
%USTEPPERMOVESTEPS Summary of this function goes here
%   Detailed explanation goes here

err =0;
Direction = Steps > 0;

fprintf('Moving motor ');
if (Direction)
write(ArdObject,"4",'char');
fprintf('forwards ');
else
    write(ArdObject,"5",'char');
    fprintf('backwards ');
end

while (ArdObject.NumBytesAvailable < 5)
end


instr=read(ArdObject,ArdObject.NumBytesAvailable,'char');
%fprintf(instr);
%disp(strtrim(instr))

write(ArdObject,num2str(abs(Steps)),'char');

while (ArdObject.NumBytesAvailable < 1)
end

instr=readline(ArdObject);
%fprintf(strtrim(instr));
% disp(strtrim(instr))

if strtrim(instr) ~= "f"
    err=1;
end
fprintf(' done!\n');

end


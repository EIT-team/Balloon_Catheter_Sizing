function [err] = TriggerEliko(ArdObject)
%TRIGGERELIKO Summary of this function goes here
%   Detailed explanation goes here

sentbyte=1;

write(ArdObject,sentbyte,"uint8");
in=read(ArdObject,1,"uint8");


err= ~(in == sentbyte);


end


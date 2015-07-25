a=load('frontCount.mat');
b=load('frontLength.mat');
frontMarkerCount=a.frontMarkerCount;
frontMarkerLength=b.frontMarkerLength;

% cdfplot(frontMarkerCount);
% cdfplot(frontMarkerLength);

[MUHAT,SIGMAHAT] = normfit(frontMarkerCount);
cdfplot(frontMarkerCount);



%{
data = importdata('106_5.txt');
x = data(:, 1);
y = data(:, 2);
plot(x, y, 'b-', 'LineWidth', 2);
x=0:0.1:200*pi 
y = sin(x)
curve= animatedline('color','b') ;
for i=1:length(x)
    addpoints(curve,x(i),y(i))
    drawnow
end    
title('ECG Signal', 'FontSize', 20);
xlabel('Time', 'FontSize', 20);
ylabel('Voltage', 'FontSize', 20);
%}

%{
% Generates a random signal to display
a = randn(1,1e5);
a = cumsum(a);  %I want some correlation in the signal...
fs = 2e3;  %sampling frequency
timeBase = 2;   %sec
hF = figure;
hAx = gca;
N = length(a);
maxA = max(a);  minA = min(a);
nSamples = round(fs*timeBase);
ind = 1;
hLine = plot(hAx,(1:nSamples)/fs,a(:,ind:ind+nSamples-1));
xlabel('[sec]');
ylim([minA maxA]);
tic;    %start time measuring
% I added the "ishandle" so the program will end in case u closed the figure
while (ind < N-nSamples) & ishandle(hLine)
  
   %instead of using plot I directly change the data in the line
   % this is faster the plot if only because you don't need to reedefine the limits and labels...
   set(hLine,'ydata',a(:,ind:ind+nSamples-1));
   
   drawnow  %updates the display
   
   t = toc; %measuring current time
   ind = round(t*fs); 
   ind = max(ind,1);
   
end
%}
data = importdata('106_5.txt');
x = data(:, 1);
y = data(:, 2);

figure;  % create a figure
hold on;  % turn hold on
i=1
while(1)
time=x(i);
volt=y(i);
plot(time,volt);
i=i+1;

end % whileloop
function ET_serial = eyeTrackerCalibration()
% USAGE: ET_serial = eyeTrackerCalibration
%
% The function runs calibration and validation and returns a serial
% port object.
% You can work with this object later with other Matlab functions as you
% like (e.g., to run your experiment).

disp('eyeTrackerCalibration is running...');


% Enable unified mode of KbName, so KbName accepts identical key names on
% all operating systems (not absolutely necessary, but good practice):
KbName('UnifyKeyNames');

%The very first call to KbCheck takes itself some time - after this it
%is in the cache and very fast, we  call it here once for no other
%reason than to get it cached.
KbCheck;

% Do dummy calls to GetSecs, WaitSecs, to make sure
% they are loaded and ready when we need them - without delays
% in the wrong moment:
WaitSecs(0.1);
GetSecs;

% Open screen

%Choosing the display with the highest display number is
%a best guess about where you want the stimulus displayed.
%usually there will be only one screen with id = 0, unless you use a
%multi-display setup:
screens = Screen('Screens');
screen_num = max(screens);

white_color = 255;
black_color = 0;
blue_color = [0 0 255];
bg_color = white_color; % set background (white)
fg_color = black_color; % set foreground color (Black)
Screen('CloseAll'); % just in case
Screen('Preference', 'SkipSyncTests',0); % maximum accuracy

[exp_win scr_rect] = Screen('OpenWindow',screen_num,[bg_color bg_color bg_color]); % Open window
% [exp_win scr_rect] = Screen('OpenWindow',screen_num,[bg_color bg_color bg_color],[0 0 800 600]); % Open window

% Display the opened screen
Screen(exp_win,'Flip');

% Hide cursor again
HideCursor;

% Open eye tracker serial port
ET_serial = serial('COM1','BaudRate',115200,'Databits',8);
fopen(ET_serial); % Open serial port
fprintf(ET_serial,'ET_CLR'); % Clear recording buffer

% Calibration parameters
PARAMS.npoints = 9;
PARAMS.calibarea = [800 600];
PARAMS.bgcolour = [255 255 255]; % set background (white)
PARAMS.targcolour = [0 0 0]; % set foreground color (Black)

% Do fullCalibrationRoutine
fullCalibrationRoutine(exp_win,ET_serial,PARAMS);

% Close eye tracker serial port
% fclose(ET_serial);

% Close screen
Screen('CloseAll');

% Show cursor again
ShowCursor;

disp('eyeTrackerCalibration is complete.');

% Run through calibration and validation with feedback for accepting
% and rejecting.
% success = fullCalibrationRoutine(window,ET_serial,varargin);
function success = fullCalibrationRoutine(window,ET_serial,PARAMS)

% Screen settings
sc = Screen('Resolution',window);
schw = [sc.width sc.height];
KbName('UnifyKeyNames');

% Default parameters
if ~exist('PARAMS','var')
    PARAMS.targsize = 10;
    PARAMS.acceptkey = KbName('space');
    PARAMS.quitkey = KbName('escape');
    PARAMS.skipkey = KbName('s');
    PARAMS.waitforvalid = 1;
    PARAMS.randompointorder = 0;
    PARAMS.autoaccept = 1;
    PARAMS.checklevel = 2;
    PARAMS.textwaitdur = 5; % s
end

txtwrap = 50;
vspacing = 1.5;
ET_params = struct;
respy = KbName('y');
respn = KbName('n');

Screen(window,'FillRect',PARAMS.bgcolour);
DrawFormattedText(window,['Follow the target as it moves around '...
    'the screen.'],'center','center',PARAMS.targcolour,txtwrap,0,0, ...
    vspacing);
Screen(window,'Flip');
success = 0;
[response is_quit] = waitRespAlts([PARAMS.acceptkey,PARAMS.skipkey],PARAMS.quitkey,PARAMS.textwaitdur);
if response==2 || is_quit == 1
    return
end

DrawFormattedText(window,'Calibration will start in a moment',...
    'center','center',PARAMS.targcolour,txtwrap,0,0,vspacing);
Screen(window,'Flip');

% to release key
WaitSecs(.2);
ready = 0;
while ~ready
	success = calibrateEyeTracker(window,ET_serial,PARAMS);
	if success
		validateCalibration(window,ET_serial,PARAMS);
	end
	DrawFormattedText(window,'Calibration ok?','center','center',...
		PARAMS.targcolour,txtwrap,0,0,vspacing);
	Screen(window,'Flip');
	response = waitRespAlts([respy respn]);
	if response == 1
		ready = 1;
		success = 1;
	else
		DrawFormattedText(window,'Try again?','center','center',...
			PARAMS.targcolour,txtwrap,0,0,vspacing);
		Screen(window,'Flip');
		resp2 = waitRespAlts([respy respn]);
		if resp2 == 2
			ready = 1;
			success = 0;
		end
	end
end

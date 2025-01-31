function CreateRingAndWedgeStim(StimName,RingOrWedge,TR)
%CREATEEIGHTBARSSTIM Summary of this function goes here
%   Detailed explanation goes here

params = retCreateDefaultGUIParams; 

% modify them
if strcmp(RingOrWedge,'ring')
params.experiment       =  'expanding ring with blanks (45% duty)';
elseif strcmp(RingOrWedge,'wedge')
params.experiment       =  'rotating wedge with blanks (45deg duty)';    
else
   % Set params.experiment to "wedgesrings" to alternate wedges and rings
   % or "wedgesringsalt" to also alternate wedge direction and
   % "wedgesringsaltnojump" to also alternate ring direction
   params.experiment       = RingOrWedge;
end
%params.experiment       =  'experiment from file';
params.fixation         =  'my thin cross';%'disk'; % edit in retSetFixationParams.m
params.modality         =  'fMRI';
%params.savestimparams   =  0;
params.savestimparams   =  1;
params.repetitions      =  1;  
params.runPriority      =  7;
params.skipCycleFrames  =  0;
params.prescanDuration  =  0;  
params.period           =  36;%35%280;%288; %In Reality the stimulus is 336 seconds long, because of the 4 * 12s long blanks which are inserted after each diagonal;
params.numCycles        =  8;%1;
params.motionSteps      =  2;
params.tempFreq         =  4;
params.contrast         =  1;
params.interleaves      =  [];
params.tr               =  TR;
params.loadMatrix       =  [];
%params.loadMatrix       =  ['/Users/fmri/Dropbox/measurementlaptop/images/',StimName,'_images.mat'];
%params.saveMatrix       =  [];
params.saveMatrix       =  [datestr(now,30),'_',StimName,'_tr',num2str(TR),'_images.mat'];
params.calibration      =  []; % Was calibrated with Photometer --> TODO - so that stimSize really corresponds to ? visual angle
%params.calibration      =  '3T2_projector_800x600temp';
params.stimSize         =  'max';%5/2%5%5.5;%'max';%6;9
%params.FixationandBackgroundSize = 5;
params.triggerKey       =  'Manual';%'6'; % For different trigger device see pressKey2Begin.m
%params.trigger          = '5';
params.BackgroundFullscreen = 0;



% % modify them
% %params.experiment       =  'multifocal';
% params.experiment       =  'stationary top wedge, on-off, 45';
% %params.experiment       =  'stationary double-wedge, on-off, 45';
% %params.experiment       =  'full-field, on-off';
% %params.experiment       =  'experiment from file';
% params.fixation         =  'disk'; % edit in retSetFixationParams.m
% params.modality         =  'fMRI';
% params.savestimparams   =  1;
% %params.savestimparams   =  0;
% params.repetitions      =  1;  
% params.runPriority      =  7;
% params.skipCycleFrames  =  0;
% params.prescanDuration  =  0;  
% params.period           =  18; %Period of on+off
% params.numCycles        =  15; %How often is the Stimulus presented during one run
% params.motionSteps      =  2;
% params.tempFreq         =  4;
% params.contrast         =  1;
% params.interleaves      =  [];
% params.tr               =  TR;
% params.loadMatrix       =  [];
% %params.loadMatrix       =  ['/Users/fmri/Dropbox/measurementlaptop/images/',StimName,'_images.mat'];
% %params.saveMatrix       =  [];
% params.saveMatrix       =  [datestr(now,30),'_',StimName,'_images'];
% params.calibration      =  []; % Was calibrated with Photometer
% %params.calibration      =  '3T2_projector_800x600temp';
% params.stimSize         =  'max';
% params.triggerKey       =  '6'; % For different trigger device see pressKey2Begin.m
% %params.trigger          = '5';


%Get Stimulus Resolution (values from setDefaultDisplay)


display.screenNumber = max(Screen('screens'));
[width, height] = Screen('WindowSize',display.screenNumber);
display.numPixels       = [width height];
display.dimensions      = [24.6 18.3];
display.pixelSize       = min(display.dimensions./display.numPixels);
display.distance        = 43.0474; 

if ischar(params.stimSize) %Set ImageSize to maximum
    params.ImageSize = floor(min(display.numPixels));
else
    params.ImageSize = round(2 * angle2pix(display, params.stimSize));		
end

if isfield(params,'FixationandBackgroundSize') && params.FixationandBackgroundSize~=0
    params.FixationandBackgroundImageSize=round(2 * angle2pix(display, params.FixationandBackgroundSize));  
end





%Gesichtsfeldausfall (Gesichtsfeld = 800x800)


% %Cross Fixation
% 
% 
% DiagVektor=ones(ImageSize,1);
% DiagMatrix=diag(DiagVektor,0);
% Thickness=2;
% 
% %Thickness upwards
% for i=1:Thickness/2
% 
%    DiagMatrix=DiagMatrix+diag(DiagVektor(1:end-i),i);
% 
% end
% 
% %Thickness downwards
% 
% for k=1:Thickness/2
% 
%    DiagMatrix=DiagMatrix+diag(DiagVektor(1:end-k),-k);
% 
% end
% 
% DiagMatrix=DiagMatrix+fliplr(DiagMatrix);
% 
% params.DiagMatrix=DiagMatrix;



% %Arrow Fixation
% 

% Resolution=1024;
% BlankVectorThickness=100;
% 
% DiagVektor=ones(Resolution,1);
% 
% DiagVektor(BlankVectorThickness:end-BlankVectorThickness)=0;
% 
% DiagMatrix=diag(DiagVektor,0);
% 
% 
% 
% Thickness=50;
% 
% %Thickness upwards
% for i=1:Thickness/2
% 
%     DiagMatrix=DiagMatrix+diag(DiagVektor(1:end-i),i);
% 
% end
% 
% %Thickness downwards
% 
% for k=1:Thickness/2
% 
%     DiagMatrix=DiagMatrix+diag(DiagVektor(1:end-k),-k);
% 
% end
% 
% DiagMatrix=DiagMatrix+fliplr(DiagMatrix);
% DiagMatrix=DiagMatrix+flipud(DiagMatrix);
% DiagMatrix(DiagMatrix==1)=0;
% %figure; imagesc(DiagMatrix)
% 
% params.DiagMatrix=DiagMatrix;


%Ausfall linker unterer Quadrant

%params.xfailure= 1:512;
%params.yfailure= 512:1024;

%Ausfall linker oberer Quadrant

%params.xfailure= 1:512;
%params.yfailure= 1:512;


%Ausfall von 1 Balken
%params.xfailure= 334:434;
%params.yfailure= 1:768;

%Ausfall alles au?er 1 Balken
%params.xfailure= [1:334,434:768];
%params.yfailure= 1:768;
%params.xfailure= [1:384,640:1024];
%params.yfailure= 1:1024;

%Ausfall von einem Kreis

% %resolution= 1024 * 768 (size stimulus = 384)
% %r=64;
% %xm=512;
% %ym=512;
% r=(params.ImageSize/2)/3.5; %r=2? scotoma for 7T 
% xm=params.ImageSize/2;
% ym=params.ImageSize/2;
%  
% params.mycircle='full';
% params.myradius=r;
% params.xfailure=xm;
% params.yfailure=ym;

% % %Fixation
%   r=128;
%   xm=10;%512;
%   ym=10;%512;
%   
%   xm2=1024-10;%512;
%   ym2=10;%512;
%   
%   xm3=10;%512;
%   ym3=1024-10;%512;
%   
%   xm4=1024-10;%512;
%   ym4=1024-10;%512;
%   
%  %Parameter setzen
% 
%  params.mycircle='full';
%  params.myradius=r;
%  params.xfailure=xm;
%  params.yfailure=ym;
%  
%  params.xfailure2=xm2;
%  params.yfailure2=ym2;
% 
%  params.xfailure3=xm3;
%  params.yfailure3=ym3;
%  
%  params.xfailure4=xm4;
%  params.yfailure4=ym4;

%resolution= 1024 * 768 (size stimulus = 384)
% r=192;
% xm=384;
% ym=384;

% params.mycircle='fullhalfleft';
% params.myradius=r;
% params.xfailure=xm;
% params.yfailure=ym;

% r=192;
% xm=384;
% ym=384;
% 
% params.mycircle='fullhalfright';
% params.myradius=r;
% params.xfailure=xm;
% params.yfailure=ym;

%Ausfall alles au?er einem Kreis

%  r=192;
%  xm=384;
%  ym=384;
%  
%  params.mycircle='empty';
%  params.myradius=r;
%  params.xfailure=xm;
%  params.yfailure=ym;

%  r=192;
%  xm=384;
%  ym=384;
%  
%  params.mycircle='emptyhalfleft';
%  params.myradius=r;
%  params.xfailure=xm;
%  params.yfailure=ym;

%  r=192;
%  xm=384;
%  ym=384;
%  
%  params.mycircle='emptyhalfright';
%  params.myradius=r;
%  params.xfailure=xm;
%  params.yfailure=ym;


% run it


ret(params)



end


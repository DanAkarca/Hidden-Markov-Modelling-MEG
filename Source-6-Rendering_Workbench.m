%% Source level analysis: Rendering of GLEAN HMM spatial maps
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience

%  This is to generate surface rendered maps to mask onto templates onto a relevant software e.g. workbench
%  Inputs for this arise from a statistical test e.g. from my GLEAN_results script
%  These include partial correlations, powers and state-wise powers between groups and intra-group 
%% Adding prerequisites 
clear classes;
clc;

% OSL, GLEAN and workbench

osldir        = '/imaging/da04/Toolboxes/osl1.4.0';
GLEANdir      = '/home/da04/Documents/GLEAN_analysis_Group/GLEAN-master';
Workbenchdir  = '/home/da04/Documents/workbench/bin_rh_linux64/';
Functionsdir  = '/home/da04/Documents/Visualisations/Functions';

addpath(osldir);
addpath(GLEANdir);
addpath(Workbenchdir);
addpath(Functionsdir);

osl_startup(osldir);

mainDir       = '/home/da04/Documents/Visualisations';
cd (mainDir);
clc;

%% Take absolute values of maps, and write it into the cd

% Ensure maps from GLEAN is within the current directory
% The map can be saved with a new name

% These are commonly refered to later, so keep in mind

% Location of files to render:
FilesToRender        = '/home/da04/Documents/Visualisations/GLEAN_map_outputs/'; % All GLEAN map outputs
% Location to save files: 
Seperated_Files      = '/home/da04/Documents/Seperation_of_States/Seperated_States';
% Mask location
MaskFile             = '/home/da04/Documents/GLEAN_analysis_Group/masks/MNI152_T1_8mm_brain.nii.gz';

% Map names: 

ControlMapNames      = {'Control_pcorr_0-InfHz.nii.gz',...
                        'Control_connectivity_profilenii.nii.gz'};
                   

PatientMapNames      = {'ZDHHC9_pcorr_0-InfHz.nii.gz',...
                        'ZDHHC9_connectivity_profilenii.nii.gz'};
                    
GroupMapNames        = {'Group_pcorr_0-InfHz.nii.gz',...
                        'Group_connectivity_profilenii.nii.gz',...
                        'Group_power_0-InfHz.nii.gz',...
                        'Group_state_power_0-InfHz.nii.gz'};
                    
AllMapNames          = [GroupMapNames ControlMapNames PatientMapNames]; % Put in the inputs and outputs you want
    
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note to future self...

% Check each setting is refering to what you want them to be refering to
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               
%% Ensure brain activation patterns are all positive (if we want) and write file to output folder

% Do this for all analysisNames and analysisOutputs above
% Ensure it is saved in the correct place

analysisName    = AllMapNames;
analysisOutput  = {'State1_PCORR.nii.gz',...
                   'State2_PCORR.nii.gz',...
                   'State3_PCORR.nii.gz',...
                   'State4_PCORR.nii.gz',...
                   'State5_PCORR.nii.gz',...
                   'State6_PCORR.nii.gz',...
                   'State7_PCORR.nii.gz',...
                   'State8_PCORR.nii.gz'};
                   
WhereToSave     = Saved_Files;
cd(WhereToSave);

Map  = readnii(fullfile(FilesToRender,analysisName{1}),MaskFile);
Map_1 = Map(:,1);
Map_2 = Map(:,2);
Map_3 = Map(:,3);
Map_4 = Map(:,4);
Map_5 = Map(:,5);
Map_6 = Map(:,6);
Map_7 = Map(:,7);
Map_8 = Map(:,8);

%Map = abs(Map); % Comment this out if we dont want to modular the files

writenii(Map_1,fullfile(Saved_Files,analysisOutput{1}),MaskFile);
writenii(Map_2,fullfile(Saved_Files,analysisOutput{2}),MaskFile);
writenii(Map_3,fullfile(Saved_Files,analysisOutput{3}),MaskFile);
writenii(Map_4,fullfile(Saved_Files,analysisOutput{4}),MaskFile);
writenii(Map_5,fullfile(Saved_Files,analysisOutput{5}),MaskFile);
writenii(Map_6,fullfile(Saved_Files,analysisOutput{6}),MaskFile);
writenii(Map_7,fullfile(Saved_Files,analysisOutput{7}),MaskFile);
writenii(Map_8,fullfile(Saved_Files,analysisOutput{8}),MaskFile);

%% Render using osl_render4Dhl, then visualise with workbenchviewhl (or just GUI)

Outputs         = AllOutputs ; % Pick one of ControlOutputs, PatientOutputs, GroupOutputs or AllOutputs

WhereToSave     = NonAbs_RenderedFiles; % Pick one of Abs_RenderedFiles or NonAbs_RenderedFiles

cd(WhereToSave);

% ~ 5-10 mins per file

for i = 1:length(Outputs);

myNetworkFile   = fullfile(WhereToSave, Outputs{i});
resultFile      = fullfile(WhereToSave, Outputs{i});
interpMethod    = 'trilinear';
visualise       = 0;

osl_render4Dhl(myNetworkFile, resultFile, Workbenchdir, interpMethod, visualise);
end

% ** The outputs with dt_series are the ones of importance ** 
% We'll copy them into a seperate folder so it is not so messy

% The directory where all files have been saved
cd(WhereToSave);

% Location of where final dt_series files will be saved
% These will be able to be masked onto templates in workbench

dt_Files = '/home/da04/Documents/Visualisations/dt_series/';

S        = dir('*dtseries.nii');
N        = {S.name};
for i    = 1:length(N);
N(i)     = fullfile(WhereToSave,N(i));
copyfile(N{i},dt_Files);
end

% These dt outputs can be visualised with workbenchviewhl, or a GUI
% If it provides an error / does not open, use GUI in windows or mac

cd(dt_Files);

%c.left  = 'Control_PCORR_left.dtseries.nii';
%c.right = 'Control_PCORR_right.dtseries.nii'
%workbenchviewhl(c,Workbenchdir);

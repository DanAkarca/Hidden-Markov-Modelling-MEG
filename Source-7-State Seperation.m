%% Source level analysis: Seperating states
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%% Adding prerequisites 

clear classes;
clc;

% OSL, GLEAN and workbench

osldir        = '/imaging/da04/Toolboxes/osl2.0.3.2';
GLEANdir      = '/home/da04/Documents/GLEAN_analysis_Group/GLEAN-master';
Workbenchdir  = '/home/da04/Documents/workbench/bin_rh_linux64/';
Functionsdir  = '/home/da04/Documents/Visualisations/Functions';
fslDir        = '/imaging/local/software/fsl/v5.0.6/x86_64/fsl/bin/fsl';

addpath(osldir);
addpath(GLEANdir);
addpath(Workbenchdir);
addpath(Functionsdir);
addpath(fslDir);

osl_startup(osldir);

mainDir       = '/home/da04/Documents/Seperation_of_States';
cd (mainDir);
clc;

%% Take absolute values of maps, and write it into the cd

% Ensure maps from GLEAN is within the current directory
% The map can be saved with a new name

% These are commonly refered to later, so keep in mind

% Location of files to render:
Files                = '/home/da04/Documents/Visualisations/GLEAN_map_outputs/'; % All GLEAN map outputs
% Location to save files: 
Seperated_Files      = '/home/da04/Documents/Seperation_of_States/Seperated_States';

%% Seperating states: IGNORE once done

% Do this for all analysisNames and analysisOutputs above
% Ensure it is saved in the correct place

cd(Seperated_Files);

Map  = nii_quickread(fullfile(Files,'Group_pcorr_0-InfHz.nii.gz'),8);
Map_1 = Map(:,1);
Map_2 = Map(:,2);
Map_3 = Map(:,3);
Map_4 = Map(:,4);
Map_5 = Map(:,5);
Map_6 = Map(:,6);
Map_7 = Map(:,7);
Map_8 = Map(:,8);

%Map = abs(Map); % Comment this out if we dont want to modular the files

% Here we seperate out the states and save in a mm resolution we want

% analysisOutput  = {'State1_PCORR_2mm.nii.gz',...
%                   'State2_PCORR_2mm.nii.gz',...
%                   'State3_PCORR_2mm.nii.gz',...
%                   'State4_PCORR_2mm.nii.gz',...
%                   'State5_PCORR_2mm.nii.gz',...
%                   'State6_PCORR_2mm.nii.gz',...
%                   'State7_PCORR_2mm.nii.gz',...
%                   'State8_PCORR_2mm.nii.gz'};
               
% savedResolution = 2;

% nii_quicksave(Map_1,fullfile(Seperated_Files,analysisOutput{1}),8,savedResolution);
% nii_quicksave(Map_2,fullfile(Seperated_Files,analysisOutput{2}),8,savedResolution);
% nii_quicksave(Map_3,fullfile(Seperated_Files,analysisOutput{3}),8,savedResolution);
% nii_quicksave(Map_4,fullfile(Seperated_Files,analysisOutput{4}),8,savedResolution);
% nii_quicksave(Map_5,fullfile(Seperated_Files,analysisOutput{5}),8,savedResolution);
% nii_quicksave(Map_6,fullfile(Seperated_Files,analysisOutput{6}),8,savedResolution);
% nii_quicksave(Map_7,fullfile(Seperated_Files,analysisOutput{7}),8,savedResolution);
% nii_quicksave(Map_8,fullfile(Seperated_Files,analysisOutput{8}),8,savedResolution);

%% Plotting the GLEAN parcellation

cd(mainDir);

DK_MNI = nii_quickread(fullfile(mainDir, 'MNI152_T1_8mm_brain.nii.gz'),8);

% Now we define the DK labels we want
Cortical_DK_Labels = [1001:1003 1005:1035 2001:2003 2005:2035];

% We now need to compare all DK_MNI to Labels we want

% This struct has a cell for each label, and the activation at each
Results = cell(1,length(Cortical_DK_Labels));

for i = 1:length(Cortical_DK_Labels)
    
    Template = DK_MNI;
    Template(Template == Cortical_DK_Labels(i)) = 1;
    Template(Template ~= Cortical_DK_Labels(i)) = 0;
    
    MEG_Activation_1 = Map_1 .* Template;
    MEG_Activation_2 = Map_2 .* Template;
    MEG_Activation_3 = Map_3 .* Template;
    MEG_Activation_4 = Map_4 .* Template;
    MEG_Activation_5 = Map_5 .* Template;
    MEG_Activation_6 = Map_6 .* Template;
    MEG_Activation_7 = Map_7 .* Template;
    MEG_Activation_8 = Map_8 .* Template;
    
    Results_1{i}     = MEG_Activation_1;
    Results_2{i}     = MEG_Activation_2;   
    Results_3{i}     = MEG_Activation_3;   
    Results_4{i}     = MEG_Activation_4;   
    Results_5{i}     = MEG_Activation_5;   
    Results_6{i}     = MEG_Activation_6;   
    Results_7{i}     = MEG_Activation_7;   
    Results_8{i}     = MEG_Activation_8;   
       
end

%% Loading and examining the DK parcellation file

cd(mainDir);

% These have cube dimensions for some reason (not 27 23 27), and thus will not load
DK  = nii_quickread(fullfile(mainDir,'DK_8mm.nii.gz'),8);
DK  = nii_quickread(fullfile(mainDir,'DK_APARC+ASEG.nii.gz'),1);

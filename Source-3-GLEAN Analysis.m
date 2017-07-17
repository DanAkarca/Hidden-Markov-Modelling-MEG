%% Sensor level analysis: GLEAN analysis
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%  Adapted from Baker A's Script
%% GLEAN Analysis

% Directory of the data:
cd '/home/da04/Documents/GLEAN_analysis/GLEAN-master';
startup;
clear classes;
clc;

% Directory of the GLEAN analysis
glean_dir = '/home/da04/Documents/GLEAN_analysis/'; 

ControlData = {'data/bAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
        'data/bAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
        'data/bAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
        'data/bAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
        'data/bAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
        'data/bAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
        'data/bAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
        'data/bAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
        'data/bAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
    
PatientData = {'data/bAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
        'data/bAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
        'data/bAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
        'data/bAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
        'data/bAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
        'data/bAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
    
Data        = [ControlData PatientData];
    
ControlData = fullfile(glean_dir,ControlData);
PatientData = fullfile(glean_dir,PatientData);
Data        = fullfile(glean_dir,Data);

% Name for this GLEAN analysis:
glean_Control_name = fullfile(glean_dir,'glean_Control_Oddball_parcellation.mat');
glean_Patient_name = fullfile(glean_dir,'glean_Patient_Oddball_parcellation.mat');
glean_name         = fullfile(glean_dir,'glean_Oddball_parcellation.mat');
    
% Clear settings
settings = struct;

% Envelope settings:
settings.envelope.overwrite = 1;
settings.envelope.log       = 0;
settings.envelope.fsample   = 20;
settings.envelope.mask      = fullfile(glean_dir,'masks/MNI152_T1_8mm_brain.nii.gz');

% Subspace settings:
settings.subspace.overwrite                         = 1;
settings.subspace.normalisation                     = 'none';
settings.subspace.parcellation.file                 = fullfile(glean_dir,'masks/fMRI_parcellation_ds8mm.nii.gz');
settings.subspace.parcellation.orthogonalisation    = 'symmetric';
settings.subspace.parcellation.method               = 'spatialBasis';

% Model settings:
settings.model.overwrite   = 1;
settings.model.hmm.nstates = 8;
settings.model.hmm.nreps   = 1;

% Set up the GLEAN settings, data paths etc:
ControlGLEAN = glean_setup(glean_Control_name, ControlData, settings);
PatientGLEAN = glean_setup(glean_Patient_name, PatientData, settings);
GLEAN        = glean_setup(glean_name        , Data       , settings);

%startup;

% Run the analysis:
glean_run(ControlGLEAN); % just controls
glean_run(PatientGLEAN); % just patients
glean_run(GLEAN);        % both for group comparisons

% cd to where you want to save these GLEAN analysis files - note, they are 
% saved automatically as parcellation.mat files in the glean_dir (as
% defined above)

cd('/home/da04/Documents/GLEAN_analysis/GLEAN_file');
% Save workspace
save GLEAN.mat;

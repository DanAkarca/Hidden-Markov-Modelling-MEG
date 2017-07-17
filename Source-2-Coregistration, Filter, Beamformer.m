%% Source level analysis: Coregistration, Filter, Beamform
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%% Step 1: Setting up the paths and starting OSL
restoredefaultpath;
clear classes;
osldir='/imaging/da04/osl2.0.3.2'; 
addpath(osldir);
 
osl_startup(osldir);
global OSLDIR;
 
% Clear the existing directories you have set up if they are NOT the ones
% you are using for coregistration and beamforming
clear datadir
clear workingdir
clear fsldir

% Specify the directories for the data and storage of the SPM files
datadir='/home/da04/Documents/Co-Registered_Files/';
structuraldir='/imaging/da04/ZDHHC9_T1w/';
workingdir='/home/da04/Documents/'; % you must create this folder yourself

% NOTE: The coregistration will *overwrite* the Adspm files - so copy
% these artefact-removed files or save the coregistered files elsewhere if
% you want to retain a copy of the preprocessed only files without co-registration.
 
cd(workingdir);
clear spm_files;
%% Step 2: Adding preprocessing files
%c1 
spm_files{1}   = [datadir 'Adspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat']; 
spm_files{2}   = [datadir 'Adspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat'];
%c2
spm_files{3}   = [datadir 'Adspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat'];  
spm_files{4}   = [datadir 'Adspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat'];
%c3
spm_files{5}   = [datadir 'Adspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat'];  
spm_files{6}   = [datadir 'Adspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat'];
%c/5
spm_files{7}   = [datadir 'Adspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat'];  
spm_files{8}   = [datadir 'Adspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat'];
%c6
spm_files{9}   = [datadir 'Adspm12meg14_0440_140509_task1_raw_mc_oddball.mat'];  
spm_files{10}  = [datadir 'Adspm12meg14_0440_140509_part2_raw_mc_oddball.mat'];
%c7
spm_files{11}  = [datadir 'Adspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat'];  
spm_files{12}  = [datadir 'Adspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat'];
%c8
spm_files{13}  = [datadir 'Adspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat'];  
spm_files{14}  = [datadir 'Adspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'];
%z1
spm_files{15}  = [datadir 'Adspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat'];  
spm_files{16}  = [datadir 'Adspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat'];
%z2
spm_files{17}  = [datadir 'Adspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat'];
spm_files{18}  = [datadir 'Adspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat'];
%z3
spm_files{19}  = [datadir 'Adspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat'];
spm_files{20}  = [datadir 'Adspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat'];
spm_files{21}  = [datadir 'Adspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat'];
%z4
spm_files{22}  = [datadir 'Adspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat'];  
spm_files{23}  = [datadir 'Adspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat'];
%z5
spm_files{24}  = [datadir 'Adspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat'];  
spm_files{25}  = [datadir 'Adspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat'];
spm_files{26}  = [datadir 'Adspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat'];
%z6
spm_files{27}  = [datadir 'Adspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat'];
spm_files{28}  = [datadir 'Adspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat'];
%z8
spm_files{29}  = [datadir 'Adspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat'];
spm_files{30}  = [datadir 'Adspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'];

%no z7         = [datadir
%'Adspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat']; as there is no
%structural

% NOTE need first '/' for beamforming (not co-registration)
structural_files{1}   = [structuraldir 'c1_T1w.nii'];
structural_files{2}   = [structuraldir 'c1_T1w.nii'];
structural_files{3}   = [structuraldir 'c2_T1w.nii'];
structural_files{4}   = [structuraldir 'c2_T1w.nii'];
structural_files{5}   = [structuraldir 'c3_T1w.nii'];
structural_files{6}   = [structuraldir 'c3_T1w.nii'];
structural_files{7}   = [structuraldir 'c5_T1w.nii'];
structural_files{8}   = [structuraldir 'c5_T1w.nii'];
structural_files{9}   = [structuraldir 'c6_T1w.nii'];
structural_files{10}  = [structuraldir 'c6_T1w.nii'];
structural_files{11}  = [structuraldir 'c7_T1w.nii'];
structural_files{12}  = [structuraldir 'c7_T1w.nii'];
structural_files{13}  = [structuraldir 'c8_T1w.nii'];
structural_files{14}  = [structuraldir 'c8_T1w.nii'];
structural_files{15}  = [structuraldir 'z1_T1w.nii'];
structural_files{16}  = [structuraldir 'z1_T1w.nii'];
structural_files{17}  = [structuraldir 'z2_T1w.nii'];
structural_files{18}  = [structuraldir 'z2_T1w.nii'];
structural_files{19}  = [structuraldir 'z3_T1w.nii'];
structural_files{20}  = [structuraldir 'z3_T1w.nii'];
structural_files{21}  = [structuraldir 'z3_T1w.nii'];
structural_files{22}  = [structuraldir 'z4_T1w.nii'];
structural_files{23}  = [structuraldir 'z4_T1w.nii'];
structural_files{24}  = [structuraldir 'z5_T1w.nii'];
structural_files{25}  = [structuraldir 'z5_T1w.nii'];
structural_files{26}  = [structuraldir 'z5_T1w.nii'];
structural_files{27}  = [structuraldir 'z6_T1w.nii'];
structural_files{28}  = [structuraldir 'z6_T1w.nii'];
structural_files{29}  = [structuraldir 'z8_T1w.nii'];
structural_files{30}  = [structuraldir 'z8_T1w.nii'];
 
% IMPORTANT: Make sure the order of your spm *.mat files and structural files matches!

% c1: spm_files{1,2}      & structural_files{1,2}
% c2: spm_files{3,4}      & structural_files{3,4}
% c3: spm_files{5,6}      & structural_files{5,6}
% c5: spm_files{7,8}      & structural_files{7,8}
% c6: spm_files{9,10}     & structural_files{9,10}
% c7: spm_files{11,12}    & structural_files{11,12}
% c8: spm_files{13,14}    & structural_files{13,14}
% z1: spm_files{15,16}    & structural_files{15,16}
% z2: spm_files{17,18}    & structural_files{17,18}
% z3: spm_files{19,20,21} & structural_files{19,20,21}
% z4: spm_files{22,23}    & structural_files{22,23}
% z5: spm_files{24,25,26} & strucutral_files{24,25,26}
% z6: spm_files{27,28}    & structural_files{27,28}
% z8: spm_files{29,30}    & strucutral_files{29,30}
%% Step 3: Coregistration 
% linking the head meshes, MEG sensors, and fiducials in a common coordinate system  
for i = 1:length(spm_files)
    S                  = [];
    S.D                = spm_files{i};
    S.mri              = structural_files{i};
    S.useheadshape     = 1;
    S.use_rhino        = 0;
    S.fid.label.nasion ='Nasion';           %fid_label instead of fid.label if coregistering in Rhino
    S.fid.label.lpa    ='LPA'; 
    S.fid.label.rpa    ='RPA';              %Refer back to Erin's original if there are problems
    S.forward_meg      ='Single Shell';     %forward_meg (works) / forward_model (provided with, but doesnt work)
    D                  = osl_headmodel(S);  %was given osl_forward_model but this is for beamformer
end;
% For a single datafile:         
    i                  = 1;
    S                  = [];
    S.D                = spm_files{i};
    S.mri              = structural_files{i};
    S.useheadshape     = 1;
    S.use_rhino        = 0;
    S.fid.label.nasion ='Nasion'; %fid_label instead of fid.label if coregistering in Rhino
    S.fid.label.lpa    ='LPA';
    S.fid.label.rpa    ='RPA';
    S.forward_meg      ='MEG Single Shell';
    D                  = osl_headmodel(S);
%% Check coregistration worked correctly:
D = spm_eeg_load;
spm_eeg_inv_checkdatareg(D);
% 1. Are the headshape points (small red dots) well matched to the scalp surface?
% 2. Is the head sensibly inside the sensor array (green circles)?
% 3. Are the MRI fiducials (pink diamonds) located sensibly close to the sensor (HPI) fiducials (light blue circles), and are they sensibly located with respect to the head?
%% Step 4: Beamformer - source reconstruction

% First check you have your file paths set correctly - if not, update: 
datadir      =['/home/da04/Documents/Co-Registered_Files/'];          % Where your coregistered files are saved 
workingdir   =['/home/da04/Documents/Beamformed_Data_TimeInf/']; % Where you want the beamformed files to be saved
 
cd(workingdir);
clear spm_files
clear processed_files
clear beamformed_files;

% Second, if batching several files at once through the beamformer, set
% them up here:

%c1 
processed_files{1}   = [datadir 'Adspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat']; 
processed_files{2}   = [datadir 'Adspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat'];
%c2
processed_files{3}   = [datadir 'Adspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat'];  
processed_files{4}   = [datadir 'Adspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat'];
%c3
processed_files{5}   = [datadir 'Adspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat'];  
processed_files{6}   = [datadir 'Adspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat'];
%c/5
processed_files{7}   = [datadir 'Adspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat'];  
processed_files{8}   = [datadir 'Adspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat'];
%c6
processed_files{9}   = [datadir 'Adspm12meg14_0440_140509_task1_raw_mc_oddball.mat'];  
processed_files{10}  = [datadir 'Adspm12meg14_0440_140509_part2_raw_mc_oddball.mat'];
%c7
processed_files{11}  = [datadir 'Adspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat'];  
processed_files{12}  = [datadir 'Adspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat'];
%c8
processed_files{13}  = [datadir 'Adspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat'];  
processed_files{14}  = [datadir 'Adspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'];
%z1
processed_files{15}  = [datadir 'Adspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat'];  
processed_files{16}  = [datadir 'Adspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat'];
%z2
processed_files{17}  = [datadir 'Adspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat'];
processed_files{18}  = [datadir 'Adspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat'];
%z3
processed_files{19}  = [datadir 'Adspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat'];
processed_files{20}  = [datadir 'Adspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat'];
processed_files{21}  = [datadir 'Adspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat'];
%z4
processed_files{22}  = [datadir 'Adspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat'];  
processed_files{23}  = [datadir 'Adspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat'];
%z5
processed_files{24}  = [datadir 'Adspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat'];  
processed_files{25}  = [datadir 'Adspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat'];
processed_files{26}  = [datadir 'Adspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat'];
%z6
processed_files{27}  = [datadir 'Adspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat'];
processed_files{28}  = [datadir 'Adspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat'];
%z8
processed_files{29}  = [datadir 'Adspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat'];
processed_files{30}  = [datadir 'Adspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'];

%c1 
beamformed_files{1}   = [workingdir 'bAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat']; 
beamformed_files{2}   = [workingdir 'bAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat'];
%c2
beamformed_files{3}   = [workingdir 'bAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat'];  
beamformed_files{4}   = [workingdir 'bAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat'];
%c3
beamformed_files{5}   = [workingdir 'bAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat'];  
beamformed_files{6}   = [workingdir 'bAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat'];
%c/5
beamformed_files{7}   = [workingdir 'bAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat'];  
beamformed_files{8}   = [workingdir 'bAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat'];
%c6
beamformed_files{9}   = [workingdir 'bAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat'];  
beamformed_files{10}  = [workingdir 'bAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat'];
%c7
beamformed_files{11}  = [workingdir 'bAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat'];  
beamformed_files{12}  = [workingdir 'bAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat'];
%c8
beamformed_files{13}  = [workingdir 'bAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat'];  
beamformed_files{14}  = [workingdir 'bAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'];
%z1
beamformed_files{15}  = [workingdir 'bAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat'];  
beamformed_files{16}  = [workingdir 'bAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat'];
%z2
beamformed_files{17}  = [workingdir 'bAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat'];
beamformed_files{18}  = [workingdir 'bAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat'];
%z3
beamformed_files{19}  = [workingdir 'bAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat'];
beamformed_files{20}  = [workingdir 'bAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat'];
beamformed_files{21}  = [workingdir 'bAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat'];
%z4
beamformed_files{22}  = [workingdir 'bAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat'];  
beamformed_files{23}  = [workingdir 'bAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat'];
%z5
beamformed_files{24}  = [workingdir 'bAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat'];  
beamformed_files{25}  = [workingdir 'bAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat'];
beamformed_files{26}  = [workingdir 'bAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat'];
%z6
beamformed_files{27}  = [workingdir 'bAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat'];
beamformed_files{28}  = [workingdir 'bAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat'];
%z8
beamformed_files{29}  = [workingdir 'bAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat'];
beamformed_files{30}  = [workingdir 'bAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'];

% Copy files into new folder
for i = 1:length(processed_files);
    S           = [];
    S.D         = processed_files{i};      % coregistered file
    S.outfile   = beamformed_files{i};     % new copy which will be beamformed 
    spm_eeg_copy(S)
end
    
% 30Hz low pass filter:
 
% Beamform
for i = [1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 23 27 28 29 30];
    S                   = [];
    S.D                 = beamformed_files{i};
    S.modalities        = {'MEGGRAD'}; 
    S.mni_coords        = osl_mnimask2mnicoords(fullfile(OSLDIR,'/std_masks/MNI152_T1_8mm_brain.nii.gz'));
    S.timespan          = [0 Inf];
    S.pca_order         = 250;
    S.type              = 'Scalar';
    S.inverse_method    = 'beamform';
    S.prefix            = '';
    S.gridstep          = 8;
    osl_inverse_model(S);
end

% Files that provide SVD errors: 4, 22, 24, 25, 26

% 4  - c2 - 'bAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat'
% 22 - z4 - 'bAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat'
% 24 - z5 - 'bAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat'
% 25 - z5 - 'bAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat'
% 26 - z5 - 'bAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat'

% Important: make sure the beamform settings are correct for your data
%%%%%%%%%%%%%%%%%%%%%%%
%% Load in the beamformer result
for i = [1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 23 27 28 29 30];
D=spm_eeg_load(beamformed_files{i});
% make sure that we switch from sensor space to source space:
D.montage('switch',2);
clear D; 
end
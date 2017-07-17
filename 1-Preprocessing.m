%% Preprocessing script
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%% 
%  This script does the following:
% 1) Maxfilter data
% 2) Convert it into SPM file format
% 3) Downsample
% 4) Remove bad chuncks of data 
% 5) Run ICA to remove artefacts

%% Initialising OSL and SPM

restoredefaultpath;
osldir='/imaging/da04/osl2.0.3.2';  %OSL2.0.3.2
addpath(osldir);
osl_startup(osldir);
%Add folders and subfolder that contain data and scripts
datadir = '/home/da04/Documents/'; 
%scriptdir = '/home/da04/PreProcessing/PreProcessingScripts';
addpath(genpath(datadir));
%addpath(genpath(scriptdir));

%% Step 1: Maxfilter

%%%%%% Single file %%%%%%

%In this step we use maxwell equations to take out electrical sources from
%outside the helmet, it also removes the artefact from the head coils. Included 
%in this is the head movement compensation. Whatever you do, don't try and 
%include the down-sampling - it screws up the movement compensation. Also
%make sure that you are running maxfilter version 2.2 (earlier versions
%have a bug that is best avoided). 

%To do this basic maxfilter, paste this into the Linux command line (i.e.
%not matlab) the output will be saved in your current working directory. If
%you include -o <outputfilename> then you can name the output,
%alternatively if you remove this bit then it will just use the original
%file name with -mc at the end of it. 
maxfilter -f <inputfilename> -o <outputfilename> -movecomp inter -autobad off

% An extra feature that we might want to use is to take the coordinates of
% a file and use them to transform another. e.g. Kate, you may want to run
% the first of your blocks using the code above, and then run the second of
% your blocks using the script below (putting the first processed file name
% after -trans). 
maxfilter -f <inputfilename> -o <outputfilename> -movecomp inter -autobad off -trans <firstrunfile>

%%%%%% Multiple files %%%%%%

% Or to batch this use Python Script 'batchmaxfilter.py' 

%% Step 2: SPM Conversion

maxdatadir = '/home/da04/Documents/';

listFile=dir(maxdatadir);
fname ={listFile(~[listFile.isdir]).name};
part = {};
for n = 1:length(fname)
    if regexp(fname{n},'.fif')
        part{end+1} = fname{n};
    end
end


for i = 1:length(part)
fif_files{i} = [maxdatadir  part{i} ]; %add the correct file extension
spm_files{i} = ['spm12' part{i} ]; %add the correct file extension
end

%Pass this list to SPM convert function
spm('defaults', 'eeg');

S = [];
for subnum= 1:length(fif_files),
    S.dataset = fif_files{subnum};
    S.outfile = spm_files{subnum};
    S.channels = 'all';
    S.blocksize = 3276800;
    S.checkboundary = 1;
    S.usetrials = 1;
    S.datatype = 'float32-le';
    S.eventpadding = 0;
    S.saveorigheader = 0;
    S.conditionlabel = {'Undefined'};
    S.inputformat = [];
    S.continuous = true;
D = spm_eeg_convert(S); 
end
close all
clear fif_files
clear spm_files
clear part

%% Step 3: Downsampling

listFile=dir(pwd);
part ={listFile(~[listFile.isdir]).name};
tmp={}
for n = 1:length(part)
if part{n}(end-2)=='m'
    if any(part{n}(1:3)=='dsp')==1 % NOTE what we are taking
        tmp{end+1}=part{n};
    end
    end
end

spm_files={};
for i = 1:length(tmp)
spm_files{end+1} = [pwd '/' tmp{i}];
end

%Downsample each file 
for i = 1:length(tmp)
S = [];
S.D = spm_files{i}; 
S.fsample_new = 250;
D = spm_eeg_downsample(S);
end

%% Step 4: Removing bad channels and periods of data

%I think that this is best done by eye using the oslview gui. This is the 
%first time that you will get to eyeball your data - so it will
%give you a good idea of what the raw data look like. Mark up bad channels
%and bad chunks of data.
 
spm_files={};
for i = 1:length(tmp)
spm_files{end+1} = [pwd '/d' tmp{i}];
end

%this will open up the GUI so that you can choose a file.
D=spm_eeg_load;  

%Alternatively put the path and name of your file in here

D = spm_eeg_load (spm_files{33}); 
oslview(D);

%% Step 5: ICA artefact removal

for subnum = 1:length(spm_files)
    S = [];
    [dirname,filename] = fileparts(spm_files{subnum});
    S.D = spm_files{subnum};           
    S.logfile = 1;
    S.ica_file = fullfile(dirname,[filename '_africa']);
    S.used_maxfilter  = 1;
    S.ident.func = @identify_artefactual_components_manual_EOG;
    S.to_do = [1 1 1];
    S.ident.artefact_chans = {'EOG061','EOG062','ECG063'};
    osl_africa(S);
end

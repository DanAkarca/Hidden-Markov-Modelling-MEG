%% Sensor level analysis: Epoching script
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%% Loading SPM and setting up
spm('defaults','eeg'); % OSL file
ft_defaults;

% This is the directory where  Adspm data are to be epoched
workingdir = '/imaging/da04/'
cd(workingdir);
% All the SPM preprocessed files to be epoched (Adspm...)
listFile=dir(workingdir);
part ={listFile(~[listFile.isdir]).name};
tmp={}
for n = 1:length(part)
    if any(part{n}(1:3)=='Ads')==1
        tmp{end+1}=part{n};
    end
end
spm_files={};
for i = 1:length(tmp)
spm_files{end+1} = [workingdir '/' tmp{i}];
end

%% Epoch
%  Here, we epoch preceding stimuli trials (S) and all duration deviant trials (D)

for i = 1:length(spm_files);
S = [];
S.D = spm_files{i};
S.fsample = 250;
S.timeonset = 0;
S.bc = 1;
S.inputformat = [];
S.pretrig = -400; % Time in ms before your trigger (trigger is 0)
S.posttrig = 550; % Time in ms after your trigger
S.timewin = [S.pretrig S.posttrig];

S.trialdef(1).conditionlabel = 'Preceding stimulus';
S.trialdef(1).eventtype = 'STI101_up';
S.trialdef(1).eventvalue = 1;

S.trialdef(2).conditionlabel = 'All duration deviant';
S.trialdef(2).eventtype = 'STI101_up';
S.trialdef(2).eventvalue = 2; 

%S.trialdef(3).conditionlabel = '1000Hz';
%S.trialdef(3).eventtype = 'STI101_up';
%S.trialdef(3).eventvalue = 41; 

%S.trialdef(4).conditionlabel = '250Hz';
%S.trialdef(4).eventtype = 'STI101_up';
%S.trialdef(4).eventvalue = 2;

%S.trialdef(5).conditionlabel = '500Hz';
%S.trialdef(5).eventtype = 'STI101_up';
%S.trialdef(5).eventvalue = 22;

%S.trialdef(6).conditionlabel = '1000Hz';
%S.trialdef(6).eventtype = 'STI101_up';
%S.trialdef(6).eventvalue = 42;

%S.trialdef(7).conditionlabel = '250Hz';
%S.trialdef(7).eventtype = 'STI101_up';
%S.trialdef(7).eventvalue = 3;

%S.trialdef(8).conditionlabel = '500Hz';
%S.trialdef(8).eventtype = 'STI101_up';
%S.trialdef(8).eventvalue = 23;

%S.trialdef(9).conditionlabel = '1000Hz';
%S.trialdef(9).eventtype = 'STI101_up';
%S.trialdef(9).eventvalue = 43;

%S.trialdef(10).conditionlabel = '250Hz';
%S.trialdef(10).eventtype = 'STI101_up';
%S.trialdef(10).eventvalue = 4;

%S.trialdef(11).conditionlabel = '500Hz';
%S.trialdef(11).eventtype = 'STI101_up';
%S.trialdef(11).eventvalue = 24;

%S.trialdef(12).conditionlabel = '1000Hz';
%S.trialdef(12).eventtype = 'STI101_up';
%S.trialdef(12).eventvalue = 44;

%S.trialdef(13).conditionlabel = '250Hz';
%S.trialdef(13).eventtype = 'STI101_up';
%S.trialdef(13).eventvalue = 5;

%S.trialdef(14).conditionlabel = '500Hz';
%S.trialdef(14).eventtype = 'STI101_up';
%S.trialdef(14).eventvalue = 25;

%S.trialdef(15).conditionlabel = '1000Hz';
%S.trialdef(15).eventtype = 'STI101_up';
%S.trialdef(15).eventvalue = 45;

%S.trialdef(16).conditionlabel = '250Hz';
%S.trialdef(16).eventtype = 'STI101_up';
%S.trialdef(16).eventvalue = 6;

%S.trialdef(17).conditionlabel = '500Hz';
%S.trialdef(17).eventtype = 'STI101_up';
%S.trialdef(17).eventvalue = 26;

%S.trialdef(18).conditionlabel = '1000Hz';
%S.trialdef(18).eventtype = 'STI101_up';
%S.trialdef(18).eventvalue = 46;

%S.trialdef(19).conditionlabel = '250Hz';
%S.trialdef(19).eventtype = 'STI101_up';
%S.trialdef(19).eventvalue = 7;

%S.trialdef(20).conditionlabel = '500Hz';
%S.trialdef(20).eventtype = 'STI101_up';
%S.trialdef(20).eventvalue = 27;

%S.trialdef(21).conditionlabel = '1000Hz';
%S.trialdef(21).eventtype = 'STI101_up';
%S.trialdef(21).eventvalue = 47;

%S.trialdef(1).conditionlabel = 'Repeat 7';
%S.trialdef(1).eventtype = 'STI101_up';
%S.trialdef(1).eventvalue = 8;

%S.trialdef(2).conditionlabel = 'Repeat 7';
%S.trialdef(2).eventtype = 'STI101_up';
%S.trialdef(2).eventvalue = 28;

%S.trialdef(3).conditionlabel = 'Repeat 7';
%S.trialdef(3).eventtype = 'STI101_up';
%S.trialdef(3).eventvalue = 48;

%S.trialdef(4).conditionlabel = 'Repeat 8';
%S.trialdef(4).eventtype = 'STI101_up';
%S.trialdef(4).eventvalue = 9;

%S.trialdef(5).conditionlabel = 'Repeat 8';
%S.trialdef(5).eventtype = 'STI101_up';
%S.trialdef(5).eventvalue = 29;

%S.trialdef(6).conditionlabel = 'Repeat 8';
%S.trialdef(6).eventtype = 'STI101_up';
%S.trialdef(6).eventvalue = 49;

%S.trialdef(7).conditionlabel = 'Repeat 9';
%S.trialdef(7).eventtype = 'STI101_up';
%S.trialdef(7).eventvalue = 10;

%S.trialdef(8).conditionlabel = 'Repeat 9';
%S.trialdef(8).eventtype = 'STI101_up';
%S.trialdef(8).eventvalue = 30;

%S.trialdef(9).conditionlabel = 'Repeat 9';
%S.trialdef(9).eventtype = 'STI101_up';
%S.trialdef(9).eventvalue = 50;

%S.trialdef(10).conditionlabel = 'Repeat 10';
%S.trialdef(10).eventtype = 'STI101_up';
%S.trialdef(10).eventvalue = 11;

%S.trialdef(11).conditionlabel = 'Repeat 10';
%S.trialdef(11).eventtype = 'STI101_up';
%S.trialdef(11).eventvalue = 31;

%S.trialdef(12).conditionlabel = 'Repeat 10';
%S.trialdef(12).eventtype = 'STI101_up';
%S.trialdef(12).eventvalue = 51;

%S.trialdef(13).conditionlabel = 'Repeat 11';
%S.trialdef(13).eventtype = 'STI101_up';
%S.trialdef(13).eventvalue = 12;

%S.trialdef(14).conditionlabel = 'Repeat 11';
%S.trialdef(14).eventtype = 'STI101_up';
%S.trialdef(14).eventvalue = 32;

%S.trialdef(15).conditionlabel = 'Repeat 11';
%S.trialdef(15).eventtype = 'STI101_up';
%S.trialdef(15).eventvalue = 52;

%S.trialdef(16).conditionlabel = 'Repeat 12';
%S.trialdef(16).eventtype = 'STI101_up';
%S.trialdef(16).eventvalue = 13;

%S.trialdef(17).conditionlabel = 'Repeat 12';
%S.trialdef(17).eventtype = 'STI101_up';
%S.trialdef(17).eventvalue = 33;

%S.trialdef(18).conditionlabel = 'Repeat 12';
%S.trialdef(18).eventtype = 'STI101_up';
%S.trialdef(18).eventvalue = 53;

S.reviewtrials = 0;
S.save = 0;
S.epochinfo.padding = 0;
D = spm_eeg_epochs(S);
end

%% Source level analysis: GLEAN analysis of outputs
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%% 
startup;
clear classes;
clc;

glean_dir        = '/home/da04/Documents/GLEAN_analysis';
glean_file       = '/home/da04/Documents/GLEAN_analysis/GLEAN_file/';   % There are also files within glean_dir
glean_master_dir = fullfile(glean_dir, 'GLEAN-master');                  % Where all functions reside

%cd(glean_file); % This is a struct with all contained. Individual parcellation files are found within glean_dir
%AllGLEANs    = load('GLEAN.mat'); % Files saved from GLEAN analysis

cd(glean_dir);
ControlGLEAN = load('glean_Control_Oddball_parcellation.mat');
ControlGLEAN = ControlGLEAN.GLEAN;
PatientGLEAN = load('glean_Patient_Oddball_parcellation.mat');
PatientGLEAN = PatientGLEAN.GLEAN;
GroupGLEAN   = load('glean_Oddball_parcellation.mat');
GroupGLEAN   = GroupGLEAN.GLEAN;

cd(glean_master_dir);

help contents % to see all functions

%% Intra- versus inter-group statistics

%  When running seperate group GLEANs, we attain seperate state maps that can not be compared between groups
%  For intra-group statistics, we assume the same underpinning states across groups and can therefore do comparisons

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                                        INTRA-GROUP STATISTICS

ControlGLEAN;
PatientGLEAN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Settings for all intra-group statistics

settings           = [];
settings.format    = 'nii';
settings.space     = 'parcel';

%% Computations
%% 

  % Statistics and Transitions

  Control_HMM_Transitions = glean_state_transitions(ControlGLEAN);            %Computes the state transitions probabilities for each session  
  Patient_HMM_Transitions = glean_state_transitions(PatientGLEAN);
  
  % Partial Correlation and Connectivity maps 

  ControlGLEAN            = glean_pcorr(ControlGLEAN,settings);
  ControlGLEAN            = glean_connectivityprofile(ControlGLEAN,settings);
  PatientGLEAN            = glean_pcorr(PatientGLEAN,settings);
  PatientGLEAN            = glean_connectivityprofile(PatientGLEAN,settings);
  
  % Others 

  % Control_HMM_Stats     = glean_hmm_stats(ControlGLEAN);                     %Compute summary statistics from HMM statepath - so will compute everything
  % ControlGLEAN          = glean_occupancy_timecourse(ControlGLEAN,settings); %Compute fractional occupancy time courses from HMM state time courses
  % glean_write_model_timecourses(ControlGLEAN);                               %SPM12 MEG objects of GLEAN model time courses
  
%% Transition matricies and HMM statistics

% Replace NaN with zeros

for j = 1:length(Control_HMM_Transitions);
    
x = isnan(Control_HMM_Transitions{j});
x = find(x);
for i = x
    Control_HMM_Transitions{j}(i) = 0;
end
end

for j = 1:length(Patient_HMM_Transitions);
    
x = isnan(Patient_HMM_Transitions{j});
x = find(x);
for i = x
    Patient_HMM_Transitions{j}(i) = 0;
end
end

% Calculate means

ControlMeanTransitionVector = [];

for i    = 1:(length(Control_HMM_Transitions{1}))^2;
    y    = [];
for k    = 1:length(Control_HMM_Transitions);
    y(k) = Control_HMM_Transitions{k}(i);
end
    ControlMeanTransitionVector(i) = mean(y);
    clear y;
end

x = ControlMeanTransitionVector;
x = [x(1:8)' x(9:16)' x(17:24)' x(25:32)' x(33:40)' x(41:48)' x(49:56)' x(57:64)'];
ControlMeanTransitionMatrix = x;

patientMeanTransitionVector = [];

for i    = 1:(length(Patient_HMM_Transitions{1}))^2;
    y    = [];
for k    = 1:length(Patient_HMM_Transitions);
    y(k) = Patient_HMM_Transitions{k}(i);
end
    PatientMeanTransitionVector(i) = mean(y);
    clear y;
end

x = PatientMeanTransitionVector;
x = [x(1:8)' x(9:16)' x(17:24)' x(25:32)' x(33:40)' x(41:48)' x(49:56)' x(57:64)'];
PatientMeanTransitionMatrix = x;

MeanDifferenceMatrix = ControlMeanTransitionMatrix - PatientMeanTransitionMatrix;

% Setting customised colours

CustomColors         = jet(256);
CustomColors(end,:)  = 1;

% Make returned states a high number

% All SameStates are set to '1' (will be white in later matrix)

SameStatesIndex   = [1 10 19 28 37 46 55 64];
for i = SameStatesIndex
    ControlMeanTransitionMatrix(i) = 1;
    PatientMeanTransitionMatrix(i) = 1;
    MeanDifferenceMatrix(i)        = 1;
end

% Set the c-limit maximum to 0.01% larger than maximum value (for both!)

NotSameStatesIndex                  = 1:64;
NotSameStatesIndex(SameStatesIndex) = 0;
NotSameStatesIndex                  = NotSameStatesIndex(NotSameStatesIndex~=0);

HighestControlValue                 = max(ControlMeanTransitionMatrix(NotSameStatesIndex));
HighestPatientValue                 = max(PatientMeanTransitionMatrix(NotSameStatesIndex));

% find the highest out of these to use as the scale - turns out to be patient

clim_max = HighestPatientValue + 0.01*HighestPatientValue; 

figure;

imagesc(ControlMeanTransitionMatrix);

caxis([0 clim_max])
colormap(CustomColors);
c = colorbar;
set(gca,'XTick',1:size(ControlMeanTransitionMatrix,1),...                     
        'XTickLabel',{'1','2','3','4','5','6','7','8'},...   
        'YTick',1:size(ControlMeanTransitionMatrix,1),...
        'YTickLabel',{'1','2','3','4','5','6','7','8'},...
        'TickLength',[0 0]);
set(gca,'FontSize',20);
xlabel(sprintf('State at t+1'),'fontsize',25);
ylabel(sprintf('State at t'),'fontsize',25);
ylabel(c,'Probability','fontsize',25);
title(('Control seperated: State transition matrix'),'fontsize',30,'fontWeight','bold');

figure;

imagesc(PatientMeanTransitionMatrix);

caxis([0 clim_max])
colormap(CustomColors);
c = colorbar;
set(gca,'XTick',1:size(PatientMeanTransitionMatrix,1),...                     
        'XTickLabel',{'1','2','3','4','5','6','7','8'},...   
        'YTick',1:size(PatientMeanTransitionMatrix,1),...
        'YTickLabel',{'1','2','3','4','5','6','7','8'},...
        'TickLength',[0 0]);
set(gca,'FontSize',20);
xlabel(sprintf('State at t+1'),'fontsize',25);
ylabel(sprintf('State at t'),'fontsize',25);
ylabel(c,'Probability','fontsize',25);
title(('Patient seperated: State transition matrix'),'fontsize',30,'fontWeight','bold');

HighestDifferenceValue            = max(MeanDifferenceMatrix(NotSameStatesIndex));
LowestDifferenceValue             = min(MeanDifferenceMatrix(NotSameStatesIndex));
meanDif_clim_max                  = HighestDifferenceValue + 0.01 * HighestDifferenceValue;
meanDif_clim_min                  = LowestDifferenceValue  - 0.01 * LowestDifferenceValue;

figure;

imagesc(MeanDifferenceMatrix); % This is not officially comparable but is good to see

caxis([meanDif_clim_min meanDif_clim_max]);
colormap(CustomColors);
c = colorbar;
set(gca,'XTick',1:size(MeanDifferenceMatrix,1),...                     
        'XTickLabel',{'1','2','3','4','5','6','7','8'},...   
        'YTick',1:size(MeanDifferenceMatrix,1),...
        'YTickLabel',{'1','2','3','4','5','6','7','8'},...
        'TickLength',[0 0]);
set(gca,'FontSize',20);
xlabel(sprintf('State at t+1'),'fontsize',25);
ylabel(sprintf('State at t'),'fontsize',25);
ylabel(c,'Absolute probability difference','fontsize',25);
title(('Distinct spatial state differences in state transition matrix'),'fontsize',30,'fontWeight','bold');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                                          INTER-GROUP STATISTICS

GroupGLEAN;
glean_plot_timecourse(GroupGLEAN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Settings for all inter-group statistics

ControlFiles = 1:13;  % Make sure to define this
PatientFiles = 14:25;

settings           = [];

settings.design    = [1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
                      1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0     
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0    
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0      
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0       
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0       
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0         
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0         
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0           
                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]; 
                  
% [sessions x regressors] - this defines regressors as controls, patients and all individuals.

%settings.design   = [1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
%                     0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1];                     
settings.contrasts = [1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];     % [contrast x regressors]
settings.plot      =  1;
%settings.grouplbls = {'1','1','1','1','1','1','1','1','1','1','1','1','1',...
%                      '2','2','2','2','2','2','2','2','2','2','2','2'};           %  cell array
settings.grouplbls = {'Controls','Controls','Controls','Controls','Controls','Controls','Controls','Controls','Controls','Controls','Controls','Controls','Controls',...
                      'ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9','ZDHHC9'};
settings.format    = 'nii';
settings.space     = 'parcel';

%% Computations
%% 

% Statistics 

  Group_HMM_Stats = glean_hmm_stats(GroupGLEAN);
  GroupGLEAN      = glean_group_lifetimes(GroupGLEAN,settings);
  GroupGLEAN      = glean_group_transitions(GroupGLEAN,settings);
  GroupGLEAN      = glean_group_temporal_stats(GroupGLEAN,settings);

% Partial correlations, power and statewise power maps

  GroupGLEAN      = glean_pcorr(GroupGLEAN,settings);
  GroupGLEAN      = glean_connectivityprofile(GroupGLEAN,settings);
  GroupGLEAN      = glean_group_power(GroupGLEAN,settings);
  GroupGLEAN      = glean_group_statewise_power(GroupGLEAN,settings);

% Others
  
% GroupGLEAN = glean_group_netmats(GroupGLEAN,settings)            %Group differences in state network matrices.
% GroupGLEAN = glean_group_netmats2(GroupGLEAN,settings)           %Group differences in state network matrices, version 2.
% GroupGLEAN = glean_group_state_distance(GroupGLEAN,settings);    %Group differences in state covariance similarity

%% Total partial correlations (over both)
%% 

% Location:
GroupGLEAN.results.pcorr.parcel.groupmaps{1};

%% Group power: GLEAN.results.group_power
%% 

% Location:
GroupGLEAN.results.group_power.parcel.groupmaps{1};

%% Group statewise power: GLEAN.results.group_state_power 
%% 

% Location:
GroupGLEAN.results.group_state_power.power.groupmaps{1};

%% Group lifetimes: GLEAN.results.group_lifetimes
%%

GroupGLEAN.results.group_lifetimes;
lifetime_pvalue = GroupGLEAN.results.group_lifetimes.pvalues;
lifetime_CI     = GroupGLEAN.results.group_lifetimes.CI;

Control_lifetime_vector = GroupGLEAN.results.group_lifetimes.lifetimes(ControlFiles);
Patient_lifetime_vector = GroupGLEAN.results.group_lifetimes.lifetimes(PatientFiles);

meanControl = mean(Control_lifetime_vector);
meanPatient = mean(Patient_lifetime_vector);

stdErrorControl = std(Control_lifetime_vector)/sqrt(length(Control_lifetime_vector));
stdErrorPatient = std(Patient_lifetime_vector)/sqrt(length(Patient_lifetime_vector));
tScoreControl   = tinv([0.025 0.0975], length(Control_lifetime_vector)-1);
tScorePatient   = tinv([0.025 0.0975], length(Patient_lifetime_vector)-1);

Control_CI_lims = meanControl + tScoreControl * stdErrorControl;
Control_CI      = Control_CI_lims(end) - Control_CI_lims(1);
Patient_CI_lims = meanPatient + tScorePatient * stdErrorPatient;
Patient_CI      = Patient_CI_lims(end) - Patient_CI_lims(1);
AllCI           = [Control_CI Patient_CI];

figure;

barPlot = [meanControl meanPatient];
bar(barPlot,'r');
hold on
errorbar(1:2,barPlot,AllCI,'.k','LineWidth',4);

set(gca,'XTickLabel',{'Control','ZDHHC9'},'TickLength',[0 0],'FontSize',25);
ylabel('Number of lifetimes','FontSize',35);
title(sprintf('Group lifetimes p<%0.1g',lifetime_pvalue),'FontSize',35);
xlim([0 3]);

%% Group transitions: GLEAN.results.group_transitions
%% 

GroupGLEAN.results.group_transitions

%  Seperating out controls and patients

mat          = GroupGLEAN.results.group_transitions.transitions;   % Get transition matrix;

ControlMat   = mat(ControlFiles,:,:);
PatientMat   = mat(PatientFiles,:,:);
ControlMat   = mean(ControlMat,1);                            % Get average across subjects
PatientMat   = mean(PatientMat,1);
ControlMat   = squeeze(ControlMat);
PatientMat   = squeeze(PatientMat);
ControlMat(logical(eye(size(ControlMat)))) = NaN;             % Exclude the probability of remaining in the same state
PatientMat(logical(eye(size(PatientMat)))) = NaN;  

% Replace NaNs with 0

x = isnan(ControlMat);
x = find(x);
for i = x
    ControlMat(i) = 0;
end

x = isnan(PatientMat);
x = find(x);
for i = x
    PatientMat(i) = 0;
end

% All SameStates are set to '1' (will be white in later matrix)

SameStatesIndex   = [1 10 19 28 37 46 55 64];
for i = SameStatesIndex
    ControlMat(i) = 1;
    PatientMat(i) = 1;
end

% Another set of customised colours (if we want)

%n              = 10000; %Color resolution
%Increments     = linspace(1,0.25,n);
%x              = zeros(n,1);
%x(1:length(x)) = 0.7;
%CustomColors   = [zeros(n,1) Increments' x];
%CustomColors(end,:) = [1 1 1];

% Or use CustomColors (same as before)

CustomColors         = jet(256);
CustomColors(end,:)  = 1;

NotSameStatesIndex                  = 1:64;
NotSameStatesIndex(SameStatesIndex) = 0;
NotSameStatesIndex                  = NotSameStatesIndex(NotSameStatesIndex~=0);

HighestControlMatValue              = max(ControlMat(NotSameStatesIndex));
HighestPatientMatValue              = max(PatientMat(NotSameStatesIndex));

% find the highest out of these to use as the scale - turns out to be patient

clim_group_max = HighestControlMatValue + 0.01*HighestControlMatValue; 


% Plotting control matrix

figure;

imagesc(ControlMat);                                          % Create a colored plot of the matrix values

caxis([0 clim_group_max]);
colormap(CustomColors);                                            
c = colorbar;

%textStrings = num2str(ControlMat(:),'%0.2f');               % Create strings from the matrix values
%textStrings = strtrim(cellstr(textStrings));                % Remove any space padding
%[x,y]       = meshgrid(1:size(ControlMat,1));               % Create x and y coordinates for the strings
%hStrings    = text(x(:),y(:),textStrings(:),...             % Plot the strings
%                'HorizontalAlignment','center'); 
%midValue    = mean(get(gca,'CLim'));                        % Get the middle value of the color range
%textColors  = repmat(ControlMat(:) > midValue,1,3);         % Choose white or black for the
                                                             % text color of the strings so
                                                             % they can be easily seen over
                                                             % the background color
%set(hStrings,{'Color'},num2cell(textColors,2));             % Change the text colors
%set(hStrings,'Color',[1 1 1]);

set(gca,'XTick',1:size(ControlMat,1),...                     % Change the axes tick marks
        'XTickLabel',{'1','2','3','4','5','6','7','8'},...   % and tick labels
        'YTick',1:size(ControlMat,1),...
        'YTickLabel',{'1','2','3','4','5','6','7','8'},...
        'TickLength',[0 0]);
set(gca,'FontSize',20);
xlabel(sprintf('State at t+1'),'fontsize',25);

ylabel(sprintf('State at t'),'fontsize',25);
ylabel(c,'Probability','fontsize',25);
title(('Control: State transition matrix'),'fontsize',30,'fontWeight','bold');

% Plotting patient matrix

figure;

imagesc(PatientMat);                                          % Create a colored plot of the matrix values

caxis([0 clim_group_max]);
colormap(CustomColors);
c = colorbar;
set(gca,'XTick',1:size(PatientMat,1),...                    
        'XTickLabel',{'1','2','3','4','5','6','7','8'},...   
        'YTick',1:size(PatientMat,1),...
        'YTickLabel',{'1','2','3','4','5','6','7','8'},...
        'TickLength',[0 0]);
set(gca,'FontSize',20);
xlabel(sprintf('State at t+1'),'fontsize',25);
ylabel(sprintf('State at t'),'fontsize',25);
ylabel(c,'Probability','fontsize',25);
title(('ZDHHC9: State transition matrix'),'fontsize',30,'fontWeight','bold');

% MeanDifferenceGroupMatrix

MeanDifferenceGroupMatrix = ControlMat - PatientMat;
SameStatesIndex   = [1 10 19 28 37 46 55 64];
for i = SameStatesIndex
    MeanDifferenceGroupMatrix(i) = 1;
end

HighestMeanMatValue              = max(MeanDifferenceGroupMatrix(NotSameStatesIndex));
LowestMeanMatValue               = min(MeanDifferenceGroupMatrix(NotSameStatesIndex));
clim_meanMat_upper               = HighestMeanMatValue + 0.01 * HighestMeanMatValue;
clim_meanMat_lower               = LowestMeanMatValue  - 0.01 * LowestMeanMatValue;

figure;

imagesc(MeanDifferenceGroupMatrix);

caxis([clim_meanMat_lower clim_meanMat_upper]);
colormap(CustomColors);
c = colorbar;
set(gca,'XTick',1:size(MeanDifferenceGroupMatrix,1),...                    
        'XTickLabel',{'1','2','3','4','5','6','7','8'},...   
        'YTick',1:size(MeanDifferenceGroupMatrix,1),...
        'YTickLabel',{'1','2','3','4','5','6','7','8'},...
        'TickLength',[0 0]);
set(gca,'FontSize',20);
xlabel(sprintf('State at t+1'),'fontsize',25);
ylabel(sprintf('State at t'),'fontsize',25);
ylabel(c,'Absolute probability differences','fontsize',25);
title(('State differences transition matrix'),'fontsize',30,'fontWeight','bold');

% Plotting p-values

pValMatrix    = GroupGLEAN.results.group_transitions.pvalues;

alpha         = 0.05; % Alter this

Sig           = pValMatrix <= alpha;
Sig           = double(Sig);

SigIndex      = find(Sig);
NotSigIndex   = find(~Sig);

pValMatrix(SigIndex)    = 0.2;
pValMatrix(NotSigIndex) = 0.1;
pValMatrix(SameStatesIndex)  = 1;

figure;

imagesc(pValMatrix)

colormap(CustomColors);
caxis([0 0.6]);
set(gca,'XTick',1:size(MeanDifferenceGroupMatrix,1),...                    
        'XTickLabel',{'1','2','3','4','5','6','7','8'},...   
        'YTick',1:size(MeanDifferenceGroupMatrix,1),...
        'YTickLabel',{'1','2','3','4','5','6','7','8'},...
        'TickLength',[0 0]);
set(gca,'FontSize',20);
xlabel(sprintf('State at t+1'),'fontsize',25);
ylabel(sprintf('State at t'),'fontsize',25);
title(sprintf('Light blue shows p<%g for between group transition state comparisons',alpha),'fontsize',30,'fontWeight','bold');

%% Temporal statistics: GLEAN.results.group_temporal_stats
%%
GroupGLEAN.results.group_temporal_stats
help glean_temporal_stats_plot

% Number of occurrences
open(GroupGLEAN.results.group_temporal_stats.nOccurrences.plots.stats);
nOccurrences_pvalue = GroupGLEAN.results.group_temporal_stats.nOccurrences.pvalues;
nOccurrences_CI     = GroupGLEAN.results.group_temporal_stats.nOccurrences.CI;

% Fractional Occupancy
open(GroupGLEAN.results.group_temporal_stats.FractionalOccupancy.plots.stats);
FO_pvalue           = GroupGLEAN.results.group_temporal_stats.FractionalOccupancy.pvalues;
FO_CI               = GroupGLEAN.results.group_temporal_stats.FractionalOccupancy.CI;

% Mean Life time
open(GroupGLEAN.results.group_temporal_stats.MeanLifeTime.plots.stats);
MLT_pvalue          = GroupGLEAN.results.group_temporal_stats.MeanLifeTime.pvalues;
MLT_CI              = GroupGLEAN.results.group_temporal_stats.MeanLifeTime.CI;

% Mean Interval Length
open(GroupGLEAN.results.group_temporal_stats.MeanIntervalLength.plots.stats);
MIL_pvalue          = GroupGLEAN.results.group_temporal_stats.MeanIntervalLength.pvalues;
MIL_CI              = GroupGLEAN.results.group_temporal_stats.MeanIntervalLength.CI;

% Entropy
open(GroupGLEAN.results.group_temporal_stats.Entropy.plots.stats);
Entropy_pvalue      = GroupGLEAN.results.group_temporal_stats.Entropy.pvalues;
Entropy_CI          = GroupGLEAN.results.group_temporal_stats.Entropy.CI;

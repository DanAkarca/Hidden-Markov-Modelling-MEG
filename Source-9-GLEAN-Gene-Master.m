%% Source level analysis: GLEAN-GENE Master script
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%% CONTENTS
% 1. Loading States, Templates, Expression Data
%    - Here, we upload GLEAN files and attain activation by DK parcel for each state
%    - Then we sum absoulte values and non absolute values within each parcel within each state
%    - We then load expression data
%
% 2. Normalisation of activation and expression
%    - Z score of activation of each parcel and each expression
%
% 3. Correlation of z_Activation with z_Expression parcelwise with no thresholding
%
% 4. Thresholding correlations by raw activation z scores
%
% 5. Thresholding correlations by % of maximum z scores and running
%    expression permuation test ********<<<----- Most important part
%
% 6. Correlating state activation maps
%
%% 1) Loading States, Templates and Expression Data - Determining Activation and Expression per DK parcellation

% What has been done before this script:
% GLEAN analysis
% Ran PCORR to an 8mm MNI152 grid
% Attained a DK parcellation 8mm MNI152 grid that provides labels at each point
% Both the template and GLEAN maps loaded to python using nibabel, and saved to a numpty file
% This script will subsequently get all the parcel activation patterns and will subseqently correlate gene expression to GLEAN activation patterns
% Add a readNPY master to path (can find online)

clear;
clc;

% These have been converted to numpty files, from nii, using the py script (nib,np,pd)
ActivationStatesDir = '/Users/Dan/Desktop/MPhil/Project_CBU/GLEAN-Gene/Converted_States/';
cd(ActivationStatesDir);

states             = [1:8];
stateNames         = {'Visual' 'Frontoparietal' 'Somatosensory' 'Parietal' ...
                      'Frontotemporal I' 'Temporal' 'Frontotemporal II' 'Frontal'};
stateNames_Table   = {'Visual' 'Frontoparietal' 'Somatosensory' 'Parietal' ...
                      'Frontotemporal_I' 'Temporal' 'Frontotemporal_II' 'Frontal'};

Template = readNPY(fullfile(pwd,'DK_Template_MNI152_8mm.npy'));
State_1  = readNPY(fullfile(pwd,'State_1.npy'));
State_2  = readNPY(fullfile(pwd,'State_2.npy'));
State_3  = readNPY(fullfile(pwd,'State_3.npy'));
State_4  = readNPY(fullfile(pwd,'State_4.npy'));
State_5  = readNPY(fullfile(pwd,'State_5.npy'));
State_6  = readNPY(fullfile(pwd,'State_6.npy'));
State_7  = readNPY(fullfile(pwd,'State_7.npy'));
State_8  = readNPY(fullfile(pwd,'State_8.npy'));

% Labels from DK parcellation we want (these are all corticol parcels)
Labels   = [1001:1003 1005:1035 2001:2003 2005:2035];

% Setting size of figures when produced
Screensize    = get(0,'Screensize');
Screensize(3) = 1100;
Squaresize    = Screensize;

% All MNI indexes of these specific labels
Indexes  = {};
for i = 1:length(Labels)
    Indexes{i} = find(Template==Labels(i));
end

State_1_Activation_by_Label = {};
State_2_Activation_by_Label = {};
State_3_Activation_by_Label = {};
State_4_Activation_by_Label = {};
State_5_Activation_by_Label = {};
State_6_Activation_by_Label = {};
State_7_Activation_by_Label = {};
State_8_Activation_by_Label = {};

for i = 1:length(Indexes)
    
    State_1_Activation_by_Label{i} = State_1(Indexes{i});
    State_2_Activation_by_Label{i} = State_2(Indexes{i});
    State_3_Activation_by_Label{i} = State_3(Indexes{i});
    State_4_Activation_by_Label{i} = State_4(Indexes{i});
    State_5_Activation_by_Label{i} = State_5(Indexes{i});
    State_6_Activation_by_Label{i} = State_6(Indexes{i});
    State_7_Activation_by_Label{i} = State_7(Indexes{i});
    State_8_Activation_by_Label{i} = State_8(Indexes{i});
    
end

% Now we have State Activation by Label, by individual coordinates in MNI space
% Lets sum across each Label

State_1_Activation_by_Label_Total = {};
State_2_Activation_by_Label_Total = {};
State_3_Activation_by_Label_Total = {};
State_4_Activation_by_Label_Total = {};
State_5_Activation_by_Label_Total = {};
State_6_Activation_by_Label_Total = {};
State_7_Activation_by_Label_Total = {};
State_8_Activation_by_Label_Total = {};

% Summing

for i = 1:length(State_1_Activation_by_Label)
    State_1_Activation_by_Label_Total_nA{i} = sum(State_1_Activation_by_Label{i});
    State_2_Activation_by_Label_Total_nA{i} = sum(State_2_Activation_by_Label{i});
    State_3_Activation_by_Label_Total_nA{i} = sum(State_3_Activation_by_Label{i});
    State_4_Activation_by_Label_Total_nA{i} = sum(State_4_Activation_by_Label{i});
    State_5_Activation_by_Label_Total_nA{i} = sum(State_5_Activation_by_Label{i});
    State_6_Activation_by_Label_Total_nA{i} = sum(State_6_Activation_by_Label{i});
    State_7_Activation_by_Label_Total_nA{i} = sum(State_7_Activation_by_Label{i});
    State_8_Activation_by_Label_Total_nA{i} = sum(State_8_Activation_by_Label{i});
end

% Abs summing

for i = 1:length(State_1_Activation_by_Label)
    State_1_Activation_by_Label_Total{i} = sum(abs(State_1_Activation_by_Label{i}));
    State_2_Activation_by_Label_Total{i} = sum(abs(State_2_Activation_by_Label{i}));
    State_3_Activation_by_Label_Total{i} = sum(abs(State_3_Activation_by_Label{i}));
    State_4_Activation_by_Label_Total{i} = sum(abs(State_4_Activation_by_Label{i}));
    State_5_Activation_by_Label_Total{i} = sum(abs(State_5_Activation_by_Label{i}));
    State_6_Activation_by_Label_Total{i} = sum(abs(State_6_Activation_by_Label{i}));
    State_7_Activation_by_Label_Total{i} = sum(abs(State_7_Activation_by_Label{i}));
    State_8_Activation_by_Label_Total{i} = sum(abs(State_8_Activation_by_Label{i}));
end
    
% Rearranging

Summed_Activation_by_Label_nA = {};
for i = 1:length(State_1_Activation_by_Label_Total)
    Summed_Activation_by_Label_nA{i} = [State_1_Activation_by_Label_Total_nA{i} ...
                                     State_2_Activation_by_Label_Total_nA{i} ...
                                     State_3_Activation_by_Label_Total_nA{i} ...
                                     State_4_Activation_by_Label_Total_nA{i} ... 
                                     State_5_Activation_by_Label_Total_nA{i} ...
                                     State_6_Activation_by_Label_Total_nA{i} ...
                                     State_7_Activation_by_Label_Total_nA{i} ...
                                     State_8_Activation_by_Label_Total_nA{i}];
end


Summed_Activation_by_Label = {};
for i = 1:length(State_1_Activation_by_Label_Total)
    Summed_Activation_by_Label{i} = [State_1_Activation_by_Label_Total{i} ...
                                     State_2_Activation_by_Label_Total{i} ...
                                     State_3_Activation_by_Label_Total{i} ...
                                     State_4_Activation_by_Label_Total{i} ... 
                                     State_5_Activation_by_Label_Total{i} ...
                                     State_6_Activation_by_Label_Total{i} ...
                                     State_7_Activation_by_Label_Total{i} ...
                                     State_8_Activation_by_Label_Total{i}];
end

% Note, bankssts = around superior temporal sulcus (first)
LabelNames = {['Superior Temporal Sulcus'] ['Caudal Anterior Cingulate'] ['Caudal Middle Frontal'] ['Cuneus']...
              ['Entorhinal']               ['Fusiform']                  ['Inferior Parietal']     ['Inferior Temporal']    ['Isthmus Cingulate'] ...
              ['Lateral Occipital']        ['Lateral Orbitofrontal']     ['Lingual']               ['Medial Orbitofrontal'] ['Middle Temporal'] ...
              ['Parahippocampal']          ['Paracentral']               ['Pars Opercularis']      ['Pars Orbitalis']       ['Pars Triangularis']...
              ['Pericalcarine']            ['Postcentral']               ['Posterior Cingulate']   ['Precentral']           ['Precuneus'] ['Rostral Anterior Cingulate'] ...
              ['Rostral Middle Frontal']   ['Superior Frontal']          ['Superior Parietal']     ['Superior Temporal'] ...
              ['Supramarginal']            ['Frontal Pole']              ['Temporal Pole']         ['Transverse Temporal']  ['Insula']};

% Left labels
% NB. 32 is a space in str
LeftParcels = {};
for i = 1:length(LabelNames)
    LeftParcels{i} = strcat('Left',32,LabelNames{i});
end

% Right labels
RightParcels = {};
for i = 1:length(LabelNames)
    RightParcels{i} = strcat('Right',32,LabelNames{i});
end

LabelNames = [LeftParcels RightParcels];

% Gene expression at specific label locations

% First input absolute gene expression (from Allen DKA)
% Note, to import, must put a zero as first value

ZDHHC9_Expression = importdata(fullfile(pwd,'68_cortical_ZDHHC9_Expression.csv'));
ZDHHC9_Expression = ZDHHC9_Expression.data;

% Now plot these across all 68 regions

figure;
bar(1:68, ZDHHC9_Expression);
title('ZDHHC9 expression levels across cortical regions');
ylabel('Gene expression');
xlabel('Label index');

%% 2. Normalisation of activation and expression

% Now we have activation at each label for each brain state, and a ZDHHC9 gene expression value at that label

% All_Data has all States, all Labels, all Activation at Labels
All_Data_Raw = [{State_1_Activation_by_Label} {State_2_Activation_by_Label} ...
            {State_3_Activation_by_Label} {State_4_Activation_by_Label} ...
            {State_5_Activation_by_Label} {State_6_Activation_by_Label} ...
            {State_7_Activation_by_Label} {State_8_Activation_by_Label}];
        
All_Data_Sum = [{State_1_Activation_by_Label_Total_nA} {State_2_Activation_by_Label_Total_nA} ...
            {State_3_Activation_by_Label_Total_nA} {State_4_Activation_by_Label_Total_nA} ...
            {State_5_Activation_by_Label_Total_nA} {State_6_Activation_by_Label_Total_nA} ...
            {State_7_Activation_by_Label_Total_nA} {State_8_Activation_by_Label_Total_nA}];
        
All_Data_AbsSum = [{State_1_Activation_by_Label_Total} {State_2_Activation_by_Label_Total} ...
            {State_3_Activation_by_Label_Total} {State_4_Activation_by_Label_Total} ...
            {State_5_Activation_by_Label_Total} {State_6_Activation_by_Label_Total} ...
            {State_7_Activation_by_Label_Total} {State_8_Activation_by_Label_Total}];
        
for i = 1:length(All_Data_Sum)
        All_Data_Sum{i} = cell2mat(All_Data_Sum{i});
end        

for i = 1:length(All_Data_AbsSum)
        All_Data_AbsSum{i} = cell2mat(All_Data_AbsSum{i});
end
        
ZDHHC9_Expression;

All_Data_Raw_Z_Scores = {{}};
for i = 1:length(All_Data_Raw)
    for j = 1:length(All_Data_Raw{1})
        All_Data_Raw_Z_Scores{i}{j} = zscore(All_Data_Raw{i}{j});
    end
end

All_Data_Sum_Z_Scores  = {};
for i = 1:length(All_Data_Sum)
    All_Data_Sum_Z_Scores{i} = zscore(All_Data_Sum{i});
end

All_Data_AbsSum_Z_Scores = {};
for i = 1:length(All_Data_AbsSum)
    All_Data_AbsSum_Z_Scores{i} = zscore(All_Data_AbsSum{i});
end

State_1_Activation_Z_Score  = All_Data_Raw_Z_Scores{1};
State_2_Activation_Z_Score  = All_Data_Raw_Z_Scores{2};
State_3_Activation_Z_Score  = All_Data_Raw_Z_Scores{3};
State_4_Activation_Z_Score  = All_Data_Raw_Z_Scores{4};
State_5_Activation_Z_Score  = All_Data_Raw_Z_Scores{5};
State_6_Activation_Z_Score  = All_Data_Raw_Z_Scores{6};
State_7_Activation_Z_Score  = All_Data_Raw_Z_Scores{7};
State_8_Activation_Z_Score  = All_Data_Raw_Z_Scores{8};

State_1_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{1};
State_2_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{2};
State_3_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{3};
State_4_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{4};
State_5_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{5};
State_6_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{6};
State_7_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{7};
State_8_Activation_Sum_Z_Score  = All_Data_Sum_Z_Scores{8};

State_1_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{1};
State_2_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{2};
State_3_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{3};
State_4_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{4};
State_5_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{5};
State_6_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{6};
State_7_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{7};
State_8_Activation_AbsSum_Z_Score  = All_Data_AbsSum_Z_Scores{8};

ZDHHC9_Expression_Z_Score   = zscore(ZDHHC9_Expression);

%% 3. Determining parcel-wise correlations, NO DIRECTION, NO THRESHOLD

%  Correlations completely across show no correlations

[r1 p1] = corr(State_1_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);
[r2 p2] = corr(State_2_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);
[r3 p3] = corr(State_3_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);
[r4 p4] = corr(State_4_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);
[r5 p5] = corr(State_5_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);
[r6 p6] = corr(State_6_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);
[r7 p7] = corr(State_7_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);
[r8 p8] = corr(State_8_Activation_Sum_Z_Score',ZDHHC9_Expression_Z_Score);

% Unthresholded scatter no direction

sz           = 35;
fontsz       = 10;
ylimits      = [-4 4];
FactorPastLastValueScale = 0.05;
All_State_Activations    = {[State_1_Activation_Sum_Z_Score] [State_2_Activation_Sum_Z_Score]...
                            [State_3_Activation_Sum_Z_Score] [State_4_Activation_Sum_Z_Score]...
                            [State_5_Activation_Sum_Z_Score] [State_6_Activation_Sum_Z_Score]...
                            [State_7_Activation_Sum_Z_Score] [State_8_Activation_Sum_Z_Score]};
All_State_Correlations_P =  {p1 p2 p3 p4 p5 p6 p7 p8};
All_State_Correlations_R =  {r1 r2 r3 r4 r5 r6 r7 r8};

figure;
for i = 1:length(All_State_Activations);
subplot(4,2,i);
scatter(All_State_Activations{i},ZDHHC9_Expression_Z_Score,sz,'k','filled');
title(sprintf('State %g: %s. p = %0.5g, r = %0.5g',states(i),stateNames{i},All_State_Correlations_P{i},All_State_Correlations_R{i}));
xlabel('Activation Z Score');
ylabel('ZDHHC9 expression Z Score');
xlim([min(All_State_Activations{i})-FactorPastLastValueScale*min(All_State_Activations{i}) max(All_State_Activations{i})+FactorPastLastValueScale*max(All_State_Activations{i})]);
ylim(ylimits);
set(gca,'FontSize',fontsz,'TickLength',[0 0]);
set(gcf,'Position',Squaresize);
hold on 
lsline
end

%% 4. THRESHOLDING BY RAW Z SCORE - Activation

%%%%%%%% THRESHOLDING ACTIVATION BY RAW Z SCORE %%%%%%%%%%%%%

RawThreshold            = 0.2; 
ValueOfSigActivation    = RawThreshold; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TablePositiveParcels_A  = 'No'; % 'Yes' or 'No' - will provide a table of thresholded parcels
TableNegativeParcels_A  = 'No'; %  Change these names away from factor

% Positive

Significant_Activation_Indexes_Pos = {zeros(1,length(All_Data_Sum_Z_Scores{1}))};
for i = 1:length(All_Data_Sum_Z_Scores)
    for j = 1:length(All_Data_Sum_Z_Scores{1})
        if All_Data_Sum_Z_Scores{i}(j) > ValueOfSigActivation
           Significant_Activation_Indexes_Pos{i}(j) = find(All_Data_Sum_Z_Scores{i}(j));
        else
           Significant_Activation_Indexes_Pos{i}(j) = 0;
        end
    end
end

Sig_Activation_Indexes_Pos  = {};
for i = 1:length(Significant_Activation_Indexes_Pos)
    Sig_Activation_Indexes_Pos{i}  = find(Significant_Activation_Indexes_Pos{i});
end

Sig_Activation_Labels_Pos   = {};
for i = 1:length(Sig_Activation_Indexes_Pos)
    Sig_Activation_Labels_Pos{i} = Labels(Sig_Activation_Indexes_Pos{i});
end

Sig_Activation_LabelNames_Pos   = {};
for i = 1:length(Sig_Activation_Indexes_Pos)
    Sig_Activation_LabelNames_Pos{i} = LabelNames(Sig_Activation_Indexes_Pos{i});
end

if strcmpi(TablePositiveParcels_A,'Yes')
   PositiveParcels_A     = table(Sig_Activation_LabelNames_Pos{1},Sig_Activation_LabelNames_Pos{2},....
                               Sig_Activation_LabelNames_Pos{3},Sig_Activation_LabelNames_Pos{4},...
                               Sig_Activation_LabelNames_Pos{5},Sig_Activation_LabelNames_Pos{6},...
                               Sig_Activation_LabelNames_Pos{7},Sig_Activation_LabelNames_Pos{8});
   PositiveParcels_A.Properties.Description   = sprintf('Activation >%g Z Score, by DK Parcel',ValueOfSigActivation);
   PositiveParcels_A.Properties.VariableNames = stateNames_Table;
   PositiveParcels_A
else
   disp('Select -Yes- on TablePositiveParcels_A to see label names for each state - by raw score');
end

% Negative

Significant_Activation_Indexes_Neg = {zeros(1,length(All_Data_Sum_Z_Scores{1}))};
for i = 1:length(All_Data_Sum_Z_Scores)
    for j = 1:length(All_Data_Sum_Z_Scores{1})
        if All_Data_Sum_Z_Scores{i}(j) < -ValueOfSigActivation
           Significant_Activation_Indexes_Neg{i}(j) = find(All_Data_Sum_Z_Scores{i}(j));
        else
           Significant_Activation_Indexes_Neg{i}(j) = 0;
        end
    end
end

Sig_Activation_Indexes_Neg  = {};
for i = 1:length(Significant_Activation_Indexes_Neg)
    Sig_Activation_Indexes_Neg{i}  = find(Significant_Activation_Indexes_Neg{i});
end

Sig_Activation_Labels_Neg   = {};
for i = 1:length(Sig_Activation_Indexes_Neg)
    Sig_Activation_Labels_Neg{i} = Labels(Sig_Activation_Indexes_Neg{i});
end

Sig_Activation_LabelNames_Neg   = {};
for i = 1:length(Sig_Activation_Indexes_Neg)
    Sig_Activation_LabelNames_Neg{i} = LabelNames(Sig_Activation_Indexes_Neg{i});
end

if strcmpi(TableNegativeParcels_A,'Yes')
   NegativeParcels_A      = table(Sig_Activation_LabelNames_Neg{1},Sig_Activation_LabelNames_Neg{2},....
                               Sig_Activation_LabelNames_Neg{3},Sig_Activation_LabelNames_Neg{4},...
                               Sig_Activation_LabelNames_Neg{5},Sig_Activation_LabelNames_Neg{6},...
                               Sig_Activation_LabelNames_Neg{7},Sig_Activation_LabelNames_Neg{8});
   NegativeParcels_A.Properties.Description   = sprintf('Activation <%g Z Score, by DK Parcel',ValueOfSigActivation);
   NegativeParcels_A.Properties.VariableNames = stateNames_Table;
   NegativeParcels_A
else
   disp('Select -Yes- on TableNegativeParcels_A to see label names for each state - by raw score');
end

% We want to correlate ZDHHC9 with gene expression at the regions that are highly active

High_State_1_Activation_Sum_Z_Score = double(State_1_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{1}));
High_State_2_Activation_Sum_Z_Score = double(State_2_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{2}));
High_State_3_Activation_Sum_Z_Score = double(State_3_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{3}));
High_State_4_Activation_Sum_Z_Score = double(State_4_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{4}));
High_State_5_Activation_Sum_Z_Score = double(State_5_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{5}));
High_State_6_Activation_Sum_Z_Score = double(State_6_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{6}));
High_State_7_Activation_Sum_Z_Score = double(State_7_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{7}));
High_State_8_Activation_Sum_Z_Score = double(State_8_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{8}));

Low_State_1_Activation_Sum_Z_Score  = double(State_1_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{1}));
Low_State_2_Activation_Sum_Z_Score  = double(State_2_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{2}));
Low_State_3_Activation_Sum_Z_Score  = double(State_3_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{3}));
Low_State_4_Activation_Sum_Z_Score  = double(State_4_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{4}));
Low_State_5_Activation_Sum_Z_Score  = double(State_5_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{5}));
Low_State_6_Activation_Sum_Z_Score  = double(State_6_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{6}));
Low_State_7_Activation_Sum_Z_Score  = double(State_7_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{7}));
Low_State_8_Activation_Sum_Z_Score  = double(State_8_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{8}));

% Get the ZDHHC9 expressions at these locales

High_Activation_State_1_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{1}));
High_Activation_State_2_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{2}));
High_Activation_State_3_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{3}));
High_Activation_State_4_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{4}));
High_Activation_State_5_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{5}));
High_Activation_State_6_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{6}));
High_Activation_State_7_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{7}));
High_Activation_State_8_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{8}));

Low_Activation_State_1_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{1}));
Low_Activation_State_2_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{2}));
Low_Activation_State_3_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{3}));
Low_Activation_State_4_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{4}));
Low_Activation_State_5_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{5}));
Low_Activation_State_6_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{6}));
Low_Activation_State_7_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{7}));
Low_Activation_State_8_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{8}));

% Correlate highly active regions with ZDHHC9 expression

[r1h p1h] = corr(High_State_1_Activation_Sum_Z_Score',High_Activation_State_1_ZDHHC9_Expression_Z);
[r2h p2h] = corr(High_State_2_Activation_Sum_Z_Score',High_Activation_State_2_ZDHHC9_Expression_Z);
[r3h p3h] = corr(High_State_3_Activation_Sum_Z_Score',High_Activation_State_3_ZDHHC9_Expression_Z);
[r4h p4h] = corr(High_State_4_Activation_Sum_Z_Score',High_Activation_State_4_ZDHHC9_Expression_Z);
[r5h p5h] = corr(High_State_5_Activation_Sum_Z_Score',High_Activation_State_5_ZDHHC9_Expression_Z);
[r6h p6h] = corr(High_State_6_Activation_Sum_Z_Score',High_Activation_State_6_ZDHHC9_Expression_Z);
[r7h p7h] = corr(High_State_7_Activation_Sum_Z_Score',High_Activation_State_7_ZDHHC9_Expression_Z);
[r8h p8h] = corr(High_State_8_Activation_Sum_Z_Score',High_Activation_State_8_ZDHHC9_Expression_Z);

[r1l p1l] = corr(Low_State_1_Activation_Sum_Z_Score',Low_Activation_State_1_ZDHHC9_Expression_Z);
[r2l p2l] = corr(Low_State_2_Activation_Sum_Z_Score',Low_Activation_State_2_ZDHHC9_Expression_Z);
[r3l p3l] = corr(Low_State_3_Activation_Sum_Z_Score',Low_Activation_State_3_ZDHHC9_Expression_Z);
[r4l p4l] = corr(Low_State_4_Activation_Sum_Z_Score',Low_Activation_State_4_ZDHHC9_Expression_Z);
[r5l p5l] = corr(Low_State_5_Activation_Sum_Z_Score',Low_Activation_State_5_ZDHHC9_Expression_Z);
[r6l p6l] = corr(Low_State_6_Activation_Sum_Z_Score',Low_Activation_State_6_ZDHHC9_Expression_Z);
[r7l p7l] = corr(Low_State_7_Activation_Sum_Z_Score',Low_Activation_State_7_ZDHHC9_Expression_Z);
[r8l p8l] = corr(Low_State_8_Activation_Sum_Z_Score',Low_Activation_State_8_ZDHHC9_Expression_Z);

All_State_Activations_High_Thresholded = {[High_State_1_Activation_Sum_Z_Score] [High_State_2_Activation_Sum_Z_Score]...
                                          [High_State_3_Activation_Sum_Z_Score] [High_State_4_Activation_Sum_Z_Score]...
                                          [High_State_5_Activation_Sum_Z_Score] [High_State_6_Activation_Sum_Z_Score]...
                                          [High_State_7_Activation_Sum_Z_Score] [High_State_8_Activation_Sum_Z_Score]};                                   
All_State_Expressions_High_Thresholded = {[High_Activation_State_1_ZDHHC9_Expression_Z] [High_Activation_State_2_ZDHHC9_Expression_Z]...
                                          [High_Activation_State_3_ZDHHC9_Expression_Z] [High_Activation_State_4_ZDHHC9_Expression_Z]...
                                          [High_Activation_State_5_ZDHHC9_Expression_Z] [High_Activation_State_6_ZDHHC9_Expression_Z]...
                                          [High_Activation_State_7_ZDHHC9_Expression_Z] [High_Activation_State_8_ZDHHC9_Expression_Z]};
All_State_Correlations_High_P          = {[p1h] [p2h] [p3h] [p4h] [p5h] [p6h] [p7h] [p8h]};
All_State_Correlations_High_R          = {[r1h] [r2h] [r3h] [r4h] [r5h] [r6h] [r7h] [r8h]};


All_State_Activations_Low_Thresholded  = {[Low_State_1_Activation_Sum_Z_Score] [Low_State_2_Activation_Sum_Z_Score]...
                                          [Low_State_3_Activation_Sum_Z_Score] [Low_State_4_Activation_Sum_Z_Score]...
                                          [Low_State_5_Activation_Sum_Z_Score] [Low_State_6_Activation_Sum_Z_Score]...
                                          [Low_State_7_Activation_Sum_Z_Score] [Low_State_8_Activation_Sum_Z_Score]};
All_State_Expressions_Low_Thresholded  = {[Low_Activation_State_1_ZDHHC9_Expression_Z] [Low_Activation_State_2_ZDHHC9_Expression_Z]...
                                          [Low_Activation_State_3_ZDHHC9_Expression_Z] [Low_Activation_State_4_ZDHHC9_Expression_Z]...
                                          [Low_Activation_State_5_ZDHHC9_Expression_Z] [Low_Activation_State_6_ZDHHC9_Expression_Z]...
                                          [Low_Activation_State_7_ZDHHC9_Expression_Z] [Low_Activation_State_8_ZDHHC9_Expression_Z]};
All_State_Correlations_Low_P           = {[p1l] [p2l] [p3l] [p4l] [p5l] [p6l] [p7l] [p8l]};
All_State_Correlations_Low_R           = {[r1l] [r2l] [r3l] [r4l] [r5l] [r6l] [r7l] [r8l]};

sz           = 35;
fontsz       = 10;
x_high       = [ValueOfSigActivation ValueOfSigActivation];
x_low        = [-ValueOfSigActivation -ValueOfSigActivation];
y            = [-10 10];
ylimits      = [-4 4];
FactorPastLastValueScale = 0.05;
 
% Plotting high

figure;
for i = 1:length(All_State_Activations_High_Thresholded);
subplot(4,2,i);
scatter(All_State_Activations_High_Thresholded{i},All_State_Expressions_High_Thresholded{i},sz,'r','filled');
title(sprintf('State %g: %s. p = %0.5g, r = %0.5g',states(i),stateNames{i},All_State_Correlations_High_P{i},All_State_Correlations_High_R{i}));
xlabel('Positive activation Z Score');
ylabel('ZDHHC9 expression Z Score');
xlim([0 max(All_State_Activations_High_Thresholded{i})+FactorPastLastValueScale*max(All_State_Activations_High_Thresholded{i})]);
ylim(ylimits);
set(gca,'FontSize',fontsz,'TickLength',[0 0]);
hold on 
if ValueOfSigActivation ~= 0
line(x_high,y,'Color','red'); %Use this when thresholding only
end
lsline
set(gcf,'Position',Squaresize);
end

% Plotting low
figure;
for i = 1:length(All_State_Activations_Low_Thresholded);
subplot(4,2,i);
scatter(All_State_Activations_Low_Thresholded{i},All_State_Expressions_Low_Thresholded{i},sz,'b','filled');
title(sprintf('State %g: %s. p = %0.5g, r = %0.5g',states(i),stateNames{i},All_State_Correlations_Low_P{i},All_State_Correlations_Low_R{i}));
xlabel('Negative activation Z Score');
ylabel('ZDHHC9 expression Z Score');
xlim([-max(abs(All_State_Activations_Low_Thresholded{i}))-FactorPastLastValueScale*max(abs(All_State_Activations_Low_Thresholded{i})) 0]);
ylim(ylimits);
set(gca,'FontSize',fontsz,'TickLength',[0 0]);
hold on 
if ValueOfSigActivation ~= 0
line(x_low,y,'Color','blue');
end
lsline
set(gcf,'Position',Squaresize);
end

%% 5. THRESHOLDING BY FACTOR - Activation

clear All_State_Activations_High_Thresholded
clear All_State_Activations_Low_Thresholded
clear All_State_Expressions_High_Thresholded
clear All_State_Expressions_Low_Thresholded
clear All_State_Correlations_High_P
clear All_State_Correlations_High_R
clear All_State_Correlations_Low_P
clear All_State_Correlations_Low_R
clear r1h r2h r3h r4h r5h r6h r7h r8h p1h p2h p3h p4h p5h p6h p7h p8h
clear r1l r2l r3l r4l r5l r6l r7l r8l p1l p2l p3l p4l p5l p6l p7l p8l
clear TablePositiveParcels_A
clear TableNegativeParcels_A
clear sz
clear fontsz

%%%%%%%% THRESHOLDING ACTIVATION BY FACTOR %%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Activation - Expression - Threshold Relationships

LoopOverThresholds         = 'No';
ThresholdsToLoop           = linspace(0,0.99,1000); % if > 8 iterations, no figures per iteration will be formed
seeRelationships           = 'No';
ComputeOneThreshold        = 'Yes';          
ThresholdToCompute         = 0.3;      % Parcel - Permutation trade off. I would define a minimum parcel and thereshold to that.
TestIteration              = 20000;      % Number of iterations for permuation test
CorrelatePermuteTest       = 'Yes';
NullDistType               = 'InState'; % AllState or InState
PlotPositiveNegative       = 'Yes';
PlotAbsolute               = 'Yes';

% Produce Scatters?
ScatterParcelWiseHigh      = 'No';
ScatterParcelWiseLow       = 'No';
ScatterStateWiseHigh       = 'No';
ScatterStateWiseLow        = 'No';
sz                         = 35;
fontsz                     = 15;

% Produce Tables?
TablePositiveParcels_A     = 'Yes'; % Output = PositiveParcels_A
TableNegativeParcels_A     = 'Yes'; % Output = NegativeParcels_A
TableStateSummedActivation = 'Yes'; % Output = State_Activation_High & State_Expression_Low
TableStateSummedExpression = 'Yes'; % Output = State_Expression_High & State_Expression_Low

% Save?
SaveScatters               = 'No';
WhereToSaveScatter         = '/Users/Dan/Desktop/Test/';
SaveTables                 = 'No';
FileType                   = '.xls'; %.txt, .dat, .csv, xls, etc...
WhereToSaveTables          = '/Users/Dan/Desktop/Correlations/Tables/60%/'; % keep / at end
SavePermuations            = 'No';
WhereToSavePermuations     = '/Users/Dan/Desktop/';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if strcmpi(LoopOverThresholds,'Yes');
   DeterminedThreshold = ThresholdsToLoop;
else
   clear ThresholdsToLoop;
   disp('Not determining Activation - Expression - Threshold relationships');
end

if strcmpi(ComputeOneThreshold,'Yes');
   DeterminedThreshold = ThresholdToCompute;
else
    clear ThresholdToCompute;
    disp('Not thresholding at a single value');
end

if strcmpi(LoopOverThresholds,'Yes') && strcmpi(ComputeOneThreshold, 'Yes');
    clear ThresholdsToLoop;
    clear ThresholdToCompute;
    disp('You can not select both to loop and not to loop... please select only one thresholding option');
end

if strcmpi(LoopOverThresholds,'No') && strcmpi(ComputeOneThreshold, 'No');
    clear ThresholdsToLoop;
    clear ThresholdToCompute;
    disp('... please select a thresholding option');
end

% We want to store activation and expression for increasing thresholds

if length(DeterminedThreshold) > 1 % i.e. only run for looping

stateActivationHighNames = cell(1,length(ThresholdsToLoop));
stateActivationHigh      = cell(1,length(ThresholdsToLoop));
stateExpressionHigh      = cell(1,length(ThresholdsToLoop));

stateActivationLowNames  = cell(1,length(ThresholdsToLoop));
stateActivationLow       = cell(1,length(ThresholdsToLoop));
stateExpressionLow       = cell(1,length(ThresholdsToLoop));

% add zeros(1,length(stateNames)) to all values in cells of activation and
% expression

for i = 1:length(stateActivationHigh)
    stateActivationHigh{i} = zeros(1,length(stateNames));
    stateActivationLow{i}  = zeros(1,length(stateNames));
    stateExpressionHigh{i} = zeros(1,length(stateNames));
    stateExpressionLow{i}  = zeros(1,length(stateNames));
end

end

if length(DeterminedThreshold)>8
   disp('AS ITERATIONS >8 FIGURE AND TABLE SAVING DISABLED')
   SaveScatter = 'No';
   SaveTable   = 'No';
end

Iteration = 1;

for i = DeterminedThreshold % You can run multiple at one go, and plot the difference in state activation/expression

FactorThreshold = i; % This is the threshold value
ValueOfSigActivation_factor = FactorThreshold; 

% Positive

Significant_Activation_Indexes_Pos = {zeros(1,length(All_Data_Sum_Z_Scores{1}))};
for i = 1:length(All_Data_Sum_Z_Scores)
    for j = 1:length(All_Data_Sum_Z_Scores{i})
        if All_Data_Sum_Z_Scores{i}(j) > ValueOfSigActivation_factor * max(abs(All_Data_Sum_Z_Scores{i}))
           Significant_Activation_Indexes_Pos{i}(j) = find(All_Data_Sum_Z_Scores{i}(j));
        else
           Significant_Activation_Indexes_Pos{i}(j) = 0;
        end
    end
end

Sig_Activation_Indexes_Pos  = {};
for i = 1:length(Significant_Activation_Indexes_Pos)
    Sig_Activation_Indexes_Pos{i}  = find(Significant_Activation_Indexes_Pos{i});
end

Sig_Activation_Labels_Pos   = {};
for i = 1:length(Sig_Activation_Indexes_Pos)
    Sig_Activation_Labels_Pos{i} = Labels(Sig_Activation_Indexes_Pos{i});
end

Sig_Activation_LabelNames_Pos   = {};
for i = 1:length(Sig_Activation_Indexes_Pos)
    Sig_Activation_LabelNames_Pos{i} = LabelNames(Sig_Activation_Indexes_Pos{i});
end

if strcmpi(TablePositiveParcels_A,'Yes');
   
% Make all same length so can make them the same length
               
                addZeros = [];
                for i = 1:length(Sig_Activation_LabelNames_Pos);
                    addZeros(i) = length(Sig_Activation_LabelNames_Pos{i});
                end
                maxVal      = max(addZeros);
                for i = 1:length(Sig_Activation_LabelNames_Pos);
                    newVec = [addZeros(i)+1:1:maxVal];
                    for j = 1:length(newVec)
                        Sig_Activation_LabelNames_Pos{i}{newVec(j)} = '';
                    end
                end
 
% Form the table
   
   PositiveParcels_A   = table(Sig_Activation_LabelNames_Pos{1}',Sig_Activation_LabelNames_Pos{2}',....
                               Sig_Activation_LabelNames_Pos{3}',Sig_Activation_LabelNames_Pos{4}',...
                               Sig_Activation_LabelNames_Pos{5}',Sig_Activation_LabelNames_Pos{6}',...
                               Sig_Activation_LabelNames_Pos{7}',Sig_Activation_LabelNames_Pos{8}');
   PositiveParcels_A.Properties.Description   = sprintf('Activation >%gx maximum Z Score, by DK Parcel',ValueOfSigActivation_factor);
   PositiveParcels_A.Properties.VariableNames = stateNames_Table;
   PositiveParcels_A
else
   disp('Select -Yes- on TablePositiveParcels_A to see label names for each state');
end

% Negative

Significant_Activation_Indexes_Neg = {zeros(1,length(All_Data_Sum_Z_Scores{1}))};
for i = 1:length(All_Data_Sum_Z_Scores)
    for j = 1:length(All_Data_Sum_Z_Scores{i})
        if All_Data_Sum_Z_Scores{i}(j) < -ValueOfSigActivation_factor * max(abs(All_Data_Sum_Z_Scores{i}))
           Significant_Activation_Indexes_Neg{i}(j) = find(All_Data_Sum_Z_Scores{i}(j));
        else
           Significant_Activation_Indexes_Neg{i}(j) = 0;
        end
    end
end

Sig_Activation_Indexes_Neg  = {};
for i = 1:length(Significant_Activation_Indexes_Neg)
    Sig_Activation_Indexes_Neg{i}  = find(Significant_Activation_Indexes_Neg{i});
end

Sig_Activation_Labels_Neg   = {};
for i = 1:length(Sig_Activation_Indexes_Neg)
    Sig_Activation_Labels_Neg{i} = Labels(Sig_Activation_Indexes_Neg{i});
end

Sig_Activation_LabelNames_Neg   = {};
for i = 1:length(Sig_Activation_Indexes_Neg)
    Sig_Activation_LabelNames_Neg{i} = LabelNames(Sig_Activation_Indexes_Neg{i});
end

if strcmpi(TableNegativeParcels_A,'Yes')
    
                addZeros = [];
                for i = 1:length(Sig_Activation_LabelNames_Neg);
                addZeros(i) = length(Sig_Activation_LabelNames_Neg{i});
                end
                maxVal      = max(addZeros);
                for i = 1:length(Sig_Activation_LabelNames_Neg);
                    newVec = [addZeros(i)+1:1:maxVal];
                    for j = 1:length(newVec)
                        Sig_Activation_LabelNames_Neg{i}{newVec(j)} = '';
                    end
                end    
    
   NegativeParcels_A   = table(Sig_Activation_LabelNames_Neg{1}',Sig_Activation_LabelNames_Neg{2}',....
                               Sig_Activation_LabelNames_Neg{3}',Sig_Activation_LabelNames_Neg{4}',...
                               Sig_Activation_LabelNames_Neg{5}',Sig_Activation_LabelNames_Neg{6}',...
                               Sig_Activation_LabelNames_Neg{7}',Sig_Activation_LabelNames_Neg{8}');
   NegativeParcels_A.Properties.Description   = sprintf('Activation <%gz minimum Z Score, by DK Parcel',ValueOfSigActivation_factor);
   NegativeParcels_A.Properties.VariableNames = stateNames_Table;
   NegativeParcels_A
else
   disp('Select -Yes- on TableNegativeParcels_A to see label names for each state');
end

% We want to correlate ZDHHC9 with gene expression at the regions that are highly active

High_State_1_Activation_Sum_Z_Score = double(State_1_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{1}));
High_State_2_Activation_Sum_Z_Score = double(State_2_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{2}));
High_State_3_Activation_Sum_Z_Score = double(State_3_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{3}));
High_State_4_Activation_Sum_Z_Score = double(State_4_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{4}));
High_State_5_Activation_Sum_Z_Score = double(State_5_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{5}));
High_State_6_Activation_Sum_Z_Score = double(State_6_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{6}));
High_State_7_Activation_Sum_Z_Score = double(State_7_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{7}));
High_State_8_Activation_Sum_Z_Score = double(State_8_Activation_Sum_Z_Score(Sig_Activation_Indexes_Pos{8}));

Low_State_1_Activation_Sum_Z_Score  = double(State_1_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{1}));
Low_State_2_Activation_Sum_Z_Score  = double(State_2_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{2}));
Low_State_3_Activation_Sum_Z_Score  = double(State_3_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{3}));
Low_State_4_Activation_Sum_Z_Score  = double(State_4_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{4}));
Low_State_5_Activation_Sum_Z_Score  = double(State_5_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{5}));
Low_State_6_Activation_Sum_Z_Score  = double(State_6_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{6}));
Low_State_7_Activation_Sum_Z_Score  = double(State_7_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{7}));
Low_State_8_Activation_Sum_Z_Score  = double(State_8_Activation_Sum_Z_Score(Sig_Activation_Indexes_Neg{8}));

% Get the ZDHHC9 expressions at these locales

High_Activation_State_1_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{1}));
High_Activation_State_2_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{2}));
High_Activation_State_3_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{3}));
High_Activation_State_4_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{4}));
High_Activation_State_5_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{5}));
High_Activation_State_6_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{6}));
High_Activation_State_7_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{7}));
High_Activation_State_8_ZDHHC9_Expression_Z = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Pos{8}));

Low_Activation_State_1_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{1}));
Low_Activation_State_2_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{2}));
Low_Activation_State_3_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{3}));
Low_Activation_State_4_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{4}));
Low_Activation_State_5_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{5}));
Low_Activation_State_6_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{6}));
Low_Activation_State_7_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{7}));
Low_Activation_State_8_ZDHHC9_Expression_Z  = double(ZDHHC9_Expression_Z_Score(Sig_Activation_Indexes_Neg{8}));

% Correlate highly active regions with ZDHHC9 expression

% Those that have no activation will not execute...

if ~isempty(High_State_1_Activation_Sum_Z_Score)
[r1h p1h] = corr(High_State_1_Activation_Sum_Z_Score',High_Activation_State_1_ZDHHC9_Expression_Z);
else
fprintf('High State 1 Empty\n');
r1h = 0; p1h = 0;
end
if ~isempty(High_State_2_Activation_Sum_Z_Score)
[r2h p2h] = corr(High_State_2_Activation_Sum_Z_Score',High_Activation_State_2_ZDHHC9_Expression_Z);
else
fprintf('High State 2 Empty\n');
r2h = 0; p2h = 0;
end
if ~isempty(High_State_3_Activation_Sum_Z_Score)
[r3h p3h] = corr(High_State_3_Activation_Sum_Z_Score',High_Activation_State_3_ZDHHC9_Expression_Z);
else
fprintf('High State 3 Empty\n');
r3h = 0; p3h = 0;
end
if ~isempty(High_State_4_Activation_Sum_Z_Score)
[r4h p4h] = corr(High_State_4_Activation_Sum_Z_Score',High_Activation_State_4_ZDHHC9_Expression_Z);
else
fprintf('High State 4 Empty');
r4h = 0; p4h = 0;
end
if ~isempty(High_State_5_Activation_Sum_Z_Score)
[r5h p5h] = corr(High_State_5_Activation_Sum_Z_Score',High_Activation_State_5_ZDHHC9_Expression_Z);
else
fprintf('High State 5 Empty\n');
r5h = 0; p5h = 0;
end
if ~isempty(High_State_6_Activation_Sum_Z_Score)
[r6h p6h] = corr(High_State_6_Activation_Sum_Z_Score',High_Activation_State_6_ZDHHC9_Expression_Z);
else
fprintf('High State 6 Empty\n');
r6h = 0; p6h = 0;
end
if ~isempty(High_State_7_Activation_Sum_Z_Score)
[r7h p7h] = corr(High_State_7_Activation_Sum_Z_Score',High_Activation_State_7_ZDHHC9_Expression_Z);
else
fprintf('High State 7 Empty\n');
r7h = 0; p7h = 0;
end
if ~isempty(High_State_8_Activation_Sum_Z_Score)
[r8h p8h] = corr(High_State_8_Activation_Sum_Z_Score',High_Activation_State_8_ZDHHC9_Expression_Z);
else
fprintf('High State 8 Empty\n');
r8h = 0; p8h = 0;
end

if ~isempty(Low_State_1_Activation_Sum_Z_Score)
[r1l p1l] = corr(Low_State_1_Activation_Sum_Z_Score',Low_Activation_State_1_ZDHHC9_Expression_Z);
else
fprintf('Low State 1 Empty\n');
r1l = 0; p1l = 0;
end
if ~isempty(Low_State_2_Activation_Sum_Z_Score)
[r2l p2l] = corr(Low_State_2_Activation_Sum_Z_Score',Low_Activation_State_2_ZDHHC9_Expression_Z);
else
fprintf('Low State 2 Empty\n');
r2l = 0; p2l = 0;
end
if ~isempty(Low_State_3_Activation_Sum_Z_Score)
[r3l p3l] = corr(Low_State_3_Activation_Sum_Z_Score',Low_Activation_State_3_ZDHHC9_Expression_Z);
else
fprintf('Low State 3 Empty\n');
r3l = 0; p3l = 0;
end
if ~isempty(Low_State_4_Activation_Sum_Z_Score)
[r4l p4l] = corr(Low_State_4_Activation_Sum_Z_Score',Low_Activation_State_4_ZDHHC9_Expression_Z);
else
fprintf('Low State 4 Empty\n');
r4l = 0; p4l = 0;
end
if ~isempty(Low_State_5_Activation_Sum_Z_Score)
[r5l p5l] = corr(Low_State_5_Activation_Sum_Z_Score',Low_Activation_State_5_ZDHHC9_Expression_Z);
else
fprintf('Low State 5 Empty\n');
r5l = 0; p5l = 0;
end
if ~isempty(Low_State_6_Activation_Sum_Z_Score)
[r6l p6l] = corr(Low_State_6_Activation_Sum_Z_Score',Low_Activation_State_6_ZDHHC9_Expression_Z);
else
fprintf('Low State 6 Empty\n');
r6l = 0; p6l = 0;
end
if ~isempty(Low_State_7_Activation_Sum_Z_Score)
[r7l p7l] = corr(Low_State_7_Activation_Sum_Z_Score',Low_Activation_State_7_ZDHHC9_Expression_Z);
else
fprintf('Low State 7 Empty');
r7l = 0; p7l = 0;
end
if ~isempty(Low_State_8_Activation_Sum_Z_Score)
[r8l p8l] = corr(Low_State_8_Activation_Sum_Z_Score',Low_Activation_State_8_ZDHHC9_Expression_Z);
else
fprintf('Low State 8 Empty\n');
r8l = 0; p8l = 0;
end

All_State_Activations_High_Thresholded = {[High_State_1_Activation_Sum_Z_Score] [High_State_2_Activation_Sum_Z_Score]...
                                          [High_State_3_Activation_Sum_Z_Score] [High_State_4_Activation_Sum_Z_Score]...
                                          [High_State_5_Activation_Sum_Z_Score] [High_State_6_Activation_Sum_Z_Score]...
                                          [High_State_7_Activation_Sum_Z_Score] [High_State_8_Activation_Sum_Z_Score]};                                   
All_State_Expressions_High_Thresholded = {[High_Activation_State_1_ZDHHC9_Expression_Z] [High_Activation_State_2_ZDHHC9_Expression_Z]...
                                          [High_Activation_State_3_ZDHHC9_Expression_Z] [High_Activation_State_4_ZDHHC9_Expression_Z]...
                                          [High_Activation_State_5_ZDHHC9_Expression_Z] [High_Activation_State_6_ZDHHC9_Expression_Z]...
                                          [High_Activation_State_7_ZDHHC9_Expression_Z] [High_Activation_State_8_ZDHHC9_Expression_Z]};
All_State_Correlations_High_P          = {[p1h] [p2h] [p3h] [p4h] [p5h] [p6h] [p7h] [p8h]};
All_State_Correlations_High_R          = {[r1h] [r2h] [r3h] [r4h] [r5h] [r6h] [r7h] [r8h]};


All_State_Activations_Low_Thresholded  = {[Low_State_1_Activation_Sum_Z_Score] [Low_State_2_Activation_Sum_Z_Score]...
                                          [Low_State_3_Activation_Sum_Z_Score] [Low_State_4_Activation_Sum_Z_Score]...
                                          [Low_State_5_Activation_Sum_Z_Score] [Low_State_6_Activation_Sum_Z_Score]...
                                          [Low_State_7_Activation_Sum_Z_Score] [Low_State_8_Activation_Sum_Z_Score]};
All_State_Expressions_Low_Thresholded  = {[Low_Activation_State_1_ZDHHC9_Expression_Z] [Low_Activation_State_2_ZDHHC9_Expression_Z]...
                                          [Low_Activation_State_3_ZDHHC9_Expression_Z] [Low_Activation_State_4_ZDHHC9_Expression_Z]...
                                          [Low_Activation_State_5_ZDHHC9_Expression_Z] [Low_Activation_State_6_ZDHHC9_Expression_Z]...
                                          [Low_Activation_State_7_ZDHHC9_Expression_Z] [Low_Activation_State_8_ZDHHC9_Expression_Z]};
All_State_Correlations_Low_P           = {[p1l] [p2l] [p3l] [p4l] [p5l] [p6l] [p7l] [p8l]};
All_State_Correlations_Low_R           = {[r1l] [r2l] [r3l] [r4l] [r5l] [r6l] [r7l] [r8l]};

y            = [-1000 1000];
ylimits      = [-4 4];
FactorPastLastValueScale = 0.05;

% Remove all empty cells/values

Non_Empty_High_Indexes                 = [~cellfun('isempty',All_State_Activations_High_Thresholded)];
All_State_Activations_High_Thresholded = All_State_Activations_High_Thresholded(Non_Empty_High_Indexes);
All_State_Expressions_High_Thresholded = All_State_Expressions_High_Thresholded(Non_Empty_High_Indexes);
All_State_Correlations_High_P          = All_State_Correlations_High_P(Non_Empty_High_Indexes);
All_State_Correlations_High_R          = All_State_Correlations_High_R(Non_Empty_High_Indexes);
Non_Empty_High_States                  = states(Non_Empty_High_Indexes);
Non_Empty_High_StateNames              = stateNames(Non_Empty_High_Indexes);

Non_Empty_Low_Indexes                  = [~cellfun('isempty',All_State_Activations_Low_Thresholded)];
All_State_Activations_Low_Thresholded  = All_State_Activations_Low_Thresholded(Non_Empty_Low_Indexes);
All_State_Expressions_Low_Thresholded  = All_State_Expressions_Low_Thresholded(Non_Empty_Low_Indexes);
All_State_Correlations_Low_P           = All_State_Correlations_Low_P(Non_Empty_Low_Indexes);
All_State_Correlations_Low_R           = All_State_Correlations_Low_R(Non_Empty_Low_Indexes);
Non_Empty_Low_States                   = states(Non_Empty_Low_Indexes);
Non_Empty_Low_StateNames               = stateNames(Non_Empty_Low_Indexes);

% Plotting parcel-wise high

if strcmpi(ScatterParcelWiseHigh,'Yes');
figure;
for i = 1:length(All_State_Activations_High_Thresholded);
s(i) = subplot(ceil(length(All_State_Activations_High_Thresholded)/2),2,i);
scatter(All_State_Activations_High_Thresholded{i},All_State_Expressions_High_Thresholded{i},sz,'r','filled');
title(sprintf('State %g: %s. p = %0.5g, r = %0.5g',Non_Empty_High_States(i),Non_Empty_High_StateNames{i},All_State_Correlations_High_P{i},All_State_Correlations_High_R{i}));
xlabel('Positive activation Z Score');
ylabel('ZDHHC9 expression Z Score');
xlim([0 max(All_State_Activations_High_Thresholded{i})+FactorPastLastValueScale*max(All_State_Activations_High_Thresholded{i})]);
ylim(ylimits);
set(gca,'FontSize',fontsz,'TickLength',[0 0]);
hold on 
if ValueOfSigActivation_factor ~= 0
line([max(abs(All_State_Activations_High_Thresholded{i}*ValueOfSigActivation_factor)), max(abs(All_State_Activations_High_Thresholded{i}*ValueOfSigActivation_factor))],y,'Color','red');
end
lsline
set(gcf,'Position',Squaresize);
end
else
    disp('Select -Yes- on ScatterParcelWiseHigh to see GLEAN-Gene correlations for high-thresholded DK parcellations');
end

% Plotting parcel-wise low

if strcmpi(ScatterParcelWiseLow,'Yes')
figure;
for i = 1:length(All_State_Activations_Low_Thresholded);
s(i) = subplot(ceil(length(All_State_Activations_Low_Thresholded)/2),2,i);
scatter(All_State_Activations_Low_Thresholded{i},All_State_Expressions_Low_Thresholded{i},sz,'b','filled');
title(sprintf('State %g: %s. p = %0.5g, r = %0.5g',Non_Empty_Low_States(i),Non_Empty_Low_StateNames{i},All_State_Correlations_Low_P{i},All_State_Correlations_Low_R{i}));
xlabel('Negative activation Z Score');
ylabel('ZDHHC9 expression Z Score');
xlim([-max(abs(All_State_Activations_Low_Thresholded{i}))-FactorPastLastValueScale*max(abs(All_State_Activations_Low_Thresholded{i})) 0]);
ylim(ylimits);
set(gca,'FontSize',fontsz,'TickLength',[0 0]);
hold on 
if ValueOfSigActivation_factor ~= 0
line([-max(abs(All_State_Activations_Low_Thresholded{i}*ValueOfSigActivation_factor)), -max(abs(All_State_Activations_Low_Thresholded{i}*ValueOfSigActivation_factor))],y,'Color','blue');
end
lsline
set(gcf,'Position',Squaresize);
end
else
    disp('Select -Yes- on ScatterParcelWiseLow to see GLEAN-Gene correlations for low-thresholded DK parcellations');
end

%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$
%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$%#$

% Sum up total expression and activation in each state

% This can be done by either summing parcel Z scores, or summing parcel raw activation then Z scoring
% Method 1 - summing parcel Z scores
% Method 2 - summing parcel raw scores, then Z scoring 

% At the moment we can only run Method 1

Summed_State_Activations_High = {};
Summed_State_Expressions_High = {};
for i = 1:length(All_State_Activations_High_Thresholded);
Summed_State_Activations_High{i}          = sum(All_State_Activations_High_Thresholded{i});
Summed_State_Expressions_High{i}          = sum(All_State_Expressions_High_Thresholded{i});
end
Summed_State_Activations_High             = cell2mat(Summed_State_Activations_High);
Summed_State_Expressions_High             = cell2mat(Summed_State_Expressions_High);

Summed_State_Activations_Low = {};
Summed_State_Expressions_Low = {};
for i = 1:length(All_State_Activations_Low_Thresholded);
Summed_State_Activations_Low{i}           = sum(All_State_Activations_Low_Thresholded{i});
Summed_State_Expressions_Low{i}           = sum(All_State_Expressions_Low_Thresholded{i});
end
Summed_State_Activations_Low              = cell2mat(Summed_State_Activations_Low);
Summed_State_Expressions_Low              = cell2mat(Summed_State_Expressions_Low);

% Table of state wise high and low, activation and expressions 

if strcmpi(TableStateSummedActivation,'Yes')
    
Summed_State_Activations_High_Total = zeros(1,8);
Indexes                             = find(Non_Empty_High_Indexes);
for i = 1:length(Indexes)
    Summed_State_Activations_High_Total(Indexes(i)) = Summed_State_Activations_High(i);
end

Summed_State_Activations_Low_Total  = zeros(1,8);
Indexes                             = find(Non_Empty_Low_Indexes);
for i = 1:length(Indexes)
    Summed_State_Activations_Low_Total(Indexes(i))  = Summed_State_Activations_Low(i);
end

clear Indexes;

   State_Activation_High    = table(Summed_State_Activations_High_Total(1),Summed_State_Activations_High_Total(2),....
                               Summed_State_Activations_High_Total(3),Summed_State_Activations_High_Total(4),...
                               Summed_State_Activations_High_Total(5),Summed_State_Activations_High_Total(6),...
                               Summed_State_Activations_High_Total(7),Summed_State_Activations_High_Total(8));
   State_Activation_High.Properties.Description   = sprintf('Summed Activation >%gx maximum Z Score, by state',ValueOfSigActivation_factor);
   State_Activation_High.Properties.VariableNames = stateNames_Table;
   State_Activation_High
   
   State_Activation_Low     = table(Summed_State_Activations_Low_Total(1),Summed_State_Activations_Low_Total(2),....
                               Summed_State_Activations_Low_Total(3),Summed_State_Activations_Low_Total(4),...
                               Summed_State_Activations_Low_Total(5),Summed_State_Activations_Low_Total(6),...
                               Summed_State_Activations_Low_Total(7),Summed_State_Activations_Low_Total(8));
   State_Activation_Low.Properties.Description   = sprintf('Summed Activation <%gx minimum Z Score, by state',ValueOfSigActivation_factor);
   State_Activation_Low.Properties.VariableNames = stateNames_Table;
   State_Activation_Low
else
   disp('Select -Yes- on TableStateSummedActivation to see summed activation within each state');
end

if strcmpi(TableStateSummedExpression,'Yes');
    
Summed_State_Expressions_High_Total = zeros(1,8);
Indexes                             = find(Non_Empty_High_Indexes);
for i = 1:length(Indexes)
    Summed_State_Expressions_High_Total(Indexes(i)) = Summed_State_Expressions_High(i);
end

Summed_State_Expressions_Low_Total  = zeros(1,8);
Indexes                             = find(Non_Empty_Low_Indexes);
for i = 1:length(Indexes)
    Summed_State_Expressions_Low_Total(Indexes(i))  = Summed_State_Expressions_Low(i);
end

clear Indexes;

   State_Expression_High    = table(Summed_State_Expressions_High_Total(1),Summed_State_Expressions_High_Total(2),....
                               Summed_State_Expressions_High_Total(3),Summed_State_Expressions_High_Total(4),...
                               Summed_State_Expressions_High_Total(5),Summed_State_Expressions_High_Total(6),...
                               Summed_State_Expressions_High_Total(7),Summed_State_Expressions_High_Total(8));
   State_Expression_High.Properties.Description   = sprintf('Summed expression at regions with activation >%gx maximum Z Score, by state',ValueOfSigActivation_factor);
   State_Expression_High.Properties.VariableNames = stateNames_Table;
   State_Expression_High
   
   State_Expression_Low     = table(Summed_State_Expressions_Low_Total(1),Summed_State_Expressions_Low_Total(2),....
                               Summed_State_Expressions_Low_Total(3),Summed_State_Expressions_Low_Total(4),...
                               Summed_State_Expressions_Low_Total(5),Summed_State_Expressions_Low_Total(6),...
                               Summed_State_Expressions_Low_Total(7),Summed_State_Expressions_Low_Total(8));
   State_Expression_Low.Properties.Description   = sprintf('Summed expression at regions with activation <%gx minimum Z Score, by state',ValueOfSigActivation_factor);
   State_Expression_Low.Properties.VariableNames = stateNames_Table;
   State_Expression_Low
else
   disp('Select -Yes- on TableStateSummedExpression to see summed activation within each state');
end

% Saving tables

if strcmpi(SaveTables,'Yes')
    writetable(PositiveParcels_A,fullfile(WhereToSaveTables,strcat('Positive_Parcels_',num2str(ValueOfSigActivation_factor),num2str(FileType))));
    writetable(NegativeParcels_A,fullfile(WhereToSaveTables,strcat('Negative_Parcels_',num2str(ValueOfSigActivation_factor),num2str(FileType))));
    writetable(State_Activation_High,fullfile(WhereToSaveTables,strcat('State_Activation_High_',num2str(ValueOfSigActivation_factor),num2str(FileType))));
    writetable(State_Expression_High,fullfile(WhereToSaveTables,strcat('State_Expression_High',num2str(ValueOfSigActivation_factor),num2str(FileType))));
    writetable(State_Activation_Low,fullfile(WhereToSaveTables,strcat('State_Activation_Low_',num2str(ValueOfSigActivation_factor),num2str(FileType))));
    writetable(State_Expression_Low,fullfile(WhereToSaveTables,strcat('State_Expression_Low',num2str(ValueOfSigActivation_factor),num2str(FileType))));
else
    disp('Select - Yes - on SaveTables to save tables in desired location (WhereToSaveTables) of desired format (FileType)');
end

% Plotting state-wise high

sz = 100;
fontsz  = 25;
labelsz = 18; 
dx = 0.1; dy = 0.05; % distance from points the labels will be
highXAxis = [0 30];
highYAxis = [-5 5];
lowXAxis  = [-30 0];
lowYAxis  = [-5 5];

[state_Rh state_Ph] = corr(Summed_State_Activations_High', Summed_State_Expressions_High');

if strcmpi(ScatterStateWiseHigh,'Yes')
figure;
state_high = scatter(Summed_State_Activations_High, Summed_State_Expressions_High,sz,'r','filled');
title(sprintf('State high activation (%gx max) to ZDHHC9 expression correlations: p = %g, r = %g',ValueOfSigActivation_factor,state_Ph,state_Rh));
xlabel('Summed Z score activation');
ylabel('Summed Z score ZDHHC9 expression');
xlim(highXAxis);
ylim(highYAxis);
set(gca,'FontSize',fontsz,'TickLength',[0 0]);
lsline;
hold on
l  = text(Summed_State_Activations_High+dx, Summed_State_Expressions_High+dy, stateNames(Non_Empty_High_Indexes));
set(l,'FontSize',labelsz);
set(gcf,'Position',Squaresize);
if strcmpi(SaveScatters,'Yes')
   saveas(gca,strcat(WhereToSaveScatter,'Positive_State_',num2str(ValueOfSigActivation_factor),'.png'));
end
else
   disp('Select -Yes- on ScatterStateWiseHigh to see GLEAN-Gene correlations for high-thresholded GLEAN states');
end

% Plotting state-wise low

[state_Rl state_Pl] = corr(Summed_State_Activations_Low',Summed_State_Expressions_Low');

if strcmpi(ScatterStateWiseLow,'Yes')
figure;
state_low = scatter(Summed_State_Activations_Low, Summed_State_Expressions_Low,sz,'b','filled');
title(sprintf('State low activation (%gx min) to ZDHHC9 expression correlations: p = %g, r = %g',ValueOfSigActivation_factor,state_Pl,state_Rl));
xlabel('Summed Z score activation');
ylabel('Summed Z score ZDHHC9 expression');
xlim(lowXAxis);
ylim(lowYAxis);
set(gca,'FontSize',fontsz,'TickLength',[0 0]);
lsline;
hold on
l  = text(Summed_State_Activations_Low+dx, Summed_State_Expressions_Low+dy, stateNames(Non_Empty_Low_Indexes));
set(l,'FontSize',labelsz);
set(gcf,'Position',Squaresize); % Make square before saving
if strcmpi(SaveScatters,'Yes')
   saveas(gca,strcat(WhereToSaveScatter,'Negative_State_',num2str(ValueOfSigActivation_factor),'.png'));
end
else
    disp('Select -Yes- on ScatterStateWiseLow to see GLEAN-Gene correlations for low-thresholded GLEAN states');
end

% Store activation and expression

stateActivationHighNames{Iteration}                         = stateNames(Non_Empty_High_Indexes);
stateActivationHigh{Iteration}(Non_Empty_High_Indexes)      = Summed_State_Activations_High;
stateExpressionHigh{Iteration}(Non_Empty_High_Indexes)      = Summed_State_Expressions_High;

stateActivationLowNames{Iteration}                          = stateNames(Non_Empty_Low_Indexes);
stateActivationLow{Iteration}(Non_Empty_Low_Indexes)        = Summed_State_Activations_Low;
stateExpressionLow{Iteration}(Non_Empty_Low_Indexes)        = Summed_State_Expressions_Low;

Iteration = Iteration + 1;

if length(DeterminedThreshold)>1 && strcmpi(seeRelationships,'Yes')

% Invert the levels, so first state, then threshold

stateActivationHigh_state = cell(1,length(stateNames));
    for i = 1:length(stateActivationHigh)
        for j = 1:length(stateNames)
            stateActivationHigh_state{j}(i) = stateActivationHigh{i}(j);
        end
    end
    
stateActivationLow_state = cell(1,length(stateNames));
    for i = 1:length(stateActivationLow)
        for j = 1:length(stateNames)
            stateActivationLow_state{j}(i) = stateActivationLow{i}(j);
        end
    end
    
stateExpressionHigh_state = cell(1,length(stateNames));
    for i = 1:length(stateExpressionHigh)
        for j = 1:length(stateNames)
            stateExpressionHigh_state{j}(i) = stateExpressionHigh{i}(j);
        end
    end
    
stateExpressionLow_state = cell(1,length(stateNames));
    for i = 1:length(stateExpressionLow)
        for j = 1:length(stateNames)
            stateExpressionLow_state{j}(i) = stateExpressionLow{i}(j);
        end
    end
               
% Plot how state and gene expressions change for increasing % of maximum activaition thresholds

% Increasing positive threshold: Activation and Expression

figure;
for i = 1:length(stateNames);
plot(ThresholdsToLoop,stateActivationHigh_state{i},'LineWidth',3)
title(sprintf('Effects of increasing positive thresholds on activation, by state - %d iterations',length(ThresholdsToLoop)));
xlabel('Increasing positive activation threshold (% of maximum activation)');
ylabel('State Activation (summed DK parcel Z scores)');
hold on
leg = legend(stateNames);
set(gca,'FontSize',20,'TickLength',[0 0]);
end

figure;
for i = 1:length(stateNames);
plot(ThresholdsToLoop,stateExpressionHigh_state{i},'LineWidth',3)
title(sprintf('Effects of increasing positive thresholds on expression, by state - %d iterations',length(ThresholdsToLoop)));
xlabel('Increasing positive activation threshold (% of maximum activation)');
ylabel('State Expression (summed DK parcel Z scores)');
hold on
leg = legend(stateNames);
set(gca,'FontSize',20,'TickLength',[0 0]);
end


% Increasing negative threshold: Activation and Expression

figure;
for i = 1:length(stateNames);
plot(ThresholdsToLoop,stateActivationLow_state{i},'LineWidth',3)
title(sprintf('Effects of increasing negative thresholds on activation, by state - %d iterations',length(ThresholdsToLoop)));
xlabel('Increasing negative activation threshold (% of minimum activation)');
ylabel('State Activation (summed DK parcel Z scores)');
hold on
leg = legend(stateNames);
set(leg,'Location','southeast');
set(gca,'FontSize',20,'TickLength',[0 0]);
end

figure;
for i = 1:length(stateNames);
plot(ThresholdsToLoop,stateExpressionLow_state{i},'LineWidth',3)
title(sprintf('Effects of increasing negative thresholds on expression, by state - %d iterations',length(ThresholdsToLoop)));
xlabel('Increasing negative activation threshold (% of minimum activation)');
ylabel('State Expression (summed DK parcel Z scores)');
hold on
leg = legend(stateNames);
set(gca,'FontSize',20,'TickLength',[0 0]);
end

% Doing a 3D positive and 3D contour plot of activation, expression and
% threshold

figure;
for i = 1:length(stateNames);
plot3(ThresholdsToLoop,stateActivationHigh_state{i},stateExpressionHigh_state{i},'LineWidth',3);
title(sprintf('Effects of increasing positive thresholds on activation and expression, by state - %d iterations',length(ThresholdsToLoop)));
xlabel('Increasing positive activation threshold (% of maximum activation)');
ylabel('State Activation (summed DK parcel Z scores)');
zlabel('State Expression (summed DK parcel Z scores)');
leg = legend(stateNames);
set(gca,'FontSize',12,'TickLength',[0 0]);
hold on
end

figure;
for i = 1:length(stateNames);
plot3(ThresholdsToLoop,stateActivationLow_state{i},stateExpressionLow_state{i},'LineWidth',3);
title(sprintf('Effects of increasing negative thresholds on activation and expression, by state - %d iterations',length(ThresholdsToLoop)));
xlabel('Increasing negative activation threshold (% of minimum activation)');
ylabel('State Activation (summed DK parcel Z scores)');
zlabel('State Expression (summed DK parcel Z scores)');
leg = legend(stateNames);
set(gca,'FontSize',12,'TickLength',[0 0]);
hold on
end
end

% Null distrubution of networks - see if gene expression is significant in a permuation test

if strcmpi(CorrelatePermuteTest,'Yes')
    
PositiveBucket_Indexes = {};
for i = 1:length(Sig_Activation_Indexes_Pos)
    if ~isempty(Sig_Activation_Indexes_Pos{i})
       PositiveBucket_Indexes{i} = Sig_Activation_Indexes_Pos{i};
    end
end
PositiveBucket_Indexes = cell2mat(PositiveBucket_Indexes);
PositiveBucket_ZDHHC9  = ZDHHC9_Expression(PositiveBucket_Indexes);

NegativeBucket_Indexes = {};
for i = 1:length(Sig_Activation_Indexes_Neg)
    if ~isempty(Sig_Activation_Indexes_Neg{i})
       NegativeBucket_Indexes{i} = Sig_Activation_Indexes_Neg{i};
    end
end
NegativeBucket_Indexes = cell2mat(NegativeBucket_Indexes);
NegativeBucket_ZDHHC9  = ZDHHC9_Expression(NegativeBucket_Indexes);

% Now we have all the raw values for each thresholded parcel
% Now draw at random according to the lengths of contributing parcels to each state
% We will do positive, negative, and all

Sig_Activation_Indexes_All    = {};
for i = 1:length(Sig_Activation_Indexes_Pos);
Sig_Activation_Indexes_All{i} = [Sig_Activation_Indexes_Pos{i} Sig_Activation_Indexes_Neg{i}];
end

NumPositiveParcels = [];
for i = 1:length(Sig_Activation_Indexes_Pos);
    NumPositiveParcels(i) = length(Sig_Activation_Indexes_Pos{i});
end
NumNegativeParcels = [];
for i = 1:length(Sig_Activation_Indexes_Neg);
    NumNegativeParcels(i) = length(Sig_Activation_Indexes_Neg{i});
end
NumAllParcels      = [];
for i = 1:length(Sig_Activation_Indexes_All);
    NumAllParcels(i) = length(Sig_Activation_Indexes_All{i});
end

DifValuesPositive = unique(NumPositiveParcels);
CounterP = []; %Will count how many parcels of each number there are
for i = 1:length(DifValuesPositive);
    CounterP(i) = sum(NumPositiveParcels(:) == DifValuesPositive(i));
end

DifValuesNegative = unique(NumNegativeParcels);
CounterN = [];
for i = 1:length(DifValuesNegative);
    CounterN(i) = sum(NumNegativeParcels(:) == DifValuesNegative(i));
end

DifValuesAll      = unique(NumAllParcels);
CounterA = [];
for i = 1:length(DifValuesAll);
    CounterA(i) = sum(NumAllParcels(:) == DifValuesAll(i));
end

% This defines where to randomly draw the null distribution from.
% 1) All parcels = 1:length(ZDHHC9_Expression)
% 2) Positive active parcels = PositiveBucket_Indexes
% 3) Negative active parcels = NegativeBucket_Indexes

WhereToDrawFrom_P = 1:length(ZDHHC9_Expression);
WhereToDrawFrom_N = 1:length(ZDHHC9_Expression);
WhereToDrawFrom_A = 1:length(ZDHHC9_Expression);

if strcmpi(NullDistType,'AllState') % All state will form 1 distribution based on all combinations of state lengths of parcels
                                    % In state will form individual distributions based on length of parcels for that state
disp('Forming null distribution: based on lengths of combinations of parcel contributions to all states observed');

% form one null distribution for all states    
    
DistributionDataP = cell(1,TestIteration);
DistributionDataN = cell(1,TestIteration);
DistributionDataA = cell(1,TestIteration);   

for k = 1:TestIteration;
    
DataP_Indexes = cell(1,length(CounterP));
DataP         = cell(1,length(CounterP));
for i = 1:length(CounterP)
    for j = 1:CounterP(i)
    DataP_Indexes{i}{j} = randsample(WhereToDrawFrom_P,DifValuesPositive(i));
    end
    DataP_Indexes{i}    = cell2mat(DataP_Indexes{i});
    DataP{i}            = ZDHHC9_Expression(DataP_Indexes{i})';
end

DataP = cell2mat(DataP);
DataP = mean(DataP);       % This ensures parcel expressions are meaned before adding to the distribution

DataN_Indexes = cell(1,length(CounterN));
DataN         = cell(1,length(CounterN));
for i = 1:length(CounterN)
    for j = 1:CounterN(i)
    DataN_Indexes{i}{j} = randsample(WhereToDrawFrom_N,DifValuesNegative(i));
    end
    DataN_Indexes{i}    = cell2mat(DataN_Indexes{i});
    DataN{i}            = ZDHHC9_Expression(DataN_Indexes{i})';
end

DataN = cell2mat(DataN);
DataN = mean(DataN);

DataA_Indexes = cell(1,length(CounterA));
DataA         = cell(1,length(CounterA));
for i = 1:length(CounterA)
    for j = 1:CounterA(i)
    DataA_Indexes{i}{j} = randsample(WhereToDrawFrom_A,DifValuesAll(i));
    end
    DataA_Indexes{i}    = cell2mat(DataA_Indexes{i});
    DataA{i}            = ZDHHC9_Expression(DataA_Indexes{i})';
end

DataA = cell2mat(DataA);
DataA = mean(DataA);

DistributionDataP{k}  = DataP;
DistributionDataN{k}  = DataN;
DistributionDataA{k}  = DataA;
end

DistributionDataP = cell2mat(DistributionDataP);
DistributionDataN = cell2mat(DistributionDataN);
DistributionDataA = cell2mat(DistributionDataA);

meanDistributionP      = mean(DistributionDataP);
meanDistributionN      = mean(DistributionDataN);
meanDistributionA      = mean(DistributionDataA);

    disp('Null distribution formed');

end
    
if strcmpi(NullDistType, 'InState')
disp('Forming null distribution: based on lengths of combinations of parcel contributions to each state observed');

% Form a null distrtibution for each state

DistributionDataP = {zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration)};
DistributionDataN = {zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration)};
DistributionDataA = {zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration),zeros(1,TestIteration)};

for k = 1:TestIteration;
    
DataP = cell(1,length(stateNames));
    for i = 1:length(DataP) % each state
    randIndexes      = randsample(WhereToDrawFrom_P,length(Sig_Activation_Indexes_Pos{i}))'; % WeightedExpressionByState{i} takes it specifically from the weighted, rather than just ZDHHC9_Expression
    % We then weight the sample by activation 
    x                = ZDHHC9_Expression(randIndexes)';      %Random raw expression
    y                = double(squeeze(All_Data_AbsSum{i})); %This is the activation in that state
    DataP_Activation = y(randIndexes);
    Weighting        = DataP_Activation/max(DataP_Activation);
    z                = x.*Weighting;
    DataP{i}         = sum(z);
    if isnan(DataP{i})
       DataP{i}      = 0;
    end
    end
    DataP            = cell2mat(DataP);

DataN = cell(1,length(stateNames));
    for i = 1:length(DataN)
    randIndexes      = randsample(WhereToDrawFrom_N,length(Sig_Activation_Indexes_Neg{i}))';
    x                = ZDHHC9_Expression(randIndexes)';
    y                = double(squeeze(All_Data_AbsSum{i}));
    DataN_Activation = y(randIndexes);
    Weighting        = DataN_Activation/max(DataN_Activation);
    z                = x.*Weighting;
    DataN{i}         = sum(z);
    if isnan(DataN{i})
       DataN{i}      = 0;
    end
    end
    DataN            = cell2mat(DataN);
    
DataA = cell(1,length(stateNames));
    for i = 1:length(DataA)
    randIndexes      = randsample(WhereToDrawFrom_A,length(Sig_Activation_Indexes_All{i}))';
    x                = ZDHHC9_Expression(randIndexes)';
    y                = double(squeeze(All_Data_AbsSum{i}));
    DataA_Activation = y(randIndexes);
    Weighting        = DataA_Activation/max(DataA_Activation);
    z                = x.*Weighting;
    DataA{i}         = sum(z);
    if isnan(DataA{i})
       DataA{i}      = 0;
    end
    end
    DataA            = cell2mat(DataA);

    for i = 1:length(DataP);
    DistributionDataP{i}(k)  = DataP(i);
    DistributionDataN{i}(k)  = DataN(i);
    DistributionDataA{i}(k)  = DataA(i);
    end

    
end
    disp('Null distribution formed');
    for i = 1:length(DistributionDataP);
    meanDistributionP(i)     = mean(DistributionDataP{i});
    meanDistributionN(i)     = mean(DistributionDataN{i});
    meanDistributionA(i)     = mean(DistributionDataA{i});
    end   
end

% We have weighted the null distribution, to only provide expression values
% increasingly by activation.
% Compare to the raw expression

StateMeanExpressionPos    = cell(1,length(Sig_Activation_Indexes_Pos));
StateSumExpressionPos     = cell(1,length(Sig_Activation_Indexes_Pos));
for i = 1:length(Sig_Activation_Indexes_Pos);
Sig_Parcel_Pos{i}         = ZDHHC9_Expression(Sig_Activation_Indexes_Pos{i});
Activation                = All_Data_AbsSum{i}(Sig_Activation_Indexes_Pos{i});
Weighting                 = Activation/max(Activation);
Sig_Parcel_Pos{i}         = Sig_Parcel_Pos{i}' .* Weighting;
StateMeanExpressionPos{i} = mean(Sig_Parcel_Pos{i});
StateSumExpressionPos{i}  = sum(Sig_Parcel_Pos{i});
end
StateMeanExpressionPos    = cell2mat(StateMeanExpressionPos);
StateSumExpressionPos     = cell2mat(StateSumExpressionPos);

StateMeanExpressionNeg    = cell(1,length(Sig_Activation_Indexes_Neg));
StateSumExpressionNeg     = cell(1,length(Sig_Activation_Indexes_Neg));
for i = 1:length(Sig_Activation_Indexes_Neg);
Sig_Parcel_Neg{i}         = ZDHHC9_Expression(Sig_Activation_Indexes_Neg{i});
Activation                = All_Data_AbsSum{i}(Sig_Activation_Indexes_Neg{i});
Weighting                 = Activation/max(Activation);
Sig_Parcel_Neg{i}         = Sig_Parcel_Neg{i}' .* Weighting;
StateMeanExpressionNeg{i} = mean(Sig_Parcel_Neg{i});
StateSumExpressionNeg{i}  = sum(Sig_Parcel_Neg{i});
end
StateMeanExpressionNeg    = cell2mat(StateMeanExpressionNeg);
StateSumExpressionNeg     = cell2mat(StateSumExpressionNeg);

StateMeanExpressionAll    = cell(1,length(Sig_Activation_Indexes_All));
StateSumExpressionAll     = cell(1,length(Sig_Activation_Indexes_All));
for i = 1:length(Sig_Activation_Indexes_All);
Sig_Parcel_All{i}         = ZDHHC9_Expression(Sig_Activation_Indexes_All{i});
Activation                = All_Data_AbsSum{i}(Sig_Activation_Indexes_All{i});
Weighting                 = Activation/max(Activation);
Sig_Parcel_All{i}         = Sig_Parcel_All{i}' .* Weighting;
StateMeanExpressionAll{i} = mean(Sig_Parcel_All{i});
StateSumExpressionAll{i}  = sum(Sig_Parcel_All{i});
end
StateMeanExpressionAll    = cell2mat(StateMeanExpressionAll);
StateSumExpressionAll     = cell2mat(StateSumExpressionAll);

disp('Mean and sum expression in each state calculated');

% Here we need to ensure, if +ve you take area above and if -ve you take area below

% Note--It is sum expression we are dealing with!
if strcmpi(NullDistType,'AllState');
  
p_pos = {};
for i = 1:length(StateSumExpressionPos)
    if StateSumExpressionPos(i) < meanDistributionP
p_pos{i} = find(sort(DistributionDataP)<StateSumExpressionPos(i));
    else
p_pos{i} = find(sort(DistributionDataP)>StateSumExpressionPos(i));
    end
if ~isempty(p_pos)
    p_pos{i} = length(p_pos{i})/length(DistributionDataP);
end
end
p_pos = cell2mat(p_pos);
p_pos(find(p_pos==0))=0.00005;
p_pos(isnan(StateSumExpressionPos)) = 0.5;

p_neg = {};
for i = 1:length(StateSumExpressionNeg)
    if StateSumExpressionNeg(i) < meanDistributionN
p_neg{i} = find(sort(DistributionDataN)<StateSumExpressionNeg(i));
    else
p_neg{i} = find(sort(DistributionDataN)>StateSumExpressionNeg(i));
    end
if ~isempty(p_neg)
    p_neg{i} = length(p_neg{i})/length(DistributionDataN);
end
end
p_neg = cell2mat(p_neg);
p_neg(find(p_neg==0))=0.00005;
p_neg(isnan(StateSumExpressionNeg)) = 0.5;

p_all = {};
for i = 1:length(StateSumExpressionAll)
    if StateSumExpressionAll(i) < meanDistributionA
p_all{i} = find(sort(DistributionDataA)<StateSumExpressionAll(i));
    else
p_all{i} = find(sort(DistributionDataA)>StateSumExpressionAll(i));
    end
if ~isempty(p_all)
    p_all{i} = length(p_all{i})/length(DistributionDataA);
end
end
p_all = cell2mat(p_all);
p_all(find(p_all==0))=0.00005;
p_all(isnan(StateSumExpressionAll)) = 0.5;

disp('Pcorrected values calculated');

end

if strcmpi(NullDistType,'InState');

p_pos = {};
for i = 1:length(StateSumExpressionPos)
    if StateSumExpressionPos(i) < meanDistributionP(i)
p_pos{i} = find(sort(DistributionDataP{i})<StateSumExpressionPos(i));
    else
p_pos{i} = find(sort(DistributionDataP{i})>StateSumExpressionPos(i));
    end
if ~isempty(p_pos)
    p_pos{i} = length(p_pos{i})/length(DistributionDataP{i});
end
end

p_pos = cell2mat(p_pos);
p_pos(find(p_pos==0))=0.00005;
p_pos(isnan(StateSumExpressionPos)) = 0.5;

p_neg = {};
for i = 1:length(StateSumExpressionNeg)
    if StateSumExpressionNeg(i) < meanDistributionN(i)
p_neg{i} = find(sort(DistributionDataN{i})<StateSumExpressionNeg(i));
    else
p_neg{i} = find(sort(DistributionDataN{i})>StateSumExpressionNeg(i));
    end
if ~isempty(p_neg)
    p_neg{i} = length(p_neg{i})/length(DistributionDataN{i});
end
end
p_neg = cell2mat(p_neg);
p_neg(find(p_neg==0))=0.00005;
p_neg(isnan(StateSumExpressionNeg)) = 0.5;

p_all = {};
for i = 1:length(StateSumExpressionAll)
    if StateSumExpressionAll(i) < meanDistributionA(i)
p_all{i} = find(sort(DistributionDataA{i})<StateSumExpressionAll(i));
    else
p_all{i} = find(sort(DistributionDataA{i})>StateSumExpressionAll(i));
    end
if ~isempty(p_all)
    p_all{i} = length(p_all{i})/length(DistributionDataA{i});
end
end
p_all = cell2mat(p_all);
p_all(find(p_all==0))=0.00005;
p_all(isnan(StateSumExpressionAll)) = 0.5;

disp('Pcorrected values calculated');

end
    
% Note, as we make no assumption of directionality, it must be two sided test
% Therefore, we must double our p values

TwoSided = 'Yes';

if strcmpi(TwoSided,'Yes');
   p_pos = 2*p_pos;
   p_pos(find(p_pos>1))=1;
   p_neg = 2*p_neg;
   p_neg(find(p_neg>1))=1;
   p_all = 2*p_all;
   p_neg(find(p_pos>1))=1;
end

for i = 1:length(stateNames) % State Numbers

disp(sprintf('State %g (%s): %gx threshold of positive activation: Pcorrected = %g',i,stateNames{i},DeterminedThreshold,p_pos(i)));
disp(sprintf('State %g (%s): %gx threshold of negative activation: Pcorrected = %g',i,stateNames{i},DeterminedThreshold,p_neg(i)));
disp(sprintf('State %g (%s): %gx threshold of absolute activation: Pcorrected = %g',i,stateNames{i},DeterminedThreshold,p_all(i)));

end

% Plotting null distribution

bins = 100;

% Only including states that are active 

ActivePStates          = ~isnan(StateSumExpressionPos);
StateSumExpressionPos = StateSumExpressionPos(ActivePStates);
statesP                = states(ActivePStates);
stateNamesP            = stateNames(ActivePStates);
p_pos_P                = p_pos(ActivePStates);

ActiveNStates          = ~isnan(StateSumExpressionNeg);
StateSumExpressionNeg = StateSumExpressionNeg(ActiveNStates);
statesN                = states(ActiveNStates);
stateNamesN            = stateNames(ActiveNStates);
p_neg_N                = p_neg(ActiveNStates);

lrgfontsz              = 14;
fontsz                 = 12;

windowfactorofminmax   = 0.008;
ZDHHC9limitP           = [min(StateSumExpressionPos)-windowfactorofminmax*min(StateSumExpressionPos) max(StateSumExpressionPos)+windowfactorofminmax*max(StateSumExpressionPos)];
ZDHHC9limitN           = [min(StateSumExpressionNeg)-windowfactorofminmax*min(StateSumExpressionNeg) max(StateSumExpressionNeg)+windowfactorofminmax*max(StateSumExpressionNeg)];
ZDHHC9limitA           = [min(StateSumExpressionAll)-windowfactorofminmax*min(StateSumExpressionAll) max(StateSumExpressionAll)+windowfactorofminmax*max(StateSumExpressionAll)];


colours     = {'r','c','y','k','m','b','g','r'};

% Plot: first all states, then instates

if strcmpi(NullDistType,'AllState');
    
if strcmpi(PlotPositiveNegative,'Yes');

disp('Plotting positive and negative maps: null distribution drawn from all state maps');

figure;
for i = 1:length(stateNamesP);
subplot(ceil(length(stateNamesP)/2),2,i);
histogram(DistributionDataP,bins,'FaceColor',[1 0 0]);
ylim = get(gca,'YLim');
hold on
plot(StateSumExpressionPos(i)*[1,1],ylim,'r-','LineWidth',4);
title(sprintf('State %g (%s) Pcorrected = %0.5g',statesP(i),stateNamesP{i},p_pos_P(i)));
xlim(ZDHHC9limitP);
ylabel('Frequency');
xlabel('ZDHHC9 expression');
set(gca,'TickLength',[0 0],'FontSize',lrgfontsz);
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
t  = text(0.5,0.99,sprintf('Expression %gx thresholded positive maps: %g summed samples',DeterminedThreshold,TestIteration),...
    'HorizontalAlignment','center','VerticalAlignment', 'top','FontSize',lrgfontsz+4,'FontWeight','bold');
set(gcf,'Position',get(0,'Screensize'));
end
if strcmpi(SavePermuations,'Yes');
saveas(gca,strcat(WhereToSavePermuations,'Permuation_Positive_',num2str(DeterminedThreshold*100),'%','.png'));
end

figure;
for i = 1:length(stateNamesN);
subplot(ceil(length(stateNamesN)/2),2,i);
histogram(DistributionDataN,bins,'FaceColor',[0 0 1]);
ylim = get(gca,'YLim');
hold on
plot(StateSumExpressionNeg(i)*[1,1],ylim,'r-','LineWidth',4);
title(sprintf('State %g (%s) Pcorrected = %0.5g',statesN(i),stateNamesN{i},p_neg_N(i)));
xlim(ZDHHC9limitN);
ylabel('Frequency');
xlabel('ZDHHC9 expression');
set(gca,'TickLength',[0 0],'FontSize',lrgfontsz);
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
t  = text(0.5,0.99,sprintf('Expression %gx thresholded negative maps: %g summed samples',DeterminedThreshold,TestIteration),...
    'HorizontalAlignment','center','VerticalAlignment', 'top','FontSize',lrgfontsz+4,'FontWeight','bold');
set(gcf,'Position',get(0,'Screensize'));
end
if strcmpi(SavePermuations,'Yes');
saveas(gca,strcat(WhereToSavePermuations,'Permuation_Negative_',num2str(DeterminedThreshold*100),'%','.png'));
end
end % Close PositiveNegative

if strcmpi(PlotAbsolute,'Yes');
    
disp('Plotting absolute maps: null distribution drawn from all state maps')

figure;
for i = 1:length(stateNames);
subplot(ceil(length(stateNames)/2),2,i);
h = histogram(DistributionDataA,bins,'FaceColor',[1 1 1]);
ylim = get(gca,'YLim');
pos  = get(gca,'Position'); pos(1) = pos(1) + 0.001*pos(1); pos(2) = pos(2) - 0.001*pos(2);
hold on
plot(StateSumExpressionAll(i)*[1,1],ylim,colours{i},'LineWidth',3);
plot(meanDistributionA*[1,1],ylim,'k-','LineWidth',3);
title(sprintf('State %g - %s',states(i),stateNames{i}));
str = {sprintf('Summed expression = %g',StateSumExpressionAll(i)),sprintf('Pcorrected = %0.4g',p_all(i))};
ann = annotation('textbox',pos,'String',str,'FitBoxToText','on','Color','black');
ann.BackgroundColor = 'white';
ann.FontSize        = fontsz;
xlim(ZDHHC9limitA);
%ylabel('Frequency');
%xlabel('ZDHHC9 expression');
set(gca,'TickLength',[0 0],'FontSize',fontsz, 'YTickLabel','');
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
titstr = {sprintf('Expression %g%s thresholded absolute maps',DeterminedThreshold*100,char(37)),...
          sprintf('Null distribution mean summed ZDHHC9 expression = %g',meanDistributionA)};
sup = text(0.5,0.99,titstr,'HorizontalAlignment','center','VerticalAlignment', 'top','FontSize',lrgfontsz+4,'FontWeight','bold');
set(gcf,'Position',get(0,'Screensize'));
end
if strcmpi(SavePermuations,'Yes');
saveas(gca,strcat(WhereToSavePermuations,'Permuation_Absolute_',num2str(DeterminedThreshold*100),'%','.png'));
end
end % Close Plot Absolute
end % Close all AllStates

if strcmpi(NullDistType,'InState');

if strcmpi(PlotPositiveNegative,'Yes');
 
disp('Plotting positive and negative maps: null distribution drawn from individual state maps, weighted by activation in each permutation');

figure;
for i = 1:length(stateNamesP);
subplot(ceil(length(stateNamesP)/2),2,i);
h = histogram(DistributionDataP{i},bins,'FaceColor',[1 0 0]);
ylim = get(gca,'YLim');
pos  = get(gca,'Position'); pos(1) = pos(1) + 0.001*pos(1); pos(2) = pos(2) - 0.001*pos(2);
hold on
plot(StateSumExpressionPos(i)*[1,1],ylim,colours{i},'LineWidth',3);
plot(meanDistributionP(i)*[1,1],ylim,'k-','LineWidth',3);
title(sprintf('State %g - %s',statesP(i),stateNamesP{i}));
str = {sprintf('Weighted summed null expression = %g',meanDistributionP(i)),sprintf('Weighted summed state expression = %g',StateSumExpressionPos(i)),sprintf('Pcorrected = %0.4g',p_pos_P(i))};
ann = annotation('textbox',pos,'String',str,'FitBoxToText','on','Color','black');
ann.BackgroundColor = 'white';
ann.FontSize        = fontsz;
%ylabel('Frequency');
%xlabel('ZDHHC9 expression');
set(gca,'TickLength',[0 0],'FontSize',fontsz, 'YTickLabel','');
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
titstr = {sprintf('Expression %g%s thresholded positive maps',DeterminedThreshold*100,char(37))};
sup = text(0.5,0.99,titstr,'HorizontalAlignment','center','VerticalAlignment', 'top','FontSize',lrgfontsz+4,'FontWeight','bold');
set(gcf,'Position',get(0,'Screensize'));
end
    if strcmpi(SavePermuations,'Yes');
    saveas(gca,strcat(WhereToSavePermuations,'Permuation_Positive_',num2str(DeterminedThreshold*100),'%','.png'));
    end
    
figure;
for i = 1:length(stateNamesN);
subplot(ceil(length(stateNamesN)/2),2,i);
h = histogram(DistributionDataN{i},bins,'FaceColor',[0 0 1]);
ylim = get(gca,'YLim');
pos  = get(gca,'Position'); pos(1) = pos(1) + 0.001*pos(1); pos(2) = pos(2) - 0.001*pos(2);
hold on
plot(StateSumExpressionNeg(i)*[1,1],ylim,colours{i},'LineWidth',3);
plot(meanDistributionN(i)*[1,1],ylim,'k-','LineWidth',3);
title(sprintf('State %g - %s',statesN(i),stateNamesN{i}));
str = {sprintf('Weighted summed null expression = %g',meanDistributionN(i)),sprintf('Weighted summed state expression = %g',StateSumExpressionNeg(i)),sprintf('Pcorrected = %0.4g',p_neg_N(i))};
ann = annotation('textbox',pos,'String',str,'FitBoxToText','on','Color','black');
ann.BackgroundColor = 'white';
ann.FontSize        = fontsz;
%ylabel('Frequency');
%xlabel('ZDHHC9 expression');
set(gca,'TickLength',[0 0],'FontSize',fontsz, 'YTickLabel','');
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
titstr = {sprintf('Expression %g%s thresholded negative maps',DeterminedThreshold*100,char(37))};
sup = text(0.5,0.99,titstr,'HorizontalAlignment','center','VerticalAlignment', 'top','FontSize',lrgfontsz+4,'FontWeight','bold');
set(gcf,'Position',get(0,'Screensize'));
end
    if strcmpi(SavePermuations,'Yes');
    saveas(gca,strcat(WhereToSavePermuations,'Permuation_Negative_',num2str(DeterminedThreshold*100),'%','.png'));
    end    
end % Close PositiveNegative

if strcmpi(PlotAbsolute,'Yes')
 
disp('Plotting absolute maps: null distribution drawn from individual state maps');

figure;
for i = 1:length(stateNames);
subplot(ceil(length(stateNames)/2),2,i);
h = histogram(DistributionDataA{i},bins,'FaceColor',[1 1 1]);
ylim = get(gca,'YLim');
pos  = get(gca,'Position'); pos(1) = pos(1) + 0.001*pos(1); pos(2) = pos(2) - 0.001*pos(2);
hold on
plot(StateSumExpressionAll(i)*[1,1],ylim,colours{i},'LineWidth',3);
plot(meanDistributionA(i)*[1,1],ylim,'k-','LineWidth',3);
title(sprintf('State %g - %s',states(i),stateNames{i}));
str = {sprintf('Weighted summed null expression expression = %g',meanDistributionA(i)),sprintf('Weighted summed state expression = %g',StateSumExpressionAll(i)),sprintf('Pcorrected = %0.4g',p_all(i))};
ann = annotation('textbox',pos,'String',str,'FitBoxToText','on','Color','black');
ann.BackgroundColor = 'white';
ann.FontSize        = fontsz;
%ylabel('Frequency');
%xlabel('ZDHHC9 expression');
set(gca,'TickLength',[0 0],'FontSize',fontsz, 'YTickLabel','');
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
titstr = {sprintf('Expression %g%s thresholded absolute maps',DeterminedThreshold*100,char(37)),'Each null distribution formed individually'};
sup = text(0.5,0.99,titstr,'HorizontalAlignment','center','VerticalAlignment', 'top','FontSize',lrgfontsz+4,'FontWeight','bold');
set(gcf,'Position',get(0,'Screensize'));
end
    if strcmpi(SavePermuations,'Yes');
    saveas(gca,strcat(WhereToSavePermuations,'Permuation_Absolute_',num2str(DeterminedThreshold*100),'%','.png'));
    end
end

end
% Print min - max lengths of positive and negative parcels - central limit
% theorum indicates >30 is optimum (if InState)

Pos_Lengths = [];
for i = 1:length(Sig_Activation_Labels_Pos)
Pos_Lengths(i) = length(Sig_Activation_Labels_Pos{i});
end

Neg_Lengths = [];
for i = 1:length(Sig_Activation_Labels_Neg)
Neg_Lengths(i) = length(Sig_Activation_Labels_Neg{i});
end


if length(Pos_Lengths) == length(Neg_Lengths)
    Abs_Lengths = [];
    for i = 1:length(Pos_Lengths)
        Abs_Lengths(i) = Pos_Lengths(i)+Neg_Lengths(i);
    end
end

% Thus what are all the possible permutations that could be plotted?

if strcmpi(NullDistType,'InState');
n = 68; %The total number of cortical DK parcels drawn from

fprintf('\n-- POSITIVE %g%s--\n',DeterminedThreshold*100,char(37));
for i = 1:length(Pos_Lengths)
r     = Pos_Lengths(i);
perms = factorial(n)/factorial((n-r)); %This provides how many combinations.
if Pos_Lengths(i) < 1
fprintf('%g. %s state: contains %g positive parcels, thus %g possible permutations - Thus will not form a distribution as inactive\n',states(i),stateNames{i},Pos_Lengths(i),perms);
end
if Pos_Lengths(i) == 1 
fprintf('%g. %s state: contains %g positive parcels, thus %g possible permutations - Thus will resemble ZDHHC9 expression profile (non-parametric)\n',states(i),stateNames{i},Pos_Lengths(i),perms);
end
if Pos_Lengths(i) > 1
fprintf('%g. %s state: contains %g positive parcels, thus %g possible permutations\n',states(i),stateNames{i},Pos_Lengths(i),perms);
end
end

fprintf('\n-- NEGATIVE %g%s--\n',DeterminedThreshold*100,char(37));
for i = 1:length(Neg_Lengths)
r     = Neg_Lengths(i);
perms = factorial(n)/factorial((n-r)); %This provides how many combinations.
if Neg_Lengths(i) < 1
fprintf('%g. %s state: contains %g negative parcels, thus %g possible permutations - Thus will not form a distribution as inactive\n',states(i),stateNames{i},Neg_Lengths(i),perms);
end
if Neg_Lengths(i) == 1 
fprintf('%g. %s state: contains %g negative parcels, thus %g possible permutations - Thus will resemble ZDHHC9 expression profile (non-parametric)\n',states(i),stateNames{i},Neg_Lengths(i),perms);
end
if Neg_Lengths(i) > 1
fprintf('%g. %s state: contains %g negative parcels, thus %g possible permutations\n',states(i),stateNames{i},Neg_Lengths(i),perms);
end
end

fprintf('\n-- ABSOLUTE %g%s--\n',DeterminedThreshold*100,char(37));
for i = 1:length(Abs_Lengths)
r     = Abs_Lengths(i);
perms = factorial(n)/factorial((n-r)); %This provides how many combinations.
if Abs_Lengths(i) < 1
fprintf('%g. %s state: contains %g total absolute parcels, thus %g possible permutations - Thus will not form a distribution as inactive\n',states(i),stateNames{i},Abs_Lengths(i),perms);
end
if Abs_Lengths(i) == 1 
fprintf('%g. %s state: contains %g total absolute parcels, thus %g possible permutations - Thus will resemble ZDHHC9 expression profile (non-parametric)\n',states(i),stateNames{i},Abs_Lengths(i),perms);
end
if Abs_Lengths(i) > 1
fprintf('%g. %s state: contains %g total absolute parcels, thus %g possible permutations\n',states(i),stateNames{i},Abs_Lengths(i),perms);
end
end
end

if strcmpi(NullDistType,'AllState');
   fprintf('-- POSITIVE %g%s -- distribution formed from min %g to max %g parcels\n',DeterminedThreshold*100,char(37),min(Pos_Lengths),max(Pos_Lengths)); 
   fprintf('-- NEGATIVE %g%s -- distribution formed from min %g to max %g parcels\n',DeterminedThreshold*100,char(37),min(Neg_Lengths),max(Neg_Lengths)); 
   fprintf('-- ABSOLUTE %g%s -- distribution formed from min %g to max %g parcels\n',DeterminedThreshold*100,char(37),min(Abs_Lengths),max(Abs_Lengths)); 
end

fprintf('Permutation testing at %g%s threshold completed\n',DeterminedThreshold*100,char(37));

end

% Note, We can index activation in any state and any parcel we want
% Lh superior frontal == 27
All_Data_Raw;
All_Data_Sum;
All_Data_AbsSum;

end
%% 6. Correlate Spatial State Map Activations

CorrelationType   = 'Absolute'; % Normal or Absolute
ProduceIndividual = 'No';

% Reshape into vectors
State_1_v = reshape(State_1,[14283 1]);
State_2_v = reshape(State_2,[14283 1]);
State_3_v = reshape(State_3,[14283 1]);
State_4_v = reshape(State_4,[14283 1]);
State_5_v = reshape(State_5,[14283 1]);
State_6_v = reshape(State_6,[14283 1]);
State_7_v = reshape(State_7,[14283 1]);
State_8_v = reshape(State_8,[14283 1]);
All_States_v = {[State_1_v] [State_2_v] [State_3_v] [State_4_v]...
                [State_5_v] [State_6_v] [State_7_v] [State_8_v]};
            
% All zeros co-occur together, so lets remove

for i = 1:length(All_States_v);
    All_States_v{i} = All_States_v{i}(All_States_v{i} ~= 0);
end
            
% Correlate all states with each other

correlationR = zeros(length(All_States_v),length(All_States_v));
correlationP = zeros(length(All_States_v),length(All_States_v));

for i = 1:length(All_States_v);
    for j = 1:length(All_States_v);
    [correlationR(i,j) correlationP(i,j)] = corr(All_States_v{i},All_States_v{j});
    end
end

if strcmpi(ProduceIndividual,'Yes');

for k = 1:length(All_States_v);
figure;
for i = 1:length(All_States_v);
subplot(4,2,i);
scatter(All_States_v{k},All_States_v{i},sz,'k','filled');
xlabel(sprintf('State %d activation Z score',k));
ylabel(sprintf('State %d activation Z score',i));
title(sprintf('State %d with State %d: r=%0.5g, p=%0.05g',k,i,correlationR(k,i),correlationP(k,i)));
hold on
lsline
end
end

else
    disp('Individual regressions not computed');
end

CustomColors = jet(256);
CustomColors(end,:) = 1;
stateNamesTMatrix   = {'Visual - 1' 'Frontoparietal - 2' 'Somatosensory - 3' 'Parietal - 4',...
                       'Frontotemporal I - 5' 'Temporal - 6' 'Frontotemporal II - 7' 'Frontal - 8'};
% We may want to only plot the abs correlationR

ylabelNor = 'Correlation';
ylabelAbs = 'Absolute correlation';

if strcmpi(CorrelationType,'Normal');
    disp('Running statewise map correlations...')
figure;
imagesc(correlationR);
colormap(CustomColors);
c = colorbar;
title('Spatial map correlations');
ylabel(c,ylabelNor);
xlabel('State');
ylabel('State');
set(gca,'YTickLabel',stateNamesTMatrix,...
        'FontSize',25,...
        'TickLength',[0 0]);
set(gcf, 'Position', Squaresize);
end

if strcmpi(CorrelationType,'Absolute');
    disp('Running absolute statewise map correlations...')
figure;
imagesc(abs(correlationR));
colormap(CustomColors);
c = colorbar;
title('Spatial map correlations');
ylabel(c,ylabelAbs);
xlabel('State');
ylabel('State');
set(gca,'YTickLabel',stateNamesTMatrix,...
        'FontSize',25,...
        'TickLength',[0 0]);
set(gcf, 'Position', Squaresize);
end
    disp('Completed');

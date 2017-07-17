%% Sensor level analysis: AEF and ERF Computations
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience

% This script, following the Weighter by trial type script,puts all of the seperated files by defined condition 
% into an array so that you can run statistical analysis. The array formed is one suitable for FieldTrip functions for statistical analysis.
% Subsequently, AEFs and MMNs are calculated here.

spm('defaults','eeg');                                                       %Ensure up to date SPM and take out the FieldTrip folder within SPM
ft_defaults;                                                                 %Ensure an up to date FieldTrip is in the path
cd('/imaging/da04/');
clear classes;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% SECTION 0: PRE-LOADING OF FILES

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define by condition (can load using dir function)

% Control Deviants
cfilenamesw={'wmfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'wmfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'wmfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'wmfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Deviants
pfilenamesw={'wmfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'wmfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'wmfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'wmfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'wmfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'wmfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'wmfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Preceeding Stimulus
cfilenamesS={'SmfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'SmfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'SmfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'SmfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Preceeding Stimulus
pfilenamesS={'SmfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'SmfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'SmfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'SmfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'SmfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'SmfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'SmfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 1
cfilenamesw1={'w1mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',... 
             'w1mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',... 
             'w1mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w1mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w1mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w1mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w1mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',... 
             'w1mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w1mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 1
pfilenamesw1={'w1mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',... 
             'w1mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w1mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w1mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w1mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 2
cfilenamesw2={'w2mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w2mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w2mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 2
pfilenamesw2={'w2mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w2mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w2mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 3
cfilenamesw3={'w3mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w3mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w3mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 3
pfilenamesw3={'w3mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w3mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w3mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 4
cfilenamesw4={'w4mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w4mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w4mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 4
pfilenamesw4={'w4mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w4mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w4mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 5
cfilenamesw5={'w5mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w5mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w5mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 5
pfilenamesw5={'w5mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w5mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w5mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 6
cfilenamesw6={'w6mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w6mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w6mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 6
pfilenamesw6={'w6mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w6mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w6mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 7
cfilenamesw7={'w7mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w7mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w7mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 7
pfilenamesw7={'w7mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w7mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w7mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 8
cfilenamesw8={'w8mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w8mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w8mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 8
pfilenamesw8={'w8mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w8mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w8mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 9
cfilenamesw9={'w9mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w9mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w9mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 9
pfilenamesw9={'w9mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w9mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w9mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Repeat 10
cfilenamesw10={'w10mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',... 
             'w10mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',... 
             'w10mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'w10mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'w10mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'w10mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'w10mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',... 
             'w10mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'w10mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Repeat 10
pfilenamesw10={'w10mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',... 
             'w10mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'w10mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'w10mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'w10mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Dev-Rep1
cfilenamesDevRep1={'DifmfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'DifmfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'DifmfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Dev-Rep1
pfilenamesDevRep1={'DifmfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'DifmfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'DifmfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Dev-Rep6
cfilenamesDevRep6={'Dif6mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'Dif6mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'Dif6mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Dev-Rep6
pfilenamesDevRep6={'Dif6mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'Dif6mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dif6mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control All Repeats (1-6)
cfilenamesAllReps=cat(2,cfilenamesw1,cfilenamesw2,cfilenamesw3,cfilenamesw4,...
                   cfilenamesw5,cfilenamesw6);
% Patient All Repeats (1-6)
pfilenamesAllReps=cat(2,pfilenamesw1,pfilenamesw2,pfilenamesw3,pfilenamesw4,...
                   pfilenamesw5,pfilenamesw6);
% All Control Deviants 250Hz
cfilenamesDev250={'Dev250mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'Dev250mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'Dev250mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% All Patient Deviants 250Hz
pfilenamesDev250={'Dev250mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'Dev250mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev250mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% All Control Deviants 500Hz
cfilenamesDev500={'Dev500mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'Dev500mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'Dev500mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% All Patient Deviants 500Hz
pfilenamesDev500={'Dev500mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'Dev500mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev500mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% All Control Deviants 1000Hz
cfilenamesDev1000={'Dev1000mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'Dev1000mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'Dev1000mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% All Patient Deviant 250Hz
pfilenamesDev1000={'Dev1000mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'Dev1000mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'Dev1000mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% All Control 250Hz
cfilenames250={'250HzmfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             '250HzmfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             '250HzmfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% All Patient 250Hz
pfilenames250={'250HzmfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             '250HzmfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             '250HzmfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% All Control 500Hz
cfilenames500={'500HzmfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             '500HzmfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             '500HzmfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% All Patient 500Hz
pfilenames500={'500HzmfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             '500HzmfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             '500HzmfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% All Control 1000Hz
cfilenames1000={'1000HzmfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             '1000HzmfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             '1000HzmfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% All Patient 1000Hz
pfilenames1000={'1000HzmfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             '1000HzmfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             '1000HzmfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Control Short Deviants
cShortDev     ={'D_Short_mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'D_Short_mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'D_Short_mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Control Long Deviants
cLongDev      ={'D_Long_mfeAdspm12meg13_0488_131111_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0488_131111_Oddball1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0539_131216_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0539_131216_Oddball1_raw_mc_oddball.mat',... 
             'D_Long_mfeAdspm12meg13_0544_131217_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0544_131217_Oddball1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0540_131216_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0540_131216_Oddball1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg14_0440_140509_task1_raw_mc_oddball.mat',...    
             'D_Long_mfeAdspm12meg14_0440_140509_part2_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg14_0155_140404_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg14_0155_140404_Oddball1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0545_131217_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0545_131217_Oddball1_raw_mc_oddball.mat'};
% Patient Short Deviants
pShortDev     ={'D_Short_mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'D_Short_mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'D_Short_mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};
% Patient Long Deviants
pLongDev      ={'D_Long_mfeAdspm12meg13_0494_131114_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0494_131114_Oddball1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0442_131010_TaskBlock2_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0442_131010_TaskBlock1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0441_131010_TaskBlock3_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0441_131010_TaskBlock2_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0441_131010_TaskBlock1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0495_131114_Oddball2_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0495_131114_Oddball1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0502_131121_Oddball3_raw_mc_oddball.mat',...  
             'D_Long_mfeAdspm12meg13_0502_131121_Oddball2_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg13_0502_131121_Oddball1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg14_0431_140218_TaskBlock2_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg14_0431_140218_TaskBlock1_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg14_0430_140218_TaskBlock2_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg14_0432_140218_TaskBlock2_raw_mc_oddball.mat',...
             'D_Long_mfeAdspm12meg14_0432_140218_TaskBlock1_raw_mc_oddball.mat'};

%Note - Removed file:
%%mfeAdspm12meg14_0430_140218_TaskBlock1_raw_mc_oddball.mat',... (Z7.2) as
%%was providing NaNs in Grand Mean files

%% Load and Convert
% Now that filenamesw, filenamesw1,..., filenamesw6,filenamesDif are all defined, we can load
% them into D structs and convert from spm to fieldtrip, using spm2fieldtrip
%% Control Deviants (cfilenamesw)
for i=1:length(cfilenamesw)
D{i} = spm_eeg_load(cfilenamesw{i}); % Loads NB. spm_eeg_load needs your files 
%to be in your current working directory i.e. you dont need the whole path.
cw{i} = spm2fieldtrip(D{i}); % Converts
end;
%% Patient Deviants (pfilenamesw)
for i=1:length(pfilenamesw)
D{i} = spm_eeg_load(pfilenamesw{i});
pw{i} = spm2fieldtrip(D{i});
end;
%% Control Preceeding Stimuli
for i=1:length(cfilenamesS)
D{i} = spm_eeg_load(cfilenamesS{i});
cS{i} = spm2fieldtrip(D{i});
end;
%% Patient Precceding Stimuli
for i=1:length(pfilenamesS)
D{i} = spm_eeg_load(pfilenamesS{i});
pS{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 1 (cfilenamesw1)
for i=1:length(cfilenamesw1)
D{i} = spm_eeg_load(cfilenamesw1{i});
cw1{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 1 (pfilenamesw1)
for i=1:length(pfilenamesw1)
D{i} = spm_eeg_load(pfilenamesw1{i});
pw1{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 2 (cfilenamesw2)
for i=1:length(cfilenamesw2)
D{i} = spm_eeg_load(cfilenamesw2{i});
cw2{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 2 (pfilenamesw2)
for i=1:length(pfilenamesw2)
D{i} = spm_eeg_load(pfilenamesw2{i});
pw2{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 3 (cfilenamesw3)
for i=1:length(cfilenamesw3)
D{i} = spm_eeg_load(cfilenamesw3{i});
cw3{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 3 (pfilenamesw3)
for i=1:length(pfilenamesw3)
D{i} = spm_eeg_load(pfilenamesw3{i});
pw3{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 4 (cfilenamesw4)
for i=1:length(cfilenamesw4)
D{i} = spm_eeg_load(cfilenamesw4{i});
cw4{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 4 (pfilenamesw4)
for i=1:length(pfilenamesw4)
D{i} = spm_eeg_load(pfilenamesw4{i});
pw4{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 5 (cfilenamesw5)
for i=1:length(cfilenamesw5)
D{i} = spm_eeg_load(cfilenamesw5{i});
cw5{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 5 (pfilenamesw5)
for i=1:length(pfilenamesw5)
D{i} = spm_eeg_load(pfilenamesw5{i});
pw5{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 6 (cfilenamesw6)
for i=1:length(cfilenamesw6)
D{i} = spm_eeg_load(cfilenamesw6{i});
cw6{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 6 (pfilenamesw6)
for i=1:length(pfilenamesw6)
D{i} = spm_eeg_load(pfilenamesw6{i});
pw6{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 7 (cfilenamesw7)
for i=1:length(cfilenamesw7)
D{i} = spm_eeg_load(cfilenamesw7{i});
cw7{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 7 (pfilenamesw7)
for i=1:length(pfilenamesw7)
D{i} = spm_eeg_load(pfilenamesw7{i});
pw7{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 8 (cfilenamesw8)
for i=1:length(cfilenamesw8)
D{i} = spm_eeg_load(cfilenamesw8{i});
cw8{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 8 (pfilenamesw8)
for i=1:length(pfilenamesw8)
D{i} = spm_eeg_load(pfilenamesw8{i});
pw8{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 9 (cfilenamesw9)
for i=1:length(cfilenamesw9)
D{i} = spm_eeg_load(cfilenamesw9{i});
cw9{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 9 (pfilenamesw9)
for i=1:length(pfilenamesw9)
D{i} = spm_eeg_load(pfilenamesw9{i});
pw9{i} = spm2fieldtrip(D{i});
end;
%% Control Repeat 10 (cfilenamesw10)
for i=1:length(cfilenamesw10)
D{i} = spm_eeg_load(cfilenamesw10{i});
cw10{i} = spm2fieldtrip(D{i});
end;
%% Patient Repeat 10 (pfilenamesw10)
for i=1:length(pfilenamesw10)
D{i} = spm_eeg_load(pfilenamesw10{i});
pw10{i} = spm2fieldtrip(D{i});
end;
%% Control Dev - Rep1 (cfilenamesDevRep1)
for i=1:length(cfilenamesDevRep1)
D{i} = spm_eeg_load(cfilenamesDevRep1{i});
cDevRep1{i} = spm2fieldtrip(D{i});
end;
%% Patient Dev - Rep1 (pfilenamesDevRep1)
for i=1:length(pfilenamesDevRep1)
D{i} = spm_eeg_load(pfilenamesDevRep1{i});
pDevRep1{i} = spm2fieldtrip(D{i});
end;
%% Control Dev - Rep6 (cfilenamesDevRep6)
for i=1:length(cfilenamesDevRep6)
D{i} = spm_eeg_load(cfilenamesDevRep6{i});
cDevRep6{i} = spm2fieldtrip(D{i});
end;
%% Patient Dev - Rep6 (pfilenamesDevRep6)
for i=1:length(pfilenamesDevRep6)
D{i} = spm_eeg_load(pfilenamesDevRep6{i});
pDevRep6{i} = spm2fieldtrip(D{i});
end;
%% Control All Repeats(cfilenamesAllReps)
for i=1:length(cfilenamesAllReps)
D{i} = spm_eeg_load(cfilenamesAllReps{i});
cAllReps{i} = spm2fieldtrip(D{i});
end;
%% Patient All Repeats(pfilenamesAllReps)
for i=1:length(pfilenamesAllReps)
D{i} = spm_eeg_load(pfilenamesAllReps{i});
pAllReps{i} = spm2fieldtrip(D{i});
end;
%% Control Dev 250 (cfilenamesDev250)
for i=1:length(cfilenamesDev250)
D{i} = spm_eeg_load(cfilenamesDev250{i});
cDev250{i} = spm2fieldtrip(D{i});
end;
%% Patient Dev 250 (pfilenamesDev250)
for i=1:length(pfilenamesDev250)
D{i} = spm_eeg_load(pfilenamesDev250{i});
pDev250{i} = spm2fieldtrip(D{i});
end;
%% Control Dev 500 (cfilenamesDev500)
for i=1:length(cfilenamesDev500)
D{i} = spm_eeg_load(cfilenamesDev500{i});
cDev500{i} = spm2fieldtrip(D{i});
end;
%% Patient Dev 500 (pfilenamesDev500)
for i=1:length(pfilenamesDev500)
D{i} = spm_eeg_load(pfilenamesDev500{i});
pDev500{i} = spm2fieldtrip(D{i});
end;
%% Control Dev 1000(cfilenamesDev1000)
for i=1:length(cfilenamesDev1000)
D{i} = spm_eeg_load(cfilenamesDev1000{i});
cDev1000{i} = spm2fieldtrip(D{i});
end;
%% Patient Dev 1000(pfilenamesDev1000)
for i=1:length(pfilenamesDev1000)
D{i} = spm_eeg_load(pfilenamesDev1000{i});
pDev1000{i} = spm2fieldtrip(D{i});
end;
%% Control 250Hz (cfilenames250)
for i=1:length(cfilenames250)
D{i} = spm_eeg_load(cfilenames250{i});
c250{i} = spm2fieldtrip(D{i});
end
%% Control 500Hz (cfilenames500)
for i=1:length(cfilenames500)
D{i} = spm_eeg_load(cfilenames500{i});
c500{i} = spm2fieldtrip(D{i});
end
%% Control 1000Hz(cfilenames1000)
for i=1:length(cfilenames1000)
D{i} = spm_eeg_load(cfilenames1000{i});
c1000{i} = spm2fieldtrip(D{i});
end
%% Patient 250Hz (pfilenames250)
for i=1:length(pfilenames250)
D{i} = spm_eeg_load(pfilenames250{i});
p250{i} = spm2fieldtrip(D{i});
end
%% Patient 500Hz (pfilenames500)
for i=1:length(pfilenames500)
D{i} = spm_eeg_load(pfilenames500{i});
p500{i} = spm2fieldtrip(D{i});
end
%% Patient 1000Hz(pfilenames1000)
for i=1:length(pfilenames1000)
D{i} = spm_eeg_load(pfilenames1000{i});
p1000{i} = spm2fieldtrip(D{i});
end
%% Control Deviant Short (cShortDev)
for i=1:length(cShortDev)
D{i} = spm_eeg_load(cShortDev{i});
cDevShort{i} = spm2fieldtrip(D{i});
end
%% Control Deviant Long (cLongDev)
for i=1:length(cLongDev)
D{i} = spm_eeg_load(cLongDev{i});
cDevLong{i} = spm2fieldtrip(D{i});
end
%% Patient Deviant Short (pShortDev)
for i=1:length(pShortDev)
D{i} = spm_eeg_load(pShortDev{i});
pDevShort{i} = spm2fieldtrip(D{i});
end
%% Patient Deviant Long (pLongDev)
for i=1:length(pLongDev)
D{i} = spm_eeg_load(pLongDev{i});
pDevLong{i} = spm2fieldtrip(D{i});
end
%% File information

%Of note, each file had been averaged by a variable number of trials.

% Lay out of these arrays...
% w    = Deviants
% w1   = Repeat 1 e.g. w1{2} = second file of repeat 1
% w2   = Repeat 2
% w3   = Repeat 3
% w4   = Repeat 4 
% w5   = Repeat 5 
% w6   = Repeat 6
% Dif  = Deviant - Repeat 1
% Dif6 = Deviant - Repeat 6

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% SECTION 1: AEF RESULTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Defining functional channel indexes for AEFs (and subsequent computations)

%Channel selection for AEF
%Control faulty channels: 57, 63, 65, 66, 82
%Patient faulty channels: 

InitialControlChannels     = [1:102];
FaultyControlChannels      = [57 63 65 66 82];

for i = FaultyControlChannels;
    InitialControlChannels(i) = 0;
end

ControlAEFChannelIndexes   = InitialControlChannels(InitialControlChannels~=0);

InitialPatientChannels     = [1:102];
FaultyPatientChannels      = [1 3 4 57 58 63 64 82];

% Faulty patient channels:
% Initially, [57 58 82]
% Added later [0111, 0131, 1711, 1721] which are ... [1 3 63 64]
% Added later index 4

for i = FaultyPatientChannels
    InitialPatientChannels(i) = 0;
end

PatientAEFChannelIndexes   = InitialPatientChannels(InitialPatientChannels~=0);

% for AEFs, all we require are the indexes but for later, we will require
% labels

%% Defining function control and patient channels with and without labels for later

% We only needed the indexes for plotting AEFs, but will require their
% respecitve channel names for the ft functions


                InitialChannels{1} = InitialControlChannels;
                InitialChannels{2} = InitialPatientChannels;
cfg = [];
cfg.channel             = ft_channelselection('all','megmag');
cfg.latency             = 'all';
cfg.keepindividual      = 'yes';
Control_GM_AEF          = ft_timelockgrandaverage(cfg, cw{:},cw1{:},cw2{:},cw3{:},cw4{:},cw5{:},cw6{:});
Patient_GM_AEF          = ft_timelockgrandaverage(cfg, pw{:},pw1{:},pw2{:},pw3{:},pw4{:},pw5{:},pw6{:});
for i=1:102;
Control_GM_AEF.label(i)=regexprep(Control_GM_AEF.label(i),'MEG','');
Patient_GM_AEF.label(i)=regexprep(Patient_GM_AEF.label(i),'MEG','');
end;

                Groups{1} = Control_GM_AEF;
                Groups{2} = Patient_GM_AEF;

                for i = 1:length(Groups);
    
                % Vector 1
                CellLabels                 = Groups{i}.label;                                     %vector of all channels in the statistic
                StringLabels               = cell2mat(CellLabels);                                %converts cell to constitute strings
                NumberLabels               = str2num(StringLabels);       
                % Vector 2
                LogicalControl             = logical(InitialChannels{i});
                LogicalControl             = LogicalControl';
                % Vector 3
                FilteredChan               = NumberLabels .* LogicalControl;                      %However!!! Here, it removes the number '0' from all the first 34 of magnetometers (later it would plot 63 otherwise!)
                                                                                                  %We will later therefore add a zero to all 3 digit numbers
                FilterChanFull             = FilteredChan(FilteredChan~=0);                       %This filters out the zeros
                RowChannels                = FilterChanFull';                                     %Makes it a row vector
                CellChan                   = mat2cell(RowChannels,1,ones(1,size(RowChannels,2))); %Seperates each of the doubles to cell

                  for           u = 1:length(CellChan);                            
                      CellChan{u} = num2str(CellChan{u});
                  end
                  
                  for l = 1:length(CellChan);                                                     %Add a zero to all three digit numbers (these had zeros removed earlier)
                      if numel(CellChan{l}) == 3;
                         CellChan{l}=strcat('0',CellChan{l});
                      end
                  end
                          
                Channels{i} = CellChan;
                end

                ControlChannelsNoLabels = Channels{1}; 
                PatientChannelsNoLabels = Channels{2}; 

                for i=1:length(ControlChannelsNoLabels);
                ControlChannelsYesLabels      = strcat('MEG',ControlChannelsNoLabels);
                end

                for i=1:length(PatientChannelsNoLabels);
                PatientChannelsYesLabels      = strcat('MEG',PatientChannelsNoLabels);
                end

                % Now we have channel vectors with an without labels for later on...
                
%% Auditory Evoked Fields (AEFs)

% Form the AEF

cfg = [];
cfg.channel             = ControlChannelsYesLabels;
cfg.latency             = 'all';
cfg.keepindividual      = 'yes';

Control_GM_AEF          = ft_timelockgrandaverage(cfg, cw{:},cw1{:},cw2{:},cw3{:},cw4{:},cw5{:},cw6{:});

cfg.channel             = PatientChannelsYesLabels;
Patient_GM_AEF          = ft_timelockgrandaverage(cfg, pw{:},pw1{:},pw2{:},pw3{:},pw4{:},pw5{:},pw6{:});

for i=1:length(Control_GM_AEF.label);
Control_GM_AEF.label(i)=regexprep(Control_GM_AEF.label(i),'MEG','');
end

for i=1:length(Patient_GM_AEF.label);
Patient_GM_AEF.label(i)=regexprep(Patient_GM_AEF.label(i),'MEG','');
end;

cfg.channel             = ControlChannelsYesLabels;
Control_GM_AEF250       = ft_timelockgrandaverage(cfg, c250{:});
Control_GM_AEF500       = ft_timelockgrandaverage(cfg, c500{:});
Control_GM_AEF1000      = ft_timelockgrandaverage(cfg, c1000{:});
cfg.channel             = PatientChannelsYesLabels;
Patient_GM_AEF250       = ft_timelockgrandaverage(cfg, p250{:});
Patient_GM_AEF500       = ft_timelockgrandaverage(cfg, p500{:});
Patient_GM_AEF1000      = ft_timelockgrandaverage(cfg, p1000{:});

%% Plotting the AEFs for all functional channels, with peaks of activity plotted
%% Loading magnetic field distribution (selected_data) and time

% First, we will load all meaned trial values for each channel over time indexes

% 1. ControlAEF

selected_dataControlAEF = zeros(length(ControlAEFChannelIndexes),239);
for i = 1:length(ControlAEFChannelIndexes);
    
        selected_dataControlAEF(i,1:239) = mean(squeeze(Control_GM_AEF.individual(:,i,:)),1); %squeeze to go down a dimension and meaned across all trials
end
        
% 2. PatientAEF
        
selected_dataPatientAEF = zeros(length(PatientAEFChannelIndexes),239);
for i = 1:length(PatientAEFChannelIndexes);
    
        selected_dataPatientAEF(i,1:239) = mean(squeeze(Patient_GM_AEF.individual(:,i,:)),1); 
end

% 3. Control 250, 500 and 1000

selected_dataControl250 = zeros(length(ControlAEFChannelIndexes),239);
for i = 1:length(ControlAEFChannelIndexes);
    
        selected_dataControl250(i,1:239) = mean(squeeze(Control_GM_AEF250.individual(:,i,:)),1); 
end

selected_dataControl500 = zeros(length(ControlAEFChannelIndexes),239);
for i = 1:length(ControlAEFChannelIndexes);
    
        selected_dataControl500(i,1:239) = mean(squeeze(Control_GM_AEF500.individual(:,i,:)),1); 
end

selected_dataControl1000 = zeros(length(ControlAEFChannelIndexes),239);
for i = 1:length(ControlAEFChannelIndexes);
    
        selected_dataControl1000(i,1:239) = mean(squeeze(Control_GM_AEF1000.individual(:,i,:)),1); 
end

% 4. Patient 250, 500 and 1000

selected_dataPatient250 = zeros(length(PatientAEFChannelIndexes),239);
for i = 1:length(PatientAEFChannelIndexes);
    
        selected_dataPatient250(i,1:239) = mean(squeeze(Patient_GM_AEF250.individual(:,i,:)),1);
end

selected_dataPatient500 = zeros(length(PatientAEFChannelIndexes),239);
for i = 1:length(PatientAEFChannelIndexes);
    
        selected_dataPatient500(i,1:239) = mean(squeeze(Patient_GM_AEF500.individual(:,i,:)),1); 
end

selected_dataPatient1000 = zeros(length(PatientAEFChannelIndexes),239);
for i = 1:length(PatientAEFChannelIndexes);
    
        selected_dataPatient1000(i,1:239) = mean(squeeze(Patient_GM_AEF1000.individual(:,i,:)),1); 
end

% We take time from either Controls or Patients as it is the same

Control_GM_AEF.time     = Control_GM_AEF.time     .* 10^3;
Patient_GM_AEF.time     = Patient_GM_AEF.time     .* 10^3;
Control_GM_AEF250.time  = Control_GM_AEF250.time  .* 10^3;
Control_GM_AEF500.time  = Control_GM_AEF500.time  .* 10^3;
Control_GM_AEF1000.time = Control_GM_AEF1000.time .* 10^3;
Patient_GM_AEF250.time  = Patient_GM_AEF250.time  .* 10^3;
Patient_GM_AEF500.time  = Patient_GM_AEF500.time  .* 10^3;
Patient_GM_AEF1000.time = Patient_GM_AEF1000.time .* 10^3;

time = Control_GM_AEF.time; %for plotting

%% Determining peaks of activity in AEFs

% Defining peaks around 148ms - for a 64ms windows

indexCentralWindow  = 138; %This corresponds to 148ms.

bin = 0.004; %this is the sampling time for AEFs, thus 1/239 (index) = 0.004 (s) 

SecondsEachWay          = 0.040; %32ms each way to extract peaks
NumberOfIndexesEachWay  = SecondsEachWay/bin;
indexOfStart            = indexCentralWindow  - NumberOfIndexesEachWay;
indexOfEnd              = indexCentralWindow  + NumberOfIndexesEachWay;
matrixOfWindowIndexes   = indexOfStart:1:indexOfEnd;

% find a time span

StartWindow             = Control_GM_AEF.time(indexOfStart);
EndWindow               = Control_GM_AEF.time(indexOfEnd);

% Time window 40ms each way of defined central region

TimeWindow              = [StartWindow:bin:EndWindow];

% AEFs 

ControlChannelsInWindow             = selected_dataControlAEF(:,matrixOfWindowIndexes);
ControlAEFmaxM100                   = max(max(abs(ControlChannelsInWindow(:)),1));
[ControlChan, ControlM100TimeIndex] = find(abs(selected_dataControlAEF)==ControlAEFmaxM100);
ControlM100Time                     = Control_GM_AEF.time(ControlM100TimeIndex);

PatientChannelsInWindow             = selected_dataPatientAEF(:,matrixOfWindowIndexes);
PatientAEFmaxM100                   = max(max(abs(PatientChannelsInWindow(:)),1));
[PatientChan, PatientM100TimeIndex] = find(abs(selected_dataPatientAEF)==PatientAEFmaxM100);
PatientM100Time                     = Patient_GM_AEF.time(PatientM100TimeIndex);

% AEFs broken down by frequency stimulus

Control250ChannelsInWindow                  = selected_dataControl250(:,matrixOfWindowIndexes);
Control250AEFmaxM100                        = max(max(abs(Control250ChannelsInWindow(:)),1));
[Control250Chan, Control250M100TimeIndex]   = find(abs(selected_dataControl250)==Control250AEFmaxM100);
Control250M100Time                          = Control_GM_AEF250.time(Control250M100TimeIndex);

Control500ChannelsInWindow                  = selected_dataControl500(:,matrixOfWindowIndexes);
Control500AEFmaxM100                        = max(max(abs(Control500ChannelsInWindow(:)),1));
[Control500Chan, Control500M100TimeIndex]   = find(abs(selected_dataControl500)==Control500AEFmaxM100);
Control500M100Time                          = Control_GM_AEF500.time(Control500M100TimeIndex);

Control1000ChannelsInWindow                 = selected_dataControl1000(:,matrixOfWindowIndexes);
Control1000AEFmaxM100                       = max(max(abs(Control1000ChannelsInWindow(:)),1));
[Control1000Chan, Control1000M100TimeIndex] = find(abs(selected_dataControl1000)==Control1000AEFmaxM100);
Control1000M100Time                         = Control_GM_AEF1000.time(Control1000M100TimeIndex);

Patient250ChannelsInWindow                  = selected_dataPatient250(:,matrixOfWindowIndexes);
Patient250AEFmaxM100                        = max(max(abs(Patient250ChannelsInWindow(:)),1));
[Patient250Chan, Patient250M100TimeIndex]   = find(abs(selected_dataPatient250)==Patient250AEFmaxM100);
Patient250M100Time                          = Patient_GM_AEF250.time(Patient250M100TimeIndex);

Patient500ChannelsInWindow                  = selected_dataPatient500(:,matrixOfWindowIndexes);
Patient500AEFmaxM100                        = max(max(abs(Patient500ChannelsInWindow(:)),1));
[Patient500Chan, Patient500M100TimeIndex]   = find(abs(selected_dataPatient500)==Patient500AEFmaxM100);
Patient500M100Time                          = Patient_GM_AEF500.time(Patient500M100TimeIndex);

Patient1000ChannelsInWindow                 = selected_dataPatient1000(:,matrixOfWindowIndexes);
Patient1000AEFmaxM100                       = max(max(abs(Patient1000ChannelsInWindow(:)),1));
[Patient1000Chan, Patient1000M100TimeIndex] = find(abs(selected_dataPatient1000)==Patient1000AEFmaxM100);
Patient1000M100Time                         = Patient_GM_AEF1000.time(Patient1000M100TimeIndex);

%% Root mean square values
%  The previous part calculated max individual channel amplitude
%  RMS takes the total, squares and roots - is a measure of total activity
%  ControlAEFmaxM100 vs ControlRMSpeak
%  ControlM100Time   vs ControlRMSpeak_time

[v i] = max(rms(selected_dataControlAEF));
ControlRMSpeak          = v;
ControlRMSpeak_time     = time(i);

[v i] = max(rms(selected_dataControl250));
ControlRMSpeak250       = v;
ControlRMSpeak250_time  = time(i);

[v i] = max(rms(selected_dataControl500));
ControlRMSpeak500       = v;
ControlRMSpeak500_time  = time(i);

[v i] = max(rms(selected_dataControl1000));
ControlRMSpeak1000      = v;
ControlRMSpeak1000_time = time(i);

[v i] = max(rms(selected_dataPatientAEF));
PatientRMSpeak          = v;
PatientRMSpeak_time     = time(i);

[v i] = max(rms(selected_dataPatient250));
PatientRMSpeak250       = v;
PatientRMSpeak250_time  = time(i);

[v i] = max(rms(selected_dataPatient500));
PatientRMSpeak500       = v;
PatientRMSpeak500_time  = time(i);

[v i] = max(rms(selected_dataPatient1000));
PatientRMSpeak1000       = v;
PatientRMSpeak1000_time  = time(i);

%% Plotting AEFs with selected_data and time
%% 1. AEF from Control GM of all conditions 

AxisSize  = 20;
LabelSize = 35;

figure;
        
plot(time,selected_dataControlAEF,'LineWidth',2,'Color',[1 0 0]);
       
xlim([-50 500]);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);
hold on
plot([0 0],[-120 80],'--k','LineWidth',0.5);
text(0,76,' Stimulus Onset','FontSize',AxisSize );
hold on
plot([ControlRMSpeak_time ControlRMSpeak_time], [-120 80], '-k','Color',[0 0 0],'LineWidth',2);
text(ControlRMSpeak_time,76,sprintf(' Latency ~ %gms: %gfT',ControlRMSpeak_time,round(ControlAEFmaxM100)),'FontSize',AxisSize);
set(gca, 'FontSize',AxisSize ,'TickLength',[0 0]);

%% 2. AEF from Patient GM of all conditions     

figure;

plot(time,selected_dataPatientAEF,'LineWidth',2,'Color',[0 0 1]);

xlim([-50 500]);
ylim([-950 1100]);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);
hold on
plot([0 0],[-950 1100],'--k','LineWidth',0.5);
text(0,1050,' Stimulus Onset','FontSize',AxisSize );
hold on
plot([PatientRMSpeak_time PatientRMSpeak_time], [-950 1100], '-k','Color',[0 0 0],'LineWidth',2);
text(PatientRMSpeak_time,1050,sprintf(' Latency ~%gms: %gfT',PatientRMSpeak_time,round(PatientAEFmaxM100)),'FontSize',AxisSize);
set(gca,'FontSize',AxisSize ,'TickLength',[0 0]);

%% 3. Control AEF broken down by frequency stimulus

% 250, 500 and 1000Hz

AxisSizeBroken  = 20;

figure;

subplot(311);

        plot(time,selected_dataControl250,'LineWidth',0.3,'Color',[0.7 0 0]);
        
        xlim([-50 500]);
        ylim([-200 200]);
        
        hold on

        plot([0 0],[-200 200],'--k','LineWidth',0.5);
        text(0,160,' 250Hz stimulus','FontSize',AxisSizeBroken);
        
        hold on

        plot([ControlRMSpeak250_time ControlRMSpeak250_time], [-200 200], '-k','Color',[0 0 0],'LineWidth',2);
        text(ControlRMSpeak250_time,160,sprintf(' Latency ~%gms',ControlRMSpeak250_time),'FontSize',AxisSizeBroken);
        
        hold on
        
        set(gca,'FontSize',AxisSizeBroken,'TickLength',[0 0]);
        set(gca,'XTickLabel',{''});

subplot(312);

        plot(time,selected_dataControl500,'LineWidth',0.3,'Color',[0.7 0 0]);
        
        xlim([-50 500]);
        ylim([-200 200]);
        
        ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);
        
        hold on

        plot([0 0],[-200 200],'--k','LineWidth',0.5);
        text(0,160,' 500Hz stimulus','FontSize',AxisSizeBroken);
        
        hold on

        plot([ControlRMSpeak500_time ControlRMSpeak500_time], [-200 200], '-k','Color',[0 0 0],'LineWidth',2);
        text(ControlRMSpeak500_time,160,sprintf(' Latency ~%gms',ControlRMSpeak500_time),'FontSize',AxisSizeBroken);
        
        set(gca,'FontSize',AxisSizeBroken,'TickLength',[0 0]);
        set(gca,'XTickLabel',{''});

subplot(313);

        plot(time,selected_dataControl1000,'LineWidth',0.3,'Color',[0.7 0 0]);
        
        xlim([-50 500]);
        ylim([-200 200]);
        
        xlabel('Time (ms)','FontSize',LabelSize);
        
        hold on

        plot([0 0],[-200 200],'--k','LineWidth',0.5);
        text(0,160,' 1000Hz stimulus','FontSize',AxisSizeBroken);
        
        hold on

        plot([ControlRMSpeak1000_time ControlRMSpeak1000_time], [-200 200], '-k','Color',[0 0 0],'LineWidth',2);
        text(ControlRMSpeak1000_time,160,sprintf(' Latency ~%gms',ControlRMSpeak1000_time),'FontSize',AxisSizeBroken);
        
        set(gca,'FontSize',AxisSizeBroken,'TickLength',[0 0]);
        
        % Manually drag the subplots to elimate dead-space (can always generate .m file)
        
%% 4. Patient AEF broken down by frequency stimulus

% 250, 500 and 1000Hz

figure;

subplot(311);

        plot(time,selected_dataPatient250,'LineWidth',0.3,'Color',[0 0 0.7]);
        
        xlim([-50 500]);
        ylim([-1400 3200]);
        
        hold on

        plot([0 0],[-2200 4500],'--k','LineWidth',0.5);
        text(0,2700,' 250Hz stimulus','FontSize',AxisSizeBroken);
        
        hold on

        plot([PatientRMSpeak250_time PatientRMSpeak250_time], [-2200 4500], '-k','Color',[0 0 0],'LineWidth',2);
        text(PatientRMSpeak250_time,2700,sprintf(' Latency ~%gms',PatientRMSpeak250_time),'FontSize',AxisSizeBroken);
        
        set(gca,'FontSize',AxisSizeBroken,'TickLength',[0 0]);
        set(gca,'XTickLabel',{''});

subplot(312);

        plot(time,selected_dataPatient500,'LineWidth',0.3,'Color',[0 0 0.7]);
        
        xlim([-50 500]);
        ylim([-1400 3200]);
        
        ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);
        
        hold on

        plot([0 0],[-2200 4500],'--k','LineWidth',0.5);
        text(0,2700,' 500Hz stimulus','FontSize',AxisSizeBroken);
        
        hold on

        plot([PatientRMSpeak500_time PatientRMSpeak500_time], [-2200 4500], '-k','Color',[0 0 0],'LineWidth',2);
        text(PatientRMSpeak500_time,2700,sprintf(' Latency ~%gms',PatientRMSpeak500_time),'FontSize',AxisSizeBroken);
        
        set(gca,'FontSize',AxisSizeBroken,'TickLength',[0 0]);
        set(gca,'XTickLabel',{''});

subplot(313);

        plot(time,selected_dataPatient1000,'LineWidth',0.3,'Color',[0 0 0.7]);
        
        xlim([-50 500]);
        ylim([-1400 3200]);
        
        xlabel('Time (ms)','FontSize',LabelSize);
        
        hold on

        plot([0 0],[-2200 4500],'--k','LineWidth',0.5);
        text(0,2700,' 1000Hz stimulus','FontSize',AxisSizeBroken);
        
        hold on

        plot([PatientRMSpeak1000_time PatientRMSpeak1000_time], [-2200 4500], '-k','Color',[0 0 0],'LineWidth',2);
        text(PatientRMSpeak1000_time,2700,sprintf(' Latency ~%gms',PatientRMSpeak1000_time),'FontSize',AxisSizeBroken);
        
        set(gca,'FontSize',AxisSizeBroken,'TickLength',[0 0]);
        
%% Topographical plot at specific AEF points of interest, for controls and patients

% The input can either be a statistic, or the output of ft_timelockanalysis, so we must do the latter

% ft_timelockanalysis

cfg = [];
cfg.channel = 'all';
cfg.covariance = 'yes';
Control = ft_timelockanalysis(cfg,Control_GM_AEF);
cfg.channel = 'all';
Patient = ft_timelockanalysis(cfg,Patient_GM_AEF);

% Check: plot(Control.time, Control.avg) to get AEFs.

% Covariance across ERFs...

%plot(Control.time, Control.var,'LineWidth',2);
%xlim([-50 500]);

figure;
imagesc(Control.var);
colormap(jet(256));
c = colorbar;
set(gca,'TickLength',[0 0]);
set(gca,'FontSize',20);

xlabel(sprintf('Time point'),'fontsize',25);
ylabel(sprintf('Channel'),'fontsize',25);
ylabel(c,'Covariance','fontsize',25);
title(('Control AEF Covariance matrix'),'fontsize',30,'fontWeight','bold');

figure;
imagesc(Patient.var);
colormap(jet(256));
c = colorbar;
set(gca,'TickLength',[0 0]);
set(gca,'FontSize',20);

xlabel(sprintf('Time point'),'fontsize',25);
ylabel(sprintf('Channel'),'fontsize',25);
ylabel(c,'Covariance','fontsize',25);
title(('Patient AEF Covariance matrix'),'fontsize',30,'fontWeight','bold');

% form the titles for each plot

TitleControl   = sprintf('Control: Topographical plot at %d ms',round(ControlRMSpeak_time));

TitlePatient   = sprintf('Patient: Topographical plot at %d ms',round(PatientRMSpeak_time));

% Plot all controls of defined important times

layoutMag    = 'NM306mag.lay';

figure;
cfg = [];
cfg.xlim = [round(ControlRMSpeak_time) round(ControlRMSpeak_time)];
cfg.layout = layoutMag;
cfg.parameter = 'avg';
cfg.gridscale = 1000;
cfg.marker    = 'off';
cfg.colorbar  = 'yes'; % or no
cfg.style     = 'straight';
ft_topoplotER(cfg, [Control]);
title(TitleControl);

% Plot all patients of defined important times

figure;
cfg = [];
cfg.xlim      = [round(PatientRMSpeak_time) round(PatientRMSpeak_time)];
cfg.layout    = layoutMag;
cfg.parameter = 'avg';
cfg.gridscale = 1000;
cfg.marker    = 'off';
cfg.colorbar  = 'yes'; % or no
cfg.style     = 'straight';
ft_topoplotER(cfg, [Patient]);
title(TitlePatient);

% Plotting global mean field powers

cfg = [];
cfg.method        = 'amplitude';
cfg.channel       = 'all';
gmf_Control       = ft_globalmeanfield(cfg,Control);
gmf_Patient       = ft_globalmeanfield(cfg,Patient);
xlimit            = [-50 500];

figure;
plot(gmf_Control.time, gmf_Control.avg,'LineWidth',2);
set(gca,'TickLength',[0 0]);
xlabel('Time (ms)');
ylabel('Global Mean Field Amplitude');
xlim(xlimit);
hold on 
plot(gmf_Patient.time, gmf_Patient.avg,'LineWidth',2);



% Plotting global mean field powers for all individual files

cfg = [];
cfg.channel = 'all';

ind_Controls = {};
for i = 1:length(cw)
ind_Controls{i} = ft_timelockgrandaverage(cfg, cw{i},cw1{i},cw2{i},cw3{i},cw4{i},cw5{i},cw6{i});
end

ind_Patients = {};
for i = 1:length(pw)
ind_Patients{i} = ft_timelockgrandaverage(cfg, pw{i},pw1{i},pw2{i},pw3{i},pw4{i},pw5{i},pw6{i});
end

gmf_Control    = {};
gmf_Patient    = {};

for i = 1:length(ind_Controls)
cfg = [];
cfg.method        = 'amplitude';
cfg.channel       = 'all';
gmf_Control{i}    = ft_globalmeanfield(cfg,ind_Controls{i});
end

for i = 1:length(ind_Patients)
cfg = [];
cfg.method        = 'amplitude';
cfg.channel       = 'all';
gmf_Patient{i}    = ft_globalmeanfield(cfg,ind_Patients{i});
end

xlimit            = [-50 500];
ylabel            = 'Global Mean Field Amplitude';

figure;
subplot(2,1,1);
for i = 1:length(gmf_Control)
plot(gmf_Control{i}.time, gmf_Control{i}.avg,'LineWidth',2);
xlabel('Time (ms)');
xlim(xlimit);
set(gca,'TickLength',[0 0]);
hold on
end
subplot(2,1,2);
for i = 1:length(gmf_Patient)
plot(gmf_Patient{i}.time, gmf_Patient{i}.avg,'LineWidth',2);
xlabel('Time (ms)');
xlim(xlimit);
set(gca,'TickLength',[0 0]);
hold on
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% SECTION 2: STATISTICAL CLUSTERING AND ERF COMPUTATION

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Layout and template file selection

% We now have a lay file that has corresponding labels to the MEG data
%Before starting plotting or analysis, select .lay file and .template based upon channel
%selection
%i.e. if channel = ft_channelselection('all','megmag') we need mag layouts
%and mag templates
layoutMag    = 'NM306mag.lay';
layoutGrad   = 'NM306planar.lay';
%for all: NM306all.lay
%for magnetometers: NM306mag.lay
%for gradiometers: NM306planar.lay
templateMag  = 'neuromag306mag_neighb.mat';
templateGrad = 'neuromag306planar_neighb.mat';
templateBoth = 'neuromag306cmb_neighb.mat';
%for combined: neuromag306cmb_neighb.mat
%for magnetometers: neuromag306mag_neighb.mat
%for gradiometers: neuromag306planar_neighb.mat

%% Neighbouring function

%We now make a neighbouring function for Mags and Grads.
cfgMag.method           = 'distance';       %distance,triangulation or template
cfgGrad.method          = 'triangulation';
cfgMag.neighbourdist    = 0.13;                %for distance method (did 0.13 previously)
cfgGrad.neighbourdist   = 3;                %if distance used
%Template ~ no neighbours
%Distance = use 0.13
%Triangulation ~ 7.8
cfgMag.template         = templateBoth;
cfgGrad.template        = templateGrad;
cfgMag.layout           = layoutMag; 
cfgGrad.layout          = layoutGrad;
cfgMag.channel          = 'all';           %Can say all now as previously defined
cfgGrad.channel         = 'all';
%cfgMag.feedback        = 'yes';
%cfgGrad.feedback       = 'yes';
neighboursMag           = ft_prepare_neighbours(cfgMag);
neighboursGrad          = ft_prepare_neighbours(cfgGrad);
%figure; ft_neighbourplot(cfgMag);
%figure; ft_neighbourplot(cfgGrad);

%Note the following...

%cfg=[];
%cfg.layout = 'NM306mag.lay'
%ft_layoutplot(cfg

%These do not have 'MEG' at the beginning...

%ft_timelockstatistic REQUIRES 'MEG' at the front of channel number
%ft_clusterplot DOES NOT WORK with 'MEG' at with channel number
%as the neighbour function that we have just defined does not have it in

%% Neighbour label change to include 'MEG'

%for ft_timelockstatistics (next section), sensors need to have the MEG 
%label added back onto it...

for i=1:102
    neighboursMag(i).label        = strcat('MEG',neighboursMag(i).label);
    neighboursMag(i).neighblabel  = strcat('MEG',neighboursMag(i).neighblabel);
end

%for i=1:204
%    neighboursGrad(i).label       = strcat('MEG',neighboursGrad(i).label);
%    neighboursGrad(1).neighblabel  = strcat('MEG',neighboursGrad(1).neighblabel);
%end 
% Check neighboursMag.label and neighboursMag.neighblabel, have MEG before
% the channel number

%% Non-parametric clustering in sensor space

% Statistics can be generated by utilising grand means as
% inputs for ft_timelockstatistics
% As in the example on FieldTrip 'Para and non-para statistics on
% event-related fields'.

%We can run the statistics for magnetometers and gradiometers, for what
%ever conditions we choose

cfgMag  = [];

cfgMag.neighbours          = neighboursMag; % dist 0.13 (7 neighbours), 0.2 (13.6)
cfgMag.latency             = [0.1 0.54];    %Define the window
cfgMag.parameter           = 'avg';
cfgMag.method              = 'montecarlo';  %help FT_STATISTICS_MONTECARLO)
cfgMag.minnbchan           = 2;
cfgMag.numrandomization    = 5000;          %this can be 'all'. Increased number of permuations may be required.
cfgMag.correctm            = 'cluster';     %multiple-comparison correction
cfgMag.correcttail         = 'prob';   
cfgMag.alpha               = 0.05;          %Note this if getting a ft_clusterplot error!
cfgMag.ivar                = 1; % the 1st row in cfg.design contains the independent variable
cfgMag.uvar                = 2; % the 2nd row in cfg.design contains the subject number
cfgMag.statistic           = 'ft_statfun_depsamplesT';

%% Important stat computation

cfgMag.channel                  = ControlChannelsYesLabels; %Defined previously

Nsub=14;
cfgMag.design(1,1:2*Nsub)       = [ones(1,Nsub) 2*ones(1,Nsub)];
cfgMag.design(2,1:2*Nsub)       = [1:Nsub 1:Nsub];

% Control: Deviant to Preceeding Stimuli
MagStat_Control_DevS            = ft_timelockstatistics(cfgMag,cw{:},cS{:});
% Control: Short Dev to Preceeding Stimuli
%cfgMag.alpha = 0.15;
%MagStat_Control_ShortDevS       = ft_timelockstatistics(cfgMag,cDevShort{:},cS{:});
% Control: Long Dev to Preceeding Stimuli
%cfgMag.alpha = 0.05;
%MagStat_Control_LongDevS_Both   = ft_timelockstatistics(cfgMag,cDevLong{:},cS{:});
%cfgMag.alpha = 0.03;
%MagStat_Control_LongDevS_Neg    = ft_timelockstatistics(cfgMag,cDevLong{:},cS{:});
% Control: Short Dev to Long Dev
%MagStat_Control_LongDevShortDev = ft_timelockstatistics(cfgMag,cDevLong{:},cDevShort{:});

cfgMag.channel                  = PatientChannelsYesLabels;

Nsub=17;
cfgMag.design(1,1:2*Nsub)       = [ones(1,Nsub) 2*ones(1,Nsub)];
cfgMag.design(2,1:2*Nsub)       = [1:Nsub 1:Nsub];

% Patient: Deviant to Preceeding Stimuli
MagStat_Patient_DevS            = ft_timelockstatistics(cfgMag,pw{:},pS{:});
% Patient: Short Dev to Preceeding Stimuli
%MagStat_Patient_ShortDevS       = ft_timelockstatistics(cfgMag,pDevShort{:},pS{:});
% Patient: Long Dev to Preceeding Stimuli
%MagStat_Patient_LongDevS        = ft_timelockstatistics(cfgMag,pDevLong{:},pS{:});
% Patient: Short Dev to Long Dev
%MagStat_Patient_LongDevShortDev = ft_timelockstatistics(cfgMag,pDevLong{:},pDevShort{:});

% Repetition effects

%cShortReps = [cw1 cw2 cw3];
%pShortReps = [pw1 pw2 pw3];
%cLongReps  = [cw6 cw7 cw8 cw9 cw10];
%pLongReps  = [pw6 pw7 pw8 pw9 pw10];

%cfgMag.channel                  = ControlChannelsYesLabels; %Defined previously
%Nsub=56;
%cfgMag.design(1,1:2*Nsub)       = [ones(1,Nsub) 2*ones(1,Nsub)];
%cfgMag.design(2,1:2*Nsub)       = [1:Nsub 1:Nsub];

%MagStat_Control_lR_sR           = ft_timelockstatistics(cfgMag,cLongReps{:},cShortReps{:});

%cfgMag.channel                  = PatientChannelsYesLabels;
%Nsub=68;
%cfgMag.design(1,1:2*Nsub)       = [ones(1,Nsub) 2*ones(1,Nsub)];
%cfgMag.design(2,1:2*Nsub)       = [1:Nsub 1:Nsub];

%MagStat_Patient_lR_sR           = ft_timelockstatistics(cfgMag,pLongReps{:},pShortReps{:});

%% Remove labels for cluster plotting

MagStat_Control_DevS.label            = ControlChannelsNoLabels';
MagStat_Control_ShortDevS.label       = ControlChannelsNoLabels';
MagStat_Control_LongDevS_Both.label   = ControlChannelsNoLabels';
MagStat_Control_LongDevS_Neg.label    = ControlChannelsNoLabels';
MagStat_Control_LongDevShortDev.label = ControlChannelsNoLabels';

MagStat_Patient_DevS.label            = PatientChannelsNoLabels';
MagStat_Patient_ShortDevS.label       = PatientChannelsNoLabels';
MagStat_Patient_LongDevS.label        = PatientChannelsNoLabels';
MagStat_Patient_LongDevShortDev.label = PatientChannelsNoLabels';

%% Use ft_clusterplot to observe effect

cfg = [];
cfg.layout                 = layoutMag;               %layout(Mag/Grad) depending on StatCluster
cfg.parameter              = 'stat';   
cfg.gridscale              = 100;
cfg.style                  = 'straight';              %straight,contour,both,fill,blank
cfg.contournum             = 0;              
cfg.marker                 = 'off';                   %on,labels,numbers,off - corresponds to channels                    %same as marker
cfg.highlightsizeseries    = [10,10,10,10,10];
cfg.highlightsymbolseries  = ['*','*','*','*','*'];   %*,x,+,o,.
cfg.highlightcolorpos      = [1 1 1];

%Documentation

%1. Control_DevS                p=0.0408 [136 256]

%cfg.saveaspng = 'Control_Cluster_DevS';
ft_clusterplot(cfg,MagStat_Control_DevS);
C_DevS_Start                   = 136;
C_DevS_End                     = 256;
C_DevS_pVal                    = 0.046;

%2. Control_ShortDevS           p=0.13859  [156 236]

%cfg.alpha     = 0.15;
%cfg.saveaspng = 'Control_Cluster_ShortDevS';
%ft_clusterplot(cfg,MagStat_Control_ShortDevS);
%C_ShortDevS_Start              = 156;
%C_ShortDevS_End                = 236;
%C_ShortDevS_pVal               = 0.139;
%cfg.alpha     = 0.05;

%3. Control_LongDevS        -ve p=0.019398 [124 204]
%                           +ve p=0.046995 [144 240]

%cfg.saveaspng = 'Control_Cluster_LongDevS_N+P';
%ft_clusterplot(cfg,MagStat_Control_LongDevS_Both);
%C_LongDevS_Neg_Start           = 124;
%C_LongDevS_Neg_End             = 204;
%C_LongDevS_Neg_pVal            = 0.019;
%cfg.alpha     = 0.04;

%cfg.saveaspng = 'Control_Cluster_LongDevS_N';
%ft_clusterplot(cfg,MagStat_Control_LongDevS_Neg);
%C_LongDevS_Pos_Start           = 144;
%C_LongDevS_Pos_End             = 240;
%C_LongDevS_Pos_pVal            = 0.047;
%cfg.alpha     = 0.05;

%4. Control_DevLongDevLongShort p=0.11679  [128 208] 

%cfg.alpha     = 0.12;
%cfg.saveaspng = 'Control_Cluster_LongDevShortDev';
%ft_clusterplot(cfg,MagStat_Control_LongDevShortDev);
%C_LongDevShortDev_Start        = 128;
%C_LongDevShortDev_End          = 208;
%C_LongDevShortDev_pVal         = 0.117;
%cfg.alpha     = 0.05;

%1. Patient_DevS                p=0.012199 [172 188]

%cfg.saveaspng = 'Control_Patient_DevS';
ft_clusterplot(cfg,MagStat_Patient_DevS);
P_DevS_Start                   = 172;
P_DevS_End                     = 188;
P_DevS_pVal                    = 0.012;

%2. Patient_ShortDevS          - yes but end of epoch
%3. Patient_LongDevS           - none
%4. Patient_LongDevShortDev    - none

% There is no repetition significance for either controls or patients

%** these Starts and Ends are important for later, in ERF Computation and will be repeated ** 

%% Determining channels within clusters of significant statistics

% 102 channels, 111 time-bins
% Of the mask matrix, 1 represents significance in that time point. 
% We want to calculate all channels for which have at at least a single 1.

%List all statistics with significant clusters - ensure they have no MEG labels

StatsWithSigClusters = {MagStat_Control_DevS,... 
                        MagStat_Control_ShortDevS,...       %p>0.05
                        MagStat_Control_LongDevS_Both,...   %two clusters
                        MagStat_Control_LongDevS_Neg,...    %just the negative
                        MagStat_Control_LongDevShortDev,... %p>0.05
                        MagStat_Patient_DevS};   
StatsWithSigClusters = {MagStat_Control_DevS, MagStat_Patient_DevS};   
                    
%The input order corresponds to the output order of StatsWithSigClusters

% How many of most sig channels you want to plot from cluster

%N = 10; 

%It will get rid of all channels below the 10th i.e. may include more than 10, if all the same value
        %Also, this assumes there are 10 channels within the cluster, if
        %less is produced it is because there were less than 10
        
%if you want to plot ALL of the channels within the cluster, look insert
%that N = length(SortedMask), above ThresholdValue...
                    
for i= 1:length(StatsWithSigClusters);   
%Vector 1    
Mask                       = StatsWithSigClusters{i}.mask;
MeanedMask                 = mean(Mask,2);                                        %mean
SortedMask                 = sort(MeanedMask,1,'descend');                        %descending order

N = length(SortedMask); %This allows all channels to be selected. Define earlier otherwise

ThresholdValue             = SortedMask(N);                                       %determine the Nth value
AllBelowThresh             = find(MeanedMask<ThresholdValue);                     %index all below
MeanedMask(AllBelowThresh) = 0;                                                   %rid all below
LogicalTopMask             = logical(MeanedMask);                                 %logical vector of N most significant channels in cluster
%Vector 2
CellLabels                 = StatsWithSigClusters{i}.label;                       %vector of all channels in the statistic
StringLabels               = cell2mat(CellLabels);                                %converts cell to constitute strings
NumberLabels               = str2num(StringLabels);                               %converts strings to numbers
%Multiply Vectors
FilterChan                 = LogicalTopMask .* NumberLabels;                      %Now we can filter out the channels not in the cluster
FilterChanFull             = FilterChan(FilterChan~=0);                           %This filters out the zeros
RowChannels                = FilterChanFull';                                     %Makes it a row vector
CellChan                   = mat2cell(RowChannels,1,ones(1,size(RowChannels,2))); %Seperates each of the doubles to cell

           for           u = 1:length(CellChan);                            
               CellChan{u} = num2str(CellChan{u});
           end
    
%Cell array thats compatible with cfg.channel for ft_singleplotER
TopNSignificantChannelsOfCluster{i} = CellChan;
end                            

% We need to note the postive cluster channel matrix

TopNSignificantChannelsOfCluster{3}; %with both
TopNSignificantChannelsOfCluster{4}; %with just neg
% If we subtract we will get positive...

LongDevS_Both    = [];
for i = 1:length(TopNSignificantChannelsOfCluster{3});
LongDevS_Both(i) = str2num(TopNSignificantChannelsOfCluster{3}{i});
end
LongDevS_Neg     = [];
for i = 1:length(TopNSignificantChannelsOfCluster{4});
LongDevS_Neg(i)  = str2num(TopNSignificantChannelsOfCluster{4}{i});
end
LongDevS_Both    = LongDevS_Both';
LongDevS_Neg     = LongDevS_Neg';

LongDevS_Pos     = LongDevS_Both; %first we give pos all the labels, then take away those that have neg

for m = 1:length(LongDevS_Pos);
    for l = 1:length(LongDevS_Neg);                                                    
        if  LongDevS_Pos(m)  ==  LongDevS_Neg(l); 
            LongDevS_Pos(m)   = 0;
        end
    end
end

LongDevS_Pos = LongDevS_Pos(LongDevS_Pos~=0);
LongDevS_Pos = LongDevS_Pos';
LongDevS_Pos = mat2cell(LongDevS_Pos,1,ones(1,size(LongDevS_Pos,2)));
for p = 1:length(LongDevS_Pos);
LongDevS_Pos{p} = num2str(LongDevS_Pos{p});
end

TopNSignificantChannelsOfCluster{end+1} = LongDevS_Pos;

% However, this removed all the preceeding 0s from labels with original 0s at the beginning

for i = 1:length(TopNSignificantChannelsOfCluster);
    for h = 1:length(TopNSignificantChannelsOfCluster{i});                                                       %Add a zero to all three digit numbers (these had zeros removed earlier)
        if numel(TopNSignificantChannelsOfCluster{i}{h}) == 3;
                 TopNSignificantChannelsOfCluster{i}{h}   = strcat('0',TopNSignificantChannelsOfCluster{i}{h});
        end
end
end

% Thus just to make it easier, for later

Control_DevS_Channels              = TopNSignificantChannelsOfCluster{1};
Control_ShortDevS_Channels         = TopNSignificantChannelsOfCluster{2};
Control_LongDevS_Both_Channels     = TopNSignificantChannelsOfCluster{3};
Control_LongDevS_Neg_Channels      = TopNSignificantChannelsOfCluster{4};
Control_LongDevS_Pos_Channels      = TopNSignificantChannelsOfCluster{7};
Control_LongDevShortDev_Channels   = TopNSignificantChannelsOfCluster{5};
Patient_DevS_Channels              = TopNSignificantChannelsOfCluster{6};

%SignificantChannelsOfCluster is a cell that has all the significant
%channels for the statistics that were input initially.

%Note, these DO NOT have 'MEG' at the front, so after GM computation, we
%will have to remove 'MEG' from channel.

%% Determining if any channels overlap multiple conditions - if you want to

% Obtain a logical vector for all, multiply by combinations

% We want to overlap the Control DevRep1 and DevRep6

StatsWithSigClusters;

c     = {};
for i = 1:length(StatsWithSigClusters);     
a    = StatsWithSigClusters{i}.mask;
b    = mean(a,2);
c{i} = logical(b);
end

Condition1                = c{1}; %Control DevRep1
Condition2                = c{2}; %Control DevRep6
Condition3                = c{3}; %Control ShortDevRep6
Condition4                = c{4}; %Control LongDevRep6
Condition5                = c{5}; %Patient DevRep6

Combinations1to6          = Condition1 .* Condition2;
CombinationsShorttoLong   = Condition3 .* Condition4; % Multiply by interesting combinations to determine what overlaps

Combinations              = {[Combinations1to6] [CombinationsShorttoLong]};

d = StatsWithSigClusters{1}.label;%Just to refer this back to the combinations of controls           
e = cell2mat(d);                                   
f = str2num(e);                                   

g = Combinations{2}.*f;           %Change the number here                               
h = g(g~=0);                                        
k = h';                                              
l = mat2cell(k,1,ones(1,size(k,2)));

OverlappingSigChannels    = cell(1,length(l));

for u = 1:length(l);                             
OverlappingSigChannels{u} = num2str(l{u});
end;

% Do this manually for however many combinations you want

OverlappingSigChannelsDevRep1DevRep6          = OverlappingSigChannels;
OverlappingSigChannelsShortDevRep6LongDevRep6 = OverlappingSigChannels; 

%OverlappingSigChannels can be used when plotting an ERF

%% Grand-Meaning for ERF plotting

%cfg settings for ft_timelockgrandaverage

cfgMag =[];
cfgMag.channel          = ControlChannelsYesLabels; %We need to have labels due to inputs
cfgMag.latency          = 'all';
cfgMag.keepindividual   = 'yes'; 

%Magnetometer Control Grand-Means

MagGM_Control_Dev       = ft_timelockgrandaverage(cfgMag, cw{:});
MagGM_Control_S         = ft_timelockgrandaverage(cfgMag, cS{:});
MagGM_Control_ShortDev  = ft_timelockgrandaverage(cfgMag, cDevShort{:});
MagGM_Control_LongDev   = ft_timelockgrandaverage(cfgMag, cDevLong{:});

%Magnetometer Patient Grand-Means

clear cfgMag

cfgMag =[];
cfgMag.channel          = PatientChannelsYesLabels;
cfgMag.latency          = 'all';
cfgMag.keepindividual   = 'yes'; 

MagGM_Patient_Dev       = ft_timelockgrandaverage(cfgMag, pw{:});
MagGM_Patient_S         = ft_timelockgrandaverage(cfgMag, pS{:});
MagGM_Patient_ShortDev  = ft_timelockgrandaverage(cfgMag, pDevShort{:});
MagGM_Patient_LongDev   = ft_timelockgrandaverage(cfgMag, pDevLong{:});

% Looking at repeat reading changes

cfg = [];
cfg.channel             = ControlChannelsYesLabels; 
cfgMag.latency          = 'all';
cfgMag.keepindividual   = 'yes'; 

MagGM_Control_ShortReps = ft_timelockgrandaverage(cfg, cw1{:},cw2{:},cw3{:});
MagGM_Control_LongReps  = ft_timelockgrandaverage(cfg, cw6{:},cw7{:},cw8{:},cw9{:},cw10{:});

cfg.channel             = PatientChannelsYesLabels;
MagGM_Patient_ShortReps = ft_timelockgrandaverage(cfg, pw1{:},pw2{:},pw3{:});
MagGM_Patient_LongReps  = ft_timelockgrandaverage(cfg, pw6{:},pw7{:},pw8{:},pw9{:},pw10{:});

%% Remove Labels from GMs - also x10^3 to make into seconds

MagGM_Control_Dev.label       = ControlChannelsNoLabels;   
MagGM_Control_S.label         = ControlChannelsNoLabels;
MagGM_Control_ShortDev.label  = ControlChannelsNoLabels;
MagGM_Control_LongDev.label   = ControlChannelsNoLabels;
MagGM_Control_ShortReps.label = ControlChannelsNoLabels;
MagGM_Control_LongReps.label  = ControlChannelsNoLabels;

MagGM_Patient_Dev.label       = PatientChannelsNoLabels;
MagGM_Patient_S.label         = PatientChannelsNoLabels;
MagGM_Patient_ShortDev.label  = PatientChannelsNoLabels;
MagGM_Patient_LongDev.label   = PatientChannelsNoLabels;
MagGM_Patient_ShortReps.label = PatientChannelsNoLabels;
MagGM_Patient_LongReps.label  = PatientChannelsNoLabels;

MagGM_Control_Dev.time        = MagGM_Control_Dev.time       .* 10^3;    
MagGM_Control_S.time          = MagGM_Control_S.time         .* 10^3; 
MagGM_Control_ShortDev.time   = MagGM_Control_ShortDev.time  .* 10^3;
MagGM_Control_LongDev.time    = MagGM_Control_LongDev.time   .* 10^3;
MagGM_Control_ShortReps.time  = MagGM_Control_ShortReps.time .* 10^3;
MagGM_Control_LongReps.time   = MagGM_Control_LongReps.time  .* 10^3;

MagGM_Patient_Dev.time        = MagGM_Patient_Dev.time       .* 10^3;  
MagGM_Patient_S.time          = MagGM_Patient_S.time         .* 10^3;   
MagGM_Patient_ShortDev.time   = MagGM_Patient_ShortDev.time  .* 10^3;
MagGM_Patient_LongDev.time    = MagGM_Patient_LongDev.time   .* 10^3;
MagGM_Patient_ShortReps.time  = MagGM_Patient_ShortReps.time .* 10^3;
MagGM_Patient_LongReps.time   = MagGM_Patient_LongReps.time  .* 10^3;

%% Baseline correct these GMs [-100 0] ft_timelockbaseline

cfg = [];
cfg.baseline = [-100 0];

MagGM_Control_Dev             = ft_timelockbaseline(cfg,MagGM_Control_Dev);
MagGM_Control_S               = ft_timelockbaseline(cfg,MagGM_Control_S);
MagGM_Control_ShortDev        = ft_timelockbaseline(cfg,MagGM_Control_ShortDev);
MagGM_Control_LongDev         = ft_timelockbaseline(cfg,MagGM_Control_LongDev);
MagGM_Control_ShortReps       = ft_timelockbaseline(cfg,MagGM_Control_ShortReps);
MagGM_Control_LongReps        = ft_timelockbaseline(cfg,MagGM_Control_LongReps);

MagGM_Patient_Dev             = ft_timelockbaseline(cfg,MagGM_Patient_Dev);
MagGM_Patient_S               = ft_timelockbaseline(cfg,MagGM_Patient_S);
MagGM_Patient_ShortDev        = ft_timelockbaseline(cfg,MagGM_Patient_ShortDev);
MagGM_Patient_LongDev         = ft_timelockbaseline(cfg,MagGM_Patient_LongDev);
MagGM_Patient_ShortReps       = ft_timelockbaseline(cfg,MagGM_Patient_ShortReps);
MagGM_Patient_LongReps        = ft_timelockbaseline(cfg,MagGM_Patient_LongReps);

%% Parameters for ERF computation over significant clusters

%ERFs to plot in order:

%1a Control DevRep1
%1b Patient DevRep1 at Control sites
%1c Left cluster of Control DevRep1

%2a Control DevRep6
%2b Patient DevRep6

%3a Combination of Control Dev, Rep1 and Rep6
%3b Combination of Patient Dev, Rep1 and Rep6 at Control

%4a Control Rep6ShortDev
%4b Patient Rep6ShortDev at Control sites

%5a Control Rep6LongDev
%5b Patient Rep6LongDev at Control sites

%6a Combination of Control Rep6, Short Dev, Long Dev
%6b Combination of Patient Rep6, Short Dev, Long Dev at Control

%Plot as many ERFs as there are significant clusters found
%Later, will plot Patient ERFs over control sites

cfg1              = []; % Control DevS, Patient DevS at Control 
cfg2              = []; % Patient DevS, Control DevS at Patient
cfg3              = []; % Control LongDevS, Patient LongDevS at Control negative cluster AND memory trace AND repetition effects
cfg4              = []; % Control LongDevS, Patient LongDevS at Control positive cluster

% 1: Channel Selection

cfg1.channel      = Control_DevS_Channels;
cfg2.channel      = Patient_DevS_Channels;
cfg3.channel      = Control_LongDevS_Neg_Channels;
cfg4.channel      = Control_LongDevS_Pos_Channels;

% 2: Significant time window overlay

% Information of each statistic, examined via ft_clusterplot excecuted earlier
% There is also Control_ShortDev_Rep and Control_LongDevShortDev, but these are p>0.05

C_DevS_Start          = 136;
C_DevS_End            = 256;
C_DevS_pVal           = 0.046;

P_DevS_Start          = 172;
P_DevS_End            = 188;
P_DevS_pVal           = 0.012;

C_LongDevS_Neg_Start  = 124;
C_LongDevS_Neg_End    = 204;
C_LongDevS_Neg_pVal   = 0.019;

C_LongDevS_Pos_Start  = 144;
C_LongDevS_Pos_End    = 240;
C_LongDevS_Pos_pVal   = 0.047;

% 3: Graph limits of ERFs and stimulus onset

TimeWindowToPlot  = [-50 325];
cfg1.xlim         = TimeWindowToPlot;
cfg2.xlim         = TimeWindowToPlot;
cfg3.xlim         = TimeWindowToPlot;
cfg4.xlim         = TimeWindowToPlot;

cfg1.ylim         = [-125 10];
cfg2.ylim         = [-150 80];
cfg3.ylim         = [-110 80];
cfg4.ylim         = [-50 200];

yCoordinatesOfWindow = [-1000 -1000 1000 1000]; % Just so it is well outside limits

% 4: Graph formating

cfg1.linewidth    = 2;
cfg2.linewidth    = 2;
cfg3.linewidth    = 2;
cfg4.linewidth    = 2;

% 5: Size of X/Y labels and axis
AxisSize  = 20;
LabelSize = 35;

% 6: Time window colour overlay
TimeColour = [0.6 0.6 0.6];

%% Finding peaks at deviant max

ControlChan    = [];
PatientChan    = [];
ControlChan_SD = [];
PatientChan_SD = [];

for i = 1:length(ControlChannelsNoLabels);
    ControlChan(i) = str2num(ControlChannelsNoLabels{i});
end

for i = 1:length(PatientChannelsNoLabels);
    PatientChan(i) = str2num(PatientChannelsNoLabels{i});
end
    
for i = 1:length(Control_DevS_Channels);
    ControlChan_SD(i) = str2num(Control_DevS_Channels{i});
end

for i = 1:length(Patient_DevS_Channels);
    PatientChan_SD(i) = str2num(Patient_DevS_Channels{i});
end

% Indexes of clusters - note, the same channel may have different indexes
% across groups due to inital faulty channels removed

for i = 1:length(ControlChan_SD)
    ControlChan_cSD_indexes(i) = find(ControlChan==ControlChan_SD(i));
end  

for i = 1:length(ControlChan_SD)
    PatientChan_cSD_indexes(i) = find(PatientChan==ControlChan_SD(i));
end

for i = 1:length(PatientChan_SD)
    if isempty(find(ControlChan==PatientChan_SD(i))) % Captures if in Patients but not Controls
    ControlChan_pSD_indexes(i) = 0;
    else
    ControlChan_pSD_indexes(i) = find(ControlChan==PatientChan_SD(i));
    end
end
ControlChan_pSD_indexes = ControlChan_pSD_indexes(ControlChan_pSD_indexes~=0);

for i = 1:length(PatientChan_SD)
    PatientChan_pSD_indexes(i) = find(PatientChan==PatientChan_SD(i));
end
    
Control_S  = squeeze(mean(MagGM_Control_S.individual));
Control_D  = squeeze(mean(MagGM_Control_Dev.individual));
Patient_S  = squeeze(mean(MagGM_Patient_S.individual));
Patient_D  = squeeze(mean(MagGM_Patient_Dev.individual));

% Control SD cluster

Control_S_cSD      = Control_S(ControlChan_cSD_indexes,:);
Control_D_cSD      = Control_D(ControlChan_cSD_indexes,:);
Patient_S_cSD      = Patient_S(PatientChan_cSD_indexes,:);
Patient_D_cSD      = Patient_D(PatientChan_cSD_indexes,:);

meanControl_S_cSD  = mean(Control_S_cSD);
meanControl_D_cSD  = mean(Control_D_cSD);
meanPatient_S_cSD  = mean(Patient_S_cSD);
meanPatient_D_cSD  = mean(Patient_D_cSD);

%                  ..... MMN amplitude at peak deviant

[v controli]       = max(abs(meanControl_D_cSD));
Control_D_Peak_cSD = round(time(controli));
Control_D_Peak_cSD = round(time(find(abs(meanControl_D_cSD)==max(abs(meanControl_D_cSD)))));
Control_D_Peak_cSD = round(time(controli));
ControlMMN_cSD     = Control_S_cSD(:,controli)-Control_D_cSD(:,controli);
meanControlMMN_cSD = mean(ControlMMN_cSD);
fprintf('Control mean MMN amplitude (cSD cluster) ~ %gfT\n',meanControlMMN_cSD);

[v patienti]       = max(abs(meanPatient_D_cSD));
Patient_D_Peak_cSD = round(time(patienti));
Patient_D_Peak_cSD = round(time(find(abs(meanPatient_D_cSD)==max(abs(meanPatient_D_cSD)))));
Patient_D_Peak_cSD = round(time(patienti));
PatientMMN_cSD     = Patient_S_cSD(:,patienti)-Patient_D_cSD(:,patienti);
meanPatientMMN_cSD = mean(PatientMMN_cSD);
fprintf('Patient mean MMN amplitude (cSD cluster) ~ %gfT\n',meanPatientMMN_cSD);

figure;
plot(time,meanControl_S_cSD,'LineWidth',2); hold on; plot(time,meanControl_D_cSD,'LineWidth',2,'Color','r');
set(gca,'XLim',[-50 300],'YLim',[-125 10],'TickLength',[0 0],'FontSize',10);
plot(Control_D_Peak_cSD*[1 1],[meanControl_S_cSD(controli) meanControl_D_cSD(controli)],'LineWidth',2,'Color','k');

figure;
plot(time,meanPatient_S_cSD,'LineWidth',2); hold on; plot(time,meanPatient_D_cSD,'LineWidth',2,'Color','r');
set(gca,'XLim',[-50 300],'YLim',[-125 10],'TickLength',[0 0],'FontSize',10);
plot(Patient_D_Peak_cSD*[1 1],[meanPatient_S_cSD(patienti) meanPatient_D_cSD(patienti)],'LineWidth',2,'Color','k');

% Patient SD cluster

Control_S_pSD      = Control_S(ControlChan_pSD_indexes,:);
Control_D_pSD      = Control_D(ControlChan_pSD_indexes,:);
Patient_S_pSD      = Patient_S(PatientChan_pSD_indexes,:);
Patient_D_pSD      = Patient_D(PatientChan_pSD_indexes,:);

meanControl_S_pSD  = mean(Control_S_pSD);
meanControl_D_pSD  = mean(Control_D_pSD);
meanPatient_S_pSD  = mean(Patient_S_pSD);
meanPatient_D_pSD  = mean(Patient_D_pSD);

%                  ..... MMN amplitude at peak deviant

[v controli]       = max(abs(meanControl_D_pSD));
Control_D_Peak_pSD = round(time(controli));
ControlMMN_pSD     = Control_D_pSD(:,controli)-Control_S_pSD(:,controli);
meanControlMMN_pSD = mean(ControlMMN_pSD);
fprintf('Control mean MMN amplitude (pSD cluster) ~ %gfT\n',meanControlMMN_pSD);

% note, had to manually find the peak
patienti               = 147;
Patient_D_Peak_pSD     = round(time(patienti));
PatientMMN_pSD         = Patient_D_pSD(:,patienti)-Patient_S_pSD(:,patienti);
meanPatientMMN_pSD     = mean(PatientMMN_pSD);
fprintf('Patient mean MMN amplitude (pSD cluster) ~ %gfT\n',meanPatientMMN_pSD);

figure;
plot(time,meanPatient_S_pSD,'LineWidth',2); hold on; plot(time,meanPatient_D_pSD,'LineWidth',2,'Color','r');
set(gca,'XLim',[-50 300],'YLim',[-140 80],'TickLength',[0 0],'FontSize',10);
plot(Patient_D_Peak_pSD*[1 1],[meanPatient_S_pSD(patienti) meanPatient_D_pSD(patienti)],'LineWidth',2,'Color','k');

figure;
plot(time,meanControl_S_pSD,'LineWidth',2); hold on; plot(time,meanControl_D_pSD,'LineWidth',2,'Color','r');
set(gca,'XLim',[-50 300],'YLim',[-140 80],'TickLength',[0 0],'FontSize',10);
plot(Control_D_Peak_pSD*[1 1],[meanControl_S_pSD(controli) meanControl_D_pSD(controli)],'LineWidth',2,'Color','k');

% Statistics on the MMN

%figure; % plotting all MMNs for all channels - shows similar mean but more dispersed for patients, thus SD higher
%plot(1:length(ControlMMN_cSD),sort(ControlMMN_cSD),'LineWidth',2); hold on; 
%plot(1:length(PatientMMN_cSD),sort(PatientMMN_cSD),'LineWidth',2,'Color','c');
%set(gca,'TickLength',[0 0]);

ControlMMN_cSD; PatientMMN_cSD; % MMN amplitude for each channel
p_cSD          = ranksum(ControlMMN_cSD,PatientMMN_cSD);
fprintf('At control SD cluster, non-parametric group differences p = %g\n',p_cSD);
ControlMMN_pSD; PatientMMN_pSD;
p_pSD          = ranksum(ControlMMN_pSD,PatientMMN_pSD);
fprintf('At patient SD cluster, non-parametric group differences p = %g\n',p_pSD);

% Control SD cluster
meanMMN_cSD = [meanControlMMN_cSD meanPatientMMN_cSD];
figure;
bar(1:length(meanMMN_cSD),meanMMN_cSD);
title(sprintf('Control versus ZDHHC9 MMN - at peak deviant (Control SD cluster): p=%0.5g', p_cSD),'FontSize',28);
set(gca,'XLim',[0 3],'TickLength',[0 0],'XTickLabel',{'Control','ZDHHC9'},'FontSize',24);
ylabel('MMN amplitude (fT) at peak deviant latency');

% Patient SD cluster
meanMMN_pSD = [meanControlMMN_pSD meanPatientMMN_pSD];
figure;
bar(1:length(meanMMN_pSD),meanMMN_pSD);
title(sprintf('Control versus ZDHHC9 MMN - at peak deviant (Patient SD cluster): p=%0.5g', p_pSD),'FontSize',28);
set(gca,'XLim',[0 3],'TickLength',[0 0],'XTickLabel',{'Control','ZDHHC9'},'FontSize',24);
ylabel('MMN amplitude (fT) at peak deviant latency');

%% More sophisticated... running a McCarthy-Wood 1988 statistical test
%  Look this up again.... want to so a subject by channel anova

C_DevS_Start;
C_DevS_End;
TimeWindow_cSD_i = [find(round(time)==C_DevS_Start):1:find(round(time)==C_DevS_End)];
P_DevS_Start;
P_DevS_End;
TimeWindow_pSD_i = [find(round(time)==P_DevS_Start):1:find(round(time)==P_DevS_End)];

% Extract all data for the time windows...
MagGM_Control_S.individual;
MagGM_Control_Dev.individual;
MagGM_Patient_S.individual;
MagGM_Patient_Dev.individual;

% Channel indexes into clusters
ControlChan_cSD_indexes;
PatientChan_cSD_indexes;
ControlChan_pSD_indexes;
PatientChan_pSD_indexes;

% Index into specific clusters
% ----- Control SD cluster
Control_S_cSD = MagGM_Control_S.individual(:,ControlChan_cSD_indexes,:);
Control_D_cSD = MagGM_Control_Dev.individual(:,ControlChan_cSD_indexes,:);
Patient_S_cSD = MagGM_Patient_S.individual(:,PatientChan_cSD_indexes,:);
Patient_D_cSD = MagGM_Patient_Dev.individual(:,PatientChan_cSD_indexes,:);
% ----- mean activation over window for all subject (Control SD cluster)
Subject_Control_S_cSD   = squeeze(mean(Control_S_cSD,2));
Subject_Control_D_cSD   = squeeze(mean(Control_D_cSD,2));
Subject_Control_MMN_cSD = Subject_Control_D_cSD - Subject_Control_S_cSD;
Subject_Patient_S_cSD   = squeeze(mean(Patient_S_cSD,2));
Subject_Patient_D_cSD   = squeeze(mean(Patient_D_cSD,2));
Subject_Patient_MMN_cSD = Subject_Patient_D_cSD - Subject_Patient_S_cSD;

% ----- Patient SD cluster
Control_S_pSD = MagGM_Control_S.individual(:,ControlChan_pSD_indexes,:);
Control_D_pSD = MagGM_Control_Dev.individual(:,ControlChan_pSD_indexes,:);
Patient_S_pSD = MagGM_Patient_S.individual(:,PatientChan_pSD_indexes,:);
Patient_D_pSD = MagGM_Patient_Dev.individual(:,PatientChan_pSD_indexes,:);
% ----- mean activation over window for all subject (Patient SD cluster)
Subject_Control_S_pSD   = squeeze(mean(Control_S_pSD,2));
Subject_Control_D_pSD   = squeeze(mean(Control_D_pSD,2));
Subject_Control_MMN_pSD = Subject_Control_D_pSD - Subject_Control_S_pSD;
Subject_Patient_S_pSD   = squeeze(mean(Patient_S_pSD,2));
Subject_Patient_D_pSD   = squeeze(mean(Patient_D_pSD,2));
Subject_Patient_MMN_pSD = Subject_Patient_D_pSD - Subject_Patient_S_pSD;

% Index into the correct time window
Subject_Control_MMN_cSD = Subject_Control_MMN_cSD(:,TimeWindow_cSD_i);
Subject_Patient_MMN_cSD = Subject_Patient_MMN_cSD(:,TimeWindow_cSD_i);
Subject_Control_MMN_pSD = Subject_Control_MMN_pSD(:,TimeWindow_pSD_i);
Subject_Patient_MMN_pSD = Subject_Patient_MMN_pSD(:,TimeWindow_pSD_i);

% Then normalise within subject
ToLoop  = {Subject_Control_MMN_cSD, Subject_Patient_MMN_cSD,...
          Subject_Control_MMN_pSD, Subject_Patient_MMN_pSD};
Outputs = {};
for i = 1:length(ToLoop);
    x   = ToLoop{i};
    y   = sort(abs(x),2);
    max = y(:,end);
    for j = 1:size(x,1)
        x(j,:) = x(j,:)/max(j); %in subject normalisation
    end
    Outputs{i} = x;
end

%% Main ERF Computations
%% 1. Control S Dev

%  [136 256]

% Control

figure;

ft_singleplotER(cfg1,MagGM_Control_S,MagGM_Control_Dev);

legend('Preceding stimulus','Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_DevS_Start C_DevS_End C_DevS_End C_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

% Patient

figure;

ft_singleplotER(cfg1,MagGM_Patient_S, MagGM_Patient_Dev);

legend('Preceding stimulus','Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_DevS_Start C_DevS_End C_DevS_End C_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

%% 2. Patient S Dev

%     [172 188]
%  Note that Patient_DevS_Channels 1731 is not within controls - so will remove

% Patient

figure;

ft_singleplotER(cfg2,MagGM_Patient_S,MagGM_Patient_Dev);

legend('Preceding stimulus','Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([P_DevS_Start P_DevS_End P_DevS_End P_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

% Control

figure;

ft_singleplotER(cfg2,MagGM_Control_S, MagGM_Control_Dev);

legend('Preceding stimulus','Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([P_DevS_Start P_DevS_End P_DevS_End P_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

%% 3. S LongDev

%  1. Negative Cluster: Memory Trace Effect
%  2. Positive Cluster: Memory Trace Effect

% Control negative: Memory trace effect S,sD,lD

figure;

ft_singleplotER(cfg3,MagGM_Control_S, MagGM_Control_ShortDev, MagGM_Control_LongDev);

legend('Preceding stimulus','Short Deviant','Long Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_LongDevS_Neg_Start C_LongDevS_Neg_End C_LongDevS_Neg_End C_LongDevS_Neg_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

% Patient at negative: Memory trace effect S,sD,lD

figure;

ft_singleplotER(cfg3,MagGM_Patient_S, MagGM_Patient_ShortDev, MagGM_Patient_LongDev);

legend('Preceding stimulus','Short Deviant','Long Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_LongDevS_Neg_Start C_LongDevS_Neg_End C_LongDevS_Neg_End C_LongDevS_Neg_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

% Control positive

figure;

ft_singleplotER(cfg4,MagGM_Control_S, MagGM_Control_ShortDev, MagGM_Control_LongDev);

legend('Preceding stimulus','Short Deviant','Long Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_LongDevS_Pos_Start C_LongDevS_Pos_End C_LongDevS_Pos_End C_LongDevS_Pos_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

% Patient positive

figure;

ft_singleplotER(cfg4,MagGM_Patient_S, MagGM_Patient_ShortDev, MagGM_Patient_LongDev);

legend('Preceding stimulus','Short Deviant','Long Deviant','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_LongDevS_Pos_Start C_LongDevS_Pos_End C_LongDevS_Pos_End C_LongDevS_Pos_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

%% 4. Repetition Effects at S-D cluster

%  Control - cfg1
cfg1.ylim = [-120 30]; 
%  Patient - cfg2
cfg2.ylim = [-220 60];

%  But we will need to edit the y axis for these

% Control sites

figure;

ft_singleplotER(cfg1,MagGM_Control_ShortReps, MagGM_Control_LongReps);

legend('Short Repetition','Long Repetition','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_DevS_Start C_DevS_End C_DevS_End C_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

figure;

ft_singleplotER(cfg1,MagGM_Patient_ShortReps, MagGM_Patient_LongReps);

legend('Short Repetition','Long Repetition','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([C_DevS_Start C_DevS_End C_DevS_End C_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

% Patient sites

figure;

ft_singleplotER(cfg2,MagGM_Patient_ShortReps, MagGM_Patient_LongReps);

legend('Short Repetition','Long Repetition','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([P_DevS_Start P_DevS_End P_DevS_End P_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

figure;

ft_singleplotER(cfg2,MagGM_Control_ShortReps, MagGM_Control_LongReps);

legend('Short Repetition','Long Repetition','FontSize',AxisSize);
xlabel('Time (ms)','FontSize',LabelSize);
ylabel('Magnetic field distribution (fT)','FontSize',LabelSize);

hold on

plot([0 0],ylim,'--k');
% text(0,0,'   Stimulus Onset');
p1 = patch([P_DevS_Start P_DevS_End P_DevS_End P_DevS_Start],yCoordinatesOfWindow,'black');
set(p1,'FaceColor',TimeColour,'FaceAlpha', 0.15,'LineStyle','none');

set(gca,'TickLength',[0 0],'FontSize',AxisSize);

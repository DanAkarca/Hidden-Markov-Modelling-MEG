%% Source level analysis: Permutation testing of transition and temporal outputs
%  Danyal Akarca, MPhil Candidate in Basic and Translational Neuroscience
%%
% This script does the following:
% 1. Randomly shuffles your data in a single vector
% 2. Selects items 1-7 and 8-15 to make two groups
% 3. Calculates the mean difference between these two groups
% 4. Does this over n repetitions to create a null distribution of mean difference if no true group membership exists
% 5. Calculates the p-value of getting your actual group difference given this null distribution
% 6. Plots a histogram of the results

%%%% Put your data in here, set up the permutation and the histogram settings------------------------------------------------------

clear controls
clear cases
clear data

% This is data for your real control group and real cases
% e.g. Fractional occupancy - State 1
controls   = [8.4666	20.6	23.754	17.897	24.53	19.427	19.524];
cases      = [26.633	16.644	23.915	8.8408	5.7667	25.018	13.311	25.319];

% The real mean difference between the groups - note you can make this a
% t-statistic/any other statistic if you prefer:
sampStat = mean(controls)-mean(cases); 

% Create a single vector of all your datapoints, without group membership
data = [controls,cases];

% Permutation settings
nRepetitions = 10000;
alpha = .05
permuteddiff = zeros(nRepetitions,1);

%Histogram settings
nBins = 50;

%%%% Steps 1-4: This randomly permutes the integers 1-15, shuffles the data in this order,-----------------------------------------------
% pulls out two randomly permuted groups of data1 and data2, and calculates
% the mean difference between these groups. This happens over n repetitions 
% to create the null distribution. 
for i=1:nRepetitions
    permuted = randperm(15);
    data1 = data(permuted(:,1:7));
    data2 = data(permuted(:,8:15));
    permuteddiff(i) = mean(data1)-mean(data2);
end

%%%% Step 5: Calculate the 95% CI and p-value of obtaining your actual group difference from the null distribution-------------------------
% Calculate 95% confidence interval - 2.5% left on either tail
CI = prctile(permuteddiff,[100*(alpha/2),100*(1-alpha/2)]);

H = CI(1)>0 | CI(2)<0;

% Calculate standard deviation, mean, and z-scores of permuted distribution
sd = std(permuteddiff);
pdmean = mean(permuteddiff);
zscore = ((sampStat-pdmean)/sd); %note this is same as matlab's z

% Calculate p-values
%NOTE that the ci - confidence interval - values here don't seem to be
%consistently correct, so this needs to be corrected/understood.
[h,p,ci,zval] = ztest(sampStat,pdmean,sd)


%%%% Step 6: Plot the histogram-----------------------------------------------------------------------------------------------------------
figure
hist(permuteddiff,nBins);
ylim = get(gca,'YLim');
hold on
h1=plot(sampStat*[1,1],ylim,'y-','LineWidth',2); %y is yellow, r is red, etc.
h2=plot(CI(1)*[1,1],ylim,'r-','LineWidth',2);
plot(CI(2)*[1,1],ylim,'r-','LineWidth',2);
xlabel('Difference between means');

title(sprintf('Actual observed difference between groups: %5.5f',sampStat));
legend([h1,h2],{'Sample mean',sprintf('95 percent CI',100*alpha)},'Location','NorthWest');

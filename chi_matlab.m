clc;
clear;
interval = 3;
close all;

%bins = 1:interval:200;
bins = 0:5:200;
ll = length(bins);
filename = 'data_chi_1000.csv';
data = csvread(filename, 1,0);
x = data(:,2);
obsCounts = hist(x,ll);
n = sum(obsCounts);
pd = fitdist(bins', 'Poisson', 'Frequency', obsCounts);
%scale  = max(obsCounts)/max(expCounts);
expCounts = n*pdf(pd,bins);
scale  = max(obsCounts)/max(expCounts);
expCounts = scale*expCounts;


%%
[h, p, st] = chi2gof(bins, 'Ctrs', bins, ...
    'Frequency', obsCounts, ...
    'Expected', expCounts, ...
    'Nparams', 1)

hold on; 
hist(x,ll);
plot(bins, expCounts, 'g-');
plot(bins, obsCounts, 'r-'); 
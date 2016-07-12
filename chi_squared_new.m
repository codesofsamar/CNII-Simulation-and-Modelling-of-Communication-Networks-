clc;
clear;
bins = 1:20;
filename = 'data_chi_1000.csv';
data = csvread(filename, 1,0);
x = data(:,2);
[obsCounts,bin] = hist(x,20);
n = sum(obsCounts)
pd = fitdist(ceil(bin)', 'Poisson', 'Frequency', obsCounts)
%pd = fitdist(bins', 'Poisson', 'Frequency', obsCounts');
expCounts = 990*pdf(pd,ceil(bin));
m_e = mean(expCounts);

plot(expCounts,'g-'); hold on; plot(obsCounts,'r-');
hist(x,bin);
hold off;
%o_e = sum(((obsCounts - m_e).^2));
%X_squared = o_e/m_e
o_e = ((obsCounts - expCounts).^2)./expCounts;
sum(o_e)
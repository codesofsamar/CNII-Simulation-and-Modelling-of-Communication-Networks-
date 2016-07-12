
y_m = zeros([1 3]);
conf = zeros([1 3]);

M = length(data); % no. of elements in the dataset
y_m(1) = mean(data);
S_squared(1) = (sum((data - y_m(1)).^2))/(M-1);filename = 'sim410s-1.csv';
data = csvread(filename, 1,0);
z = 1.96;
conf(1) = z*sqrt(S_squared(1))/sqrt(M);

%%
filename = 'sim4_100-1.csv';
clear data;
data = csvread(filename, 1,0);
M = length(data); % no. of elements in the dataset
y_m(2) = mean(data);
S_squared(2) = (sum((data - y_m(2)).^2))/(M-1);
z = 1.96;
conf(2) = z*sqrt(S_squared(2))/sqrt(M);

%%
filename = 'sim1000-1.csv';
clear data;
data = csvread(filename, 1,0);
M = length(data); % no. of elements in the dataset
y_m(3) = mean(data);
S_squared(3) = (sum((data - y_m(3)).^2))/(M-1);
z = 1.96;
conf(3) = z*sqrt(S_squared(3))/sqrt(M);



errorbar(y_m,conf)

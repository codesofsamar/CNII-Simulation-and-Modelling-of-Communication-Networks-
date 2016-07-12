% [H(sim) P(sim) STATS] = chi2gof(X,'cdf',@(z)poisscdf(z,10));

filename = 'data_chi_1000.csv';
data = csvread(filename, 1,0);
x = data(:,2);
bin = 1:50;
observed = hist(x,20);
Expected_mean = mean(observed);
o_e = (observed-Expected_mean).^2;
x_squared = sum(o_e)/Expected_mean


%[H P STATS] = chi2gof(data(:,2),'cdf',@(z)poisscdf(z,10))

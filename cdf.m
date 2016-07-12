mu = 0;
sigma = 1;
pd = makedist('Normal', mu, sigma);
x = -20:1:20;
y = cdf(pd,x);


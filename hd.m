msgCount = 500000;

p = 0.75;
var1 = 1;
var2 = 1;
var3 = 1;

covar1 = 0.3;
covar2 = 0.4;
covar3 = 0.6;

sigma = [var1, covar1, covar2;
        covar1, var2, covar3;
        covar2, covar3, var3];

nrcv = 3;
rho = [1 0.5 0.5; 0.5 1 0.5; 0.5 0.5 1];
for i = 1:nrcv
    for j = 1:nrcv
        if i ~= j
            sigma(i, j) = rho(i, j) * sigma(i, i) * sigma(j, j);
        end
    end
end
w = 2 * (rho(1,2)^2 + rho(1,3)^2 + rho(2,3)^2 - 2*rho(1,2)*rho(1,3)*rho(2,3) - 1);
a = [rho(2,3)^2-1, rho(1,3)^2-1, rho(1,2)^2-1, rho(1,2)-rho(1,3)*rho(2,3), rho(1,3)-rho(1,2)*rho(2,3), rho(2,3) - rho(1,2)*rho(1,3)];

N = mvnrnd([0 0 0], sigma, msgCount);
n1 = N(:,1);
n2 = N(:,2);
n3 = N(:,3);

sigmaInv = sigma';
s = zeros(msgCount, 1);
R = zeros(msgCount, nrcv);
m_hat = zeros(msgCount, 1);
pe = zeros(1, 150);
count = 1;
for E = 0.1:0.1:15.0
    m = rand(1,msgCount) < p;
    
    s = (-1).^m*sqrt(E);
    
    S = [s;s;s;]';
    
    R = S + N;

    threshold = (1-p)/p;
    
    likely = mvnpdf( R+sqrt(E), zeros(1,3), sigma) ./ mvnpdf(R-sqrt(E), zeros(1,3), sigma);
  
    mhat = likely >= threshold;
    
    mhat = mhat';
    
    correct = (mhat == m);
    
    percentError = size(correct(correct==0))/msgCount;
    
    pe(count) = percentError(2);
    
    count = count + 1;
    
end

E = 0.1:0.1:15.0;
plot(E,log10(pe))
grid on
xlabel('The signal energy E')
ylabel('log of the probability of error')
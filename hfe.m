msgCount = 500000;

p = 0.5;
var1 = 1;
var2 = 2;
var3 = 4;

covar1 = 0.3;
covar2 = 0.4;
covar3 = 0.6;

sigma = [var1, covar1, covar2;
        covar1, var2, covar3;
        covar2, covar3, var3];

nrcv = 3;

N = mvnrnd(zeros(1,3), sigma, msgCount);
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
    
    r1 = s + n1';
    r2 = s + n2';
    r3 = s + n3';

    %threshold = (1-p)/p;
    
    %likely = mvnpdf( R+sqrt(E), zeros(1,3), sigma) ./ mvnpdf(R-sqrt(E), zeros(1,3), sigma);
  
    mhat = r1 + r2 + r3 < 0;
    
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
msgCount = 500000;

p = 0.75;

var1 = 1;
var2 = 1;
var3 = 1;

pe = zeros(1, 150);
pe2 = zeros(1, 150);
count = 1;
for E = 0.1:0.1:15.0
   m = rand(1,msgCount) < p;
   
   n1 = GaussianRandom(var1, msgCount);
   n2 = GaussianRandom(var2, msgCount);
   n3 = GaussianRandom(var3, msgCount);
   
   s = (-1).^m*sqrt(E);
   
   r1 = s + n1;
   r2 = s + n2;
   r3 = s + n3;
   
   threshold = 0;
   
   thresholdOptimum1 = -0.5*var1*log((1-p)/p)/sqrt(E);
   thresholdOptimum2 = -0.5*var2*log((1-p)/p)/sqrt(E);
   thresholdOptimum3 = -0.5*var3*log((1-p)/p)/sqrt(E);
   
   output = r1 + r2 + r3 < threshold;
   
   outputOptimum1 = r1 < threshold1;  
   outputOptimum2 = r2 < threshold2;
   outputOptimum3 = r3 < threshold3;
   
   sumOutput = outputOptimum1 + outputOptimum2 + outputOptimum3;
   outputOptimum = sumOutput > 1;
   
   mhat = output;
   mhatOptimum = outputOptimum;
   
   correct = (mhat == m);
   correct2 = (mhatOptimum == m);
   percentError = size(correct(correct==0))/msgCount;
   percentError2 = size(correct2(correct2==0))/msgCount;
   
   pe(count) = percentError(2);
   pe2(count) = percentError2(2);
   count = count + 1;
end
E = 0.1:0.1:15.0;
plot(E,log(pe),E,log(pe2))
xlabel('The signal energy E')
ylabel('The probability of error')
legend('Optimum Decision','Arbitrary Decision')
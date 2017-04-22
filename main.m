msgCount = 500000;

p = 0.5;
var1 = 1;
var2 = 1;
var3 = 1;

pe = zeros(1, 150);
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
   
   threshold1 = -0.5*var1*log((1-p)/p)/sqrt(E);
   threshold2 = -0.5*var2*log((1-p)/p)/sqrt(E);
   threshold3 = -0.5*var3*log((1-p)/p)/sqrt(E);
   
   output1 = r1 < threshold1;  
   output2 = r2 < threshold2;
   output3 = r3 < threshold3;
   
   sumOutput = output1 + output2 + output3;
   mhat = sumOutput > 1;
   
   correct = (mhat == m);
   percentError = size(correct(correct==0))/msgCount;
   pe(count) = percentError(2);
   count = count + 1;
end
E = 0.1:0.1:15.0;
plot(E,log(pe))
xlabel('The signal energy E')
ylabel('log of the probability of error')

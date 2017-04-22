msgCount = 500000;

p = 0.5;
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
   
   output = r1 + r2 + r3 < 0;
   output2 = r1 < 0;
   
   mhat = output;
   mhat2 = output2;
   
   correct = (mhat == m);
   percentError = size(correct(correct==0))/msgCount;
   
   correct2 = (mhat2 == m);
   percentError2 = size(correct2(correct2==0))/msgCount;
   
   pe(count) = percentError(2);
   pe2(count) = percentError2(2);
   count = count + 1;
end
E = 0.1:0.1:15.0;
plot(E,pe,E,pe2)
xlabel('The signal energy E')
ylabel('The probability of error')
legend('Base on r1, r2, r3','Base on only r1')
E = 0.1:0.1:15.0;
plot(E,log10(fc),E,log10(fd))
grid on
xlabel('The signal energy E')
ylabel('The Probability of error')
legend('P(m0) = P(m1), var1=var2=var3=1','P(m0) = ¼ P(m1) = ¾  , var1=var2=var3=1')
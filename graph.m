E = 0.1:0.1:15.0;
plot(E,log(pc),E,log(pd),E,log(ppe))
xlabel('The signal energy E')
ylabel('The probability of error')
legend('C','D','E')
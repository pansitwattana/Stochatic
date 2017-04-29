E = 0.1:0.1:15.0;
plot(E,log10(hfe),E,log10(he))
grid on
xlabel('The signal energy E')
ylabel('The Probability of error')
legend('Arbitrary Decision','Optimum Decistion')
trajectory= smoothedData_B_18_135


[h1c, h1e]= histcounts(trajectory(5,:)/187.5, 25, 'Normalization', 'probability')
plot(conv(h1e, [0.5 0.5], 'valid'), smooth(h1c*10000/8999,'lowess'), 'r', 'Linewidth', 2)
legend('0g')
xlabel('Height Above Fan, m');
ylabel('Normalised Time Spent at Height');
xlim([0 2])
ylim([0 0.25])

hold on

[h2c, h2e]= histcounts(trajectory(6,:)/187.5, 25, 'Normalization', 'probability')
plot(conv(h2e, [0.5 0.5], 'valid'), smooth(h2c*10000/8999,'lowess'), 'g', 'Linewidth', 2)
legend('0g')

[h3c, h3e]= histcounts(trajectory(7,:)/187.5, 25, 'Normalization', 'probability')
plot(conv(h3e, [0.5 0.5], 'valid'), smooth(h3c*10000/8999,'lowess'), 'b', 'Linewidth', 2)
legend('5g')

% [h4c, h4e]= histcounts(trajectory(8,:)/187.5, 25, 'Normalization', 'probability')
% plot(conv(h4e, [0.5 0.5], 'valid'), smooth(h4c*10000/8999,'lowess'), 'm')
% legend('0g')


hold off

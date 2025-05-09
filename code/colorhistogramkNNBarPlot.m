% Data from the table
k_values = [2, 3, 7, 9]; % Values of k
accuracy = [29.8, 32.5, 32.3, 31.3]; % Corresponding accuracy values


k_values_categorical = categorical(k_values);

% Create a bar plot
figure;
bar(k_values_categorical, accuracy, 'FaceColor', [0.2, 0.6, 0.8]);

% Add labels and title
xlabel('Value of k');
ylabel('Accuracy (%)');

grid on;

for i = 1:length(k_values)
    text(i, accuracy(i) + 0.2, sprintf('%.1f%%', accuracy(i)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

ylim([25, 35]);
%% Function to generate bar plots for each category size and combine them as subplots


category_sizes = [25, 50, 100]; % Number of training images per category
image_sizes = {'16x16', '10x10', '8x8'}; % Tiny image resolutions
k_values = [1, 5, 10]; % k values tested

% Accuracy data for each combination
% Organized as [category_size x image_size x k_value]
accuracy_data = [
    % 25 images per category
    26.7, 28.0, 30.7; % 8x8
    26.7, 26.7, 30.7; % 10x10
    25.6, 24.5, 28.5; % 16x16

    % 50 images per category
    31.7, 29.2, 30.9; % 8x8
    31.3, 28.9, 30.1; % 10x10
    28.8, 27.9, 29.6; % 16x16

    % 100 images per category
    32.6, 33.3, 33.1; % 8x8
    32.6, 32.6, 32.3; % 10x10
    31.0, 30.7, 29.7; % 16x16
];

% Reshape the accuracy data into a 3D matrix (category_size x image_size x k_value)
accuracy_data = reshape(accuracy_data, [length(category_sizes), length(image_sizes), length(k_values)]);

% Create a figure to hold all subplots
figure;

% Loop through each category size and create a subplot
for i = 1:length(category_sizes)

    subplot(1, 3, i);
    

    data = squeeze(accuracy_data(i, :, :));
    

    bar(data, 'grouped');
    

    title(['Category Size: ' num2str(category_sizes(i))]);
    xlabel('Image Size');
    ylabel('Accuracy (%)');
    xticklabels(image_sizes);
    legend('k=1', 'k=5', 'k=10', 'Location', 'best');
    grid on;
    
    % Set y-axis limits for consistency
    ylim([24, 34]); 
end

% Adjust the figure layout
sgtitle('Classification Accuracy for Different Category Sizes');
function predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats)
    % k-NN classifier to predict the category of test images
    % Inputs:
    %   train_image_feats: N x 256 matrix of training image features (flattened)
    %   train_labels: N x 1 cell array of labels for training images
    %   test_image_feats: M x 256 matrix of test image features (flattened)
    %   k: number of nearest neighbors to consider
    % Output:
    %   predicted_categories: M x 1 cell array of predicted labels for test images

    k = 5;
    
    num_test_images = size(test_image_feats, 1); 
    predicted_categories = cell(num_test_images, 1); 

    % Loop over each test image
    for i = 1:num_test_images
        test_image = test_image_feats(i, :); 

        % Calculate Euclidean distance between the test image and all training images
        distances = zeros(size(train_image_feats, 1), 1);
        for j = 1:size(train_image_feats, 1)
            % Calculate euclidean distance -> sqrt(sum((Image1 - Image2).^2))
            distances(j) = sqrt(sum((test_image - train_image_feats(j, :)).^2));
        end

        % Find the k-nearest neighbors (smallest distances)
        [~, sorted_indices] = sort(distances, 'ascend'); % Sort distances in ascending order
        nearest_neighbors = sorted_indices(1:k); % Get indices of k nearest neighbors

        % Predict the label using majority voting
        neighbor_labels = train_labels(nearest_neighbors); 
        predicted_categories{i} = majority_vote(neighbor_labels); 
    end
end

% Function to find the most frequent label (majority voting)
function predicted_label = majority_vote(neighbor_labels)

    % Identify most common label among the k-nearest neighbors
    unique_labels = unique(neighbor_labels);
    count = zeros(length(unique_labels), 1); 

    % Count occurrences of each unique label
    for i = 1:length(unique_labels)
        count(i) = sum(strcmp(neighbor_labels, unique_labels{i})); 
    end

    % Return the label with the highest count
    [~, max_idx] = max(count); 
    predicted_label = unique_labels{max_idx}; 
end

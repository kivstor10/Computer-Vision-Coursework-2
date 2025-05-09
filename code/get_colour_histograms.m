function image_feats = get_colour_histograms(image_paths)
    % image_paths: list of image paths (cell array)
    % image_feats: feature matrix with size N x (num_bins^3), N = num images

    % settings to tweak for experimentation
    num_bins = 8;         % bins per channel, e.g. 8, 16, 32, etc
    normalise_hist = true; % normalise (yes=true, no=false)
    color_space = 'rgb';   % colorspace set to 'rgb'

    num_images = length(image_paths); % amount of images in image_paths
    num_features = num_bins^3; % length of feature vector
    image_feats = zeros(num_images, num_features); % preallocate space for features

    % start timer
    tic;

    for i = 1:num_images
        % read image from path
        img = imread(image_paths{i});
        
        % convert to the chosen colour space
        switch lower(color_space)
            case 'hsv'
                img = rgb2hsv(img); % convert to hsv
            case 'rgb'
                img = double(img) / 255; % normalise rgb to [0,1]
            otherwise
                error('colorspace not supported');
        end
        
        % quantise the image to the number of bins set
        imquant = round(img * (num_bins - 1)) + 1;
        
        % initialise the histogram
        hh = zeros(num_bins, num_bins, num_bins);

        % fill up the histogram
        [dim1, dim2, ~] = size(imquant);
        for x = 1:dim1
            for y = 1:dim2
                R = imquant(x, y, 1); % red channel
                G = imquant(x, y, 2); % green channel
                B = imquant(x, y, 3); % blue channel
                hh(R, G, B) = hh(R, G, B) + 1; % increment the bin
            end
        end

        % flatten the histogram into a vector
        colourHistogram = hh(:)';

        % normalise histogram
        if normalise_hist
            colourHistogram = colourHistogram / sum(colourHistogram);
        end
        
        % store the feature vector in the matrix
        image_feats(i, :) = colourHistogram;
    end

    % stop timer
    elapsed_time = toc;

    % time taken printed
    fprintf('%d images in %.4f seconds (%.4f sec per image)\n', ...
        num_images, elapsed_time, elapsed_time / num_images);
end
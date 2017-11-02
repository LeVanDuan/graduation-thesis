function imageAfterPreprocess = preprocessingPhase(image, mask)
% Green channel
image = image(:, :, 2);
mask = logical(mask);
% Remove noise boudary apply to mask
image = mat2gray(image) .* mat2gray(mask);
% Assume vessels are lighter than background
image = imcomplement(image);
image = im2double(image); %???
% Step1: apply opening operation -> obtain the smoothed image.
[smoothedImage, imageOpenMatrix] = reconstructionOpeningOperation(image, lengthSE, numberDirection);
% Step2: apply the Top-Hat transform -> gray difference between the vessel
% and the background are increased.
imageTop_HatTransform = applyTop_HatTransformOperation(smoothedImage, imageOpenMatrix);
% Step3: apply Gaussian filter with 7 pixels in width on output of previous
% result -> more smoothed images
imageGaussianFilter = applyGaussianFilter(imageTop_HatTransform);
imageAfterPreprocess = imageGaussianFilter;

function imageAfterSegmentation = segmentationPhase(imageAfterPreprocess, mask)
% Step 1: Two class centers are initialized randomly; as initial group centroids
[r, c] = size (imageAfterPreprocess);
center1 = imageAfterPreprocess((c/20 - 1)*r + r/100); %[r/100,c/20];
center2 = imageAfterPreprocess((c/4 - 1)*r + r/2); %[r/2, c/4];
temp1 = 0;
group1 = 1;
imageAfterPreprocess(~mask) = 0;
while (isequal(temp1, group1))
    distance1 = abs(imageAfterPreprocess(mask) - center1);
    distance2 = abs(imageAfterPreprocess(mask) - center2);
    idx1 = distance1 < distance2;
    idx2 = distance1 >= distance2;
    temp1 = group1; % condition stop
    group1 = imageAfterPreprocess(idx1);
    group2 = imageAfterPreprocess(idx2);
    center1 = mean(group1);
    center2 = mean(group2);
end

%imageAfterSegmentation = imageAfterPreprocess;
if center1 < center2
    imageAfterSegmentation = ismember(imageAfterPreprocess, group2);
else
    imageAfterSegmentation = ismember(imageAfterPreprocess, group1);
end
imageAfterSegmentation = mat2gray(imageAfterSegmentation);
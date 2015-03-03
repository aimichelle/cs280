function [labels, features] = lfprocessnsparse(lab, feat)
pixeldim = size(feat, 1);
trainingsamples = size(feat, 3);
labelsvector = double(lab);
imagesvector = double(transpose(reshape(feat, [pixeldim*pixeldim, trainingsamples])));
labels = labelsvector;
features = imagesvector;
end
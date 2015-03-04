function appendblock = featureappender(sampset, c, cspace, type)
imagellabels = sampset.labels;
imagelset = sampset.images;
numsamples = size(imagelset, 3);
appendblock = zeros([numsamples, 169]);
for i = 1:size(imagelset, 3)
    appendblock(i,:) = blockwindow(imagelset(:,:,i), c, cspace, pixdim, type);
end 
function [labels, feats] = featlabappender(sampset, c, cspace, type)
samplabels = sampset.labels;
sampimages = sampset.images;
numsamples = size(sampimages, 3);
pixdim = size(sampimages, 1);
if strcmp(type, 'sum')
    appendblock = zeros([numsamples, (pixdim/c*2-1)^2]);
else
    appendblock = zeros([numsamples, 9*(pixdim/c*2-1)^2]);
end
for i = 1:numsamples
    if strcmp(type, 'sum')
        appendblock(i,:) = blockwindow(sampimages(:,:,i), c, cspace, pixdim, 'sum');
    else
        appendblock(i,:) = blockwindow(sampimages(:,:,i), c, cspace, pixdim, type);
    end
end
[currlabel, currfeat] = lfprocess(samplabels, sampimages);
if strcmp(type, 'sum')
    totalfeats = cat(2, currfeat, appendblock);    
    labels = currlabel;
    feats = totalfeats;
else
    labels = currlabel;
    feats = sparse(appendblock);
end

end
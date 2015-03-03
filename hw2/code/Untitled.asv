load('C:\Users\Alvin\Dropbox\School Stuff\CS280\hw2\test.mat');
load('C:\Users\Alvin\Dropbox\School Stuff\CS280\hw2\train_small.mat');
load('C:\Users\Alvin\Dropbox\School Stuff\CS280\hw2\train_large.mat');


%[lab, feat] = lfprocess(train_large.labels, train_large.images);
%model = train(lab, feat, '-q');

[testlab, testfeat] = lfprocess(test.labels, test.images);
percorrect = zeros([1, 7]);
for i = 1:7
    currset = train_diff{1, i};
    [currlabel, currfeat] = lfprocess(currset.labels, currset.images);
    model = train(currlabel, currfeat, '-q');
    [a, b, c] = predict(testlab, testfeat, model);
    percorrect(1,i) = b(1,1);
end


sizevec = [100,200,500,1000,2000,5000,10000];
errorrates = (100-[percorrect])/100;
scatter([sizevec], errorrates);
a = errorrates'; b = num2str(a); c = cellstr(b);
dx = 200; dy = 0.0035; % displacement so the text does not overlay the data points
text(sizevec+dx, errorrates+dy, c);
title('Linear SVM - Total Sum (c=4, c/2 spacing, cost -10)')
xlabel('Number of Training Samples')
ylabel('Error Rates')



%Running through all data-sets using sum of window
percorrect = zeros([1, 7]);
[tlabels, tfeats] = featlabappender(test, 7, 2, 'sum');
for i = 1:7
    currset = train_diff{1, i};
    [labels, feats] = featlabappender(currset, 7, 2, 'sum');
    model = train(labels, feats, '-q -c 10');
    [a, b, c] = predict(tlabels, tfeats, model);
    percorrect(1,i) = b(1,1);
end

%Running through all data-sets using histogram of window
percorrect = zeros([1, 7]);
[tlabels, tfeats] = featlabappender(test, 7, 2, 'histogram');
for i = 1:7
    currset = train_diff{1, i};
    [labels, feats] = featlabappender(currset, 7, 2, 'histogram');
    model = train(labels, feats, '-q -c 10');
    [a, b, c] = predict(tlabels, tfeats, model);
    percorrect(1,i) = b(1,1);
end

[labels, feats] = featlabappender(train_large, 4, 2, 'histogram');
model = train(labels, feats, '-q');
[a, b, c] = predict(tlabels, tfeats, model);
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

scatter([sizevec], (100-[percorrect])/100);
sizevec = [100,200,500,1000,2000,5000,10000];
    
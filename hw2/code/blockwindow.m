function imblocks = blockwindow(im, c, cspacing, pixdim, process)
spaceind = linspace(1, pixdim-c/cspacing+1, pixdim/c*cspacing);
imdouble = double(im);
retblock = [];

if strcmp(process, 'histogram')
    g1 = fspecial('gaussian', 9,1);  % Gaussian with sigma_d 
    img1 = conv2(imdouble,g1,'same');  % blur image with sigma_d
    Ix = conv2(img1,[-1 0 1],'same');  % take x derivative 
    Iy = conv2(img1,[-1;0;1],'same');  % take y derivative
    anglearray = zeros(size(Ix));
    magnitudearray = zeros(size(Ix));
    for i = 1:size(Ix,1)
        for j = 1:size(Ix,2)
            anglearray(i,j) = anglewrap(Ix(i,j), Iy(i,j));
            magnitudearray(i,j) = norm([Ix(i,j),Iy(i,j)]);
        end
    end
end


for i=1:size(spaceind, 2)
   for j=1:size(spaceind, 2)
       currspace = spaceind(1,i);
       row = currspace;
       col = currspace;
       if strcmp(process, 'sum')
           impiece = imdouble(row:row+c-1, col:col+c-1);
           currsum = sum(impiece(:));
           retblock = [retblock currsum];
       else
           impiece = anglearray(row:row+c-1, col:col+c-1);
           buckets = linspace(-pi, pi, 10);
           bincounts = histc(impiece, buckets);
           bincounts = normc(bincounts);
           retblock = [retblock transpose(bincounts)];
       end
   end
end

imblocks = retblock;
end
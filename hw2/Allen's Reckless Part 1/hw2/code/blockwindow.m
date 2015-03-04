function imblocks = blockwindow(im, c, cspacing, pixdim, process)
spaceind = linspace(1, pixdim-c+1, pixdim/c*cspacing-1);
imdouble = double(im);

if strcmp(process, 'histogram')
    g1 = fspecial('gaussian', 7,1);  % Gaussian with sigma_d 
    img1 = conv2(imdouble,g1,'same');  % blur image with sigma_d
    Ix = conv2(img1,[-1 0 1],'same');  % take x derivative 
    Iy = conv2(img1,[-1;0;1],'same');  % take y derivative
    %Ix = conv2(imdouble,[-1 0 1],'same');  % take x derivative 
    %Iy = conv2(imdouble,[-1;0;1],'same');  % take y derivative
    anglearray = zeros(size(Ix));
    magnitudearray = zeros(size(Ix));
    for i = 1:size(Ix,1)
        for j = 1:size(Ix,2)
            anglearray(i,j) = anglewrap(Ix(i,j), Iy(i,j));
            magnitudearray(i,j) = norm([Ix(i,j),Iy(i,j)]);
        end
    end
    fullshiftedanglearray = shift(anglearray, [0.5,0.5], 0);   
    colshiftedanglearray = shift(anglearray, [0,0.5], 0);   
    rowshiftedanglearray = shift(anglearray, [0.5,0], 0);   
end

numrowsandcols = size(spaceind, 2);
if strcmp(process, 'sum')
    retblock = zeros([1,numrowsandcols^2]);
else
    retblock = zeros([1,9*numrowsandcols^2]);
end


fullshiftedimdouble = shift(imdouble, [0.5,0.5], 0);
rowshiftedimdouble = shift(imdouble, [0.5,0], 0);
colshiftedimdouble = shift(imdouble, [0,0.5], 0);
for i=1:numrowsandcols
   row = spaceind(1,i);
   for j=1:numrowsandcols
       col = spaceind(1,j);
       if strcmp(process, 'sum')
           if mod(row, 1) == 0 && mod(col, 1) == 0
                impiece = imdouble(row:row+c-1, col:col+c-1);               
           elseif mod(row, 1) ~= 0 && mod(col, 1) ~= 0
                impiece = fullshiftedimdouble(floor(row):floor(row)+c-1, floor(col):floor(col)+c-1); 
           elseif mod(col, 1) ~= 0
                impiece = colshiftedimdouble(floor(row):floor(row)+c-1, floor(col):floor(col)+c-1);            
           else
                impiece = rowshiftedimdouble(floor(row):floor(row)+c-1, floor(col):floor(col)+c-1);                           
           end
           currsum = sum(impiece(:));
           retblock(1, numrowsandcols*(i-1) + j) = currsum;
       else
           if mod(row, 1) == 0 && mod(col, 1) == 0
                impiece = anglearray(row:row+c-1, col:col+c-1);
           elseif mod(row, 1) ~= 0 && mod(col, 1) ~= 0
                impiece = fullshiftedanglearray(floor(row):floor(row)+c-1, floor(col):floor(col)+c-1);
           elseif mod(col, 1) ~= 0
                impiece = colshiftedanglearray(floor(row):floor(row)+c-1, floor(col):floor(col)+c-1);
           else
                impiece = rowshiftedanglearray(floor(row):floor(row)+c-1, floor(col):floor(col)+c-1);
           end                      
           buckets = linspace(-pi, pi+0.0001, 10);
           bincounts = histc(impiece(:), buckets);
           bincounts = normc(bincounts(1:9,:));
           %bincounts = bincounts(1:9,:);
           curroffset = 9*(numrowsandcols*(i-1) + j-1)+1;
           retblock(1, curroffset:curroffset+8) = bincounts';
       end
   end
end

imblocks = retblock;
end
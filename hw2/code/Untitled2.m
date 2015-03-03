sizevec = [100,200,500,1000,2000,5000,10000];
errorrates = (100-[percorrect])/100;
scatter([sizevec], errorrates);
a = errorrates'; b = num2str(a); c = cellstr(b);
dx = 200; dy = 0.0035; % displacement so the text does not overlay the data points
text(sizevec+dx, errorrates+dy, c);
%title('Linear SVM - Total Sum (c=4, c/2 spacing, cost -10)')
%title('Linear SVM - Total Sum (c=7, c/2 spacing, cost -10)')
%title('Linear SVM - Histogram (c=4, c/2 spacing, tap, cost -10)')
%title('Linear SVM - Histogram (c=7, c/2 spacing, tap, cost -10)')
%title('Linear SVM - Histogram (c=4, c/2 spacing, Gauss width -7 sig -1, cost -10)')
%title('Linear SVM - Histogram (c=7, c/2 spacing, Gauss width -7 sig -1, cost -10)')
%title('Linear SVM - Histogram (c=4, c/2 spacing, tap, norm -0, cost -10)')
%title('Linear SVM - Histogram (c=7, c/2 spacing, tap, norm -0, cost -10)')

xlabel('Number of Training Samples')
ylabel('Error Rates')
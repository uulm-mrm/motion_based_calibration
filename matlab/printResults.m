function printResults(name, data)
% PRINTRESULTS  Print optimization results as table
% for multiple approaches.

nApproaches = size(data,1);

% m to cm
data(:,1) = data(:,1) * 100;
% sec to ms
data(:,3) = data(:,3) * 1000;

% define header names
rowHeaderDisplay = ["", "et[cm]", "er[deg]", "time[ms]"];
colHeaderDisplay = ["Matrix", "DQ Glob", "DQ Fast", "SVD"];

% print table
fprintf(2, [name,'\n']);
fprintf("%10s <strong> %7s  %7s  %7s</strong>\n", rowHeaderDisplay{:});
for i=1:nApproaches 
    fprintf("<strong>%10s</strong>  %7.2f  %7.3f  %7.2f\n", colHeaderDisplay{i}, data(i,:));
end
fprintf('\n');

end

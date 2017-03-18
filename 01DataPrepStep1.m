
x = csvread("All.csv");
[m, n] = size(x);

y = [];
x_z = [];
x_z_norm = [];
avg = [];
sd  = [];

% the n-th column is y (output), so we calculate only column 1 to n-1
for i = 1:n-1
	avg = [avg mean(x(:,i))];
	sd  = [sd std(x(:,i))];
endfor

for i = 1:m
	flag = 1;	

	for j = 1:n-1
	 	% calculate z-value
	 	x_z(i,j) = (x(i,j)-avg(:,j))/sd(:,j);

	 	if(x_z(i,j)<-3 || x_z(i,j)>3)
 	 	 	flag = 0;
 	 	 	break;
 	 	endif

 	 	if(x(i,n) == 9)
 	 	 	flag = 0;	% Remove line with Quality = 9 ... too small to be analysed
 	 	 	break;
 	 	endif

	endfor

	if(flag == 1)
	 	x_z_norm = [x_z_norm; x_z(i,:)];
	 	y = [y; x(i,n)];
	endif

endfor

csvwrite("Input.csv", x_z_norm);
csvwrite("OutputOriginal.csv", y);

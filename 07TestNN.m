function TestNN(prefix="Test", d=1)

	% prefix can be Train, CV, and Test
	FileInput 	 	= cstrcat("Input", prefix, ".csv");
	FileOutput	 	= cstrcat("Output", prefix, ".csv");
	
	FileTheta1 	 	 	= "NNTheta1.csv";
	FileTheta2 	 	 	= "NNTheta2.csv";
	FileTheta3 	 	 	= "NNTheta3.csv";
	FileLogAccuracy 	= "NNLogAccuracy.csv";
	
	x = csvread(FileInput); 
	y = csvread(FileOutput); 
	
	theta1 = csvread(FileTheta1);
	theta2 = csvread(FileTheta2);
	theta3 = csvread(FileTheta3);

	[x, equation] = map_feature(x,d);
	[m, n] = size(x);
	[p, k] = size(y); 

	g = inline('1.0 ./ (1.0 + exp(-z))');

	result = [];
	count = 0;

	for i = 1:m
	 	a1 = [1; x(i,:)'];

	 	z2 = theta1 * a1;
	 	a2 = [1; g(z2)];

	 	z3 = theta2 * a2;
	 	a3 = [1; g(z3)];

	 	z4 = theta3 * a3;
	 	h  = g(z4);
	 	 	   
	 	[ max_value_h, max_index_h ] = max(h);
	 	[ max_value_y, max_index_y ] = max(y(i,:));

	 	if(max_index_h == max_index_y)
	 	    count = count+1;
	 	  	flag = 1;
	 	else
	 	   	flag = 0;
	 	endif

	 	result = [result; max_index_y+2 max_index_h+2 flag];

	endfor

	printf("(%s dataset): Correct %d of %d rows, or %d%%\n",prefix, count, m, count*100/m);
	csvwrite(FileLogAccuracy, result);
	
end

function TestLR (prefix="Test", d=1)
	
	% prefix can be Train, CV, and Test
	FileInput 	 	= cstrcat("Input", prefix, ".csv");
	FileOutput	 	= cstrcat("Output", prefix, ".csv");
	
	FileTheta	 	= "LRTheta.csv";
	FileLogAccuracy	= "LRLogAccuracy.csv";
	
	x=csvread(FileInput); 
	y=csvread(FileOutput);

	theta = csvread(FileTheta);
	
	[x, equation] = map_feature(x,d);
	[m, n] = size(x);
	x = [ones(m, 1), x];
	
	g = inline('1.0 ./ (1.0 + exp(-z))');

	z = x * theta;
	h = g(z);

	result = [];
	count = 0;

	for i = 1:m
	   
	 	[ max_value_h, max_index_h ] = max(h(i,:));
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

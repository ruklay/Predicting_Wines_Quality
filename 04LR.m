function LR(MAX_ITR,alpha,lambda,d)
	
	%MAX_ITR = 100;
	%alpha = 0.01;
	%lambda = 10;
	%d = 5;

	FileInputTrain 	= "InputTrain.csv";
	FileOutputTrain 	= "OutputTrain.csv"; 
	FileInputCV 	 	= "InputCV.csv";
	FileOutputCV 	 	= "OutputCV.csv";  
	FileInputTest 	 	= "InputTest.csv";
	FileOutputTest 	 	= "OutputTest.csv";
	
	FileTheta 	 	 	= "LRTheta.csv";
	FileLogCost	 	 	= "LRLogCost.csv";

	x = csvread(FileInputTrain); 
	y = csvread(FileOutputTrain); 
	
	% Change the hyphothesis equation based on Model Complexity (d)
	[x, equation] = map_feature(x,d);
	
	[m, n] = size(x);
	[p, k] = size(y);
	
	x = [ones(m, 1), x];
	theta = zeros(n+1, k);	 	% k is 6 possible values (3 to 8)
	
	g = inline('1.0 ./ (1.0 + exp(-z))'); 

	cost = [];

	% Begin GD
	for i = 1:MAX_ITR
	 
	 	z = x * theta;
	 	h = g(z);
	 	grad = (1/m).*x' * (h-y);     

	 	%-----Regularised---------
	 	theta(1,:) = theta(1,:) - alpha .* grad(1,:);
	 	theta(2:end,:) = theta(2:end,:)*(1-(alpha*lambda)/m) - alpha .* grad(2:end,:);
	 	costJ = (1/m)*sum(-y.*log(h) - (1-y).*log(1-h)) + lambda/(2*m).*(sum(theta(2:end,1).^2));

	 	%------NON Regularised--------
	 	%theta = theta - alpha.*grad;
	 	%costJ = (1/m)*sum(-y.*log(h) - (1-y).*log(1-h));

	 	cost = [cost; sum(costJ)];
	 	
	 	% For testing only
	 	%if (mod(i,100) == 0)
	 	% 	csvwrite(FileTheta, theta);
	 	% 	
	 	% 	printf("ITR = %d\n", i);
    	% 	TestLR("Train",d)
	 	%endif  
	     
	endfor
	     
	csvwrite(FileTheta, theta);
	csvwrite(FileLogCost, cost);

end


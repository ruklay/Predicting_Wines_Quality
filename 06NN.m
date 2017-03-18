function NN(MAX_ITR,alpha,lambda,d,l2=14,l3=11)
	
	%MAX_ITR = 50;
	%alpha = 0.01;
	%lambda = 1;
	%d = 1;
	%l2 = 5;
	%l3 = 5;

	FileInputTrain 	= "InputTrain.csv";
	FileOutputTrain 	= "OutputTrain.csv"; 
	FileInputCV 	 	= "InputCV.csv";
	FileOutputCV 	 	= "OutputCV.csv";  
	FileInputTest 	 	= "InputTest.csv";
	FileOutputTest 	 	= "OutputTest.csv";
	
	FileTheta1 	 	 	= "NNTheta1.csv";
	FileTheta2 	 	 	= "NNTheta2.csv";
	FileTheta3 	 	 	= "NNTheta3.csv";
	FileLogCost	 	 	= "NNLogCost.csv";

	x = csvread(FileInputTrain); 
	y = csvread(FileOutputTrain);

	% Change the hyphothesis equation based on Model Complexity (d)
	%[x, equation] = map_feature(x,d);
	
	[m, n] = size(x);
	[p, k] = size(y); 	 % k is 6 possible values (3 to 8)

	L1 = n;
	L2 = l2;
	L3 = l3;
	L4 = k;

	% Random initialise the theta values
	% Set "seed" to make sure that the next random values are the same for each theta
	rand("seed", 11);
	theta1 = 2*rand(L2,L1+1)-1;
	
	rand("seed", 12);
	theta2 = 2*rand(L3,L2+1)-1;
	
	rand("seed", 13);
	theta3 = 2*rand(L4,L3+1)-1;

	g = inline('1.0 ./ (1.0 + exp(-z))');

	cost_all = [];
	result = [];

	for a = 1:MAX_ITR
	 	cost = 0;

	 	D1 = DD1 = zeros(size(theta1));
	 	D2 = DD2 = zeros(size(theta2));
	 	D3 = DD3 = zeros(size(theta3));

	 	for i = 1:m

	 	 	%------- FORWARD PROPAGATION --------
	 	 	a1 = [1; x(i,:)'];

	 	 	z2 = theta1 * a1;
	 	 	a2 = [1; g(z2)];

	 	 	z3 = theta2 * a2;
	 	 	a3 = [1; g(z3)];

	 	 	z4 = theta3 * a3;
	 	 	h  = g(z4);

	 	 	%------ BACKWARD PROPAGATION --------
	 	 	delta4 = h - y(i,:)';
	 	 	delta3 = ((theta3' * delta4) .* (a3 .* (1 - a3)))(2:end); 
	 	 	delta2 = ((theta2' * delta3) .* (a2 .* (1 - a2)))(2:end); 

	 	 	DD3 = DD3 + (delta4 * a3');
	 	 	DD2 = DD2 + (delta3 * a2');
	 	 	DD1 = DD1 + (delta2 * a1');

	 	 	%---- COST -----
	 	 	cost = cost + sum(-y(i,:)'.*log(h) - (1-y(i,:)').*log(1-h));

	 	endfor

	 	cost = cost/m;
	 	D3 = DD3/m;
	 	D2 = DD2/m;
	 	D1 = DD1/m;

	 	theta3 = theta3 - alpha.*D3;
	 	theta2 = theta2 - alpha.*D2;
	 	theta1 = theta1 - alpha.*D1;
	 	
	 	cost_all = [cost_all; cost];
	 	
	 	% For testing only
	 	%if (mod(a,100) == 0)
	 	% 	csvwrite(FileTheta1, theta1);
	 	% 	csvwrite(FileTheta2, theta2);
	 	% 	csvwrite(FileTheta3, theta3);
	 	% 	
	 	% 	printf("ITR = %d\n", a);
    	% 	TestNN("Train",d)
	 	%endif  

	endfor

	csvwrite(FileTheta1, theta1);
	csvwrite(FileTheta2, theta2);
	csvwrite(FileTheta3, theta3);
	csvwrite(FileLogCost, cost_all);

end

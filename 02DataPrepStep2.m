function ChangeOutputValue(FileName)
	listValIn = csvread(FileName);
	[m n] = size(listValIn);

	listValOut = zeros(m,6);	% output has 6 possible value (3 to 8)
	
	for i = 1:m
	   	listValOut(i,listValIn(i,:)-2) = 1;
	endfor

	csvwrite(strrep(FileName,"Original",""), listValOut);

end

function SplitFile(FileName)
	input = csvread(FileName);
	[m n] = size(input);
	sizeTrain = round(0.6*m);
	sizeCV = round(0.2*m);
	sizeTest = m-sizeTrain-sizeCV;

	train = input(1:sizeTrain,:);
	CV = input(sizeTrain+1:sizeTrain+sizeCV,:);
	test = input(sizeTrain+sizeCV+1:m,:);

	csvwrite(cstrcat(strrep(FileName,".csv",""),"Train.csv"), train);
	csvwrite(cstrcat(strrep(FileName,".csv",""),"CV.csv"), CV);
	csvwrite(cstrcat(strrep(FileName,".csv",""),"Test.csv"), test);

end

%---------------------------

ChangeOutputValue("OutputOriginal.csv");

SplitFile("Input.csv");
SplitFile("Output.csv");

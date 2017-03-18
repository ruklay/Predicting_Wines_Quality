function [out equation] = map_feature(x,d)

 	[m, n] = size(x);
	out = x;
	equation = "x_all";

	if(d>1)
	
    	for i = 2:d
	 	 	out = [out x.^i];
	 	 	equation = cstrcat(equation," + x_all^",num2str(i));
	 	endfor

   	 	for i = 2:d
 	   	 	for k = 0:(n-i)
 	 	 	 	o = ones(m,1);
 	 	 	 	equation = cstrcat(equation," + ");
 	 	 	 	for j = 1:i
 	 	 	 	 	o = o.*x(:,j+k);
 	 	 	 	 	equation = cstrcat(equation,"x",num2str(j+k));
 	 	 	 	 	if(j!=i)
 	 	 	 	 	 	equation = cstrcat(equation,".");
 	 	 	 	 	endif
 	 	 	 	endfor
 	 	 	 	out = [out o];
 	 	 	endfor
 	 	endfor
	
	endif

end

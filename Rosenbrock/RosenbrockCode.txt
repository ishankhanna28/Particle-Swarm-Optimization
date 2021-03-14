% Objective function
function f = Rosenbrock(in)
	% Unpack inputs
	x = in(1);
	y = in(2);

	%The rosenbrock_func in 2D
	f = 100*(y-x^2)^2 + (1-x)^2;
%Global Minima will be f(x)=0 for x=y=1
end

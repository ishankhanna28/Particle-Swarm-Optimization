function y = Rastrigin(X)

	A = 10;
	n=2;
	m=0;

	for i = 1:n
		m = m + X(i)^2 - A*cos(2*pi*X(i));
    end
    % Global minima is f(x)=0 for x=y=0
	y = 10*n + m;
end
clc							% To clear the command window
clear							% To clear the workspace

%% Problem Settings	
lb = [-10 -10];						% Lower Bound
ub = [10 10];						% Upper Bound
prob = @Rastrigin;					% Fitness Function handle

%% Algorithm Parameters
Np = 25;						% Population size
T = 100;						% No. of iterations
wmax = 0.85;                        			% Maximum Inertia weight
wmin = 0.75;                        			% Minimum Inertia weight
c1 = 1.99;						% Acceleration coefficient
c2 = 2.01;						% Acceleration coefficient
key = T/2;                          			% Half-way point

%% Particle Swarm Optimization
f = NaN(Np,1);						% Vector to store the fitness function value of the population
BestFitIter = NaN(T+1,1); 

D = length(lb);						% Determining the number of decision variables in the problem 
P = repmat(lb,Np,1) + repmat( (ub-lb), Np,1).*rand(Np,D);	% Generation of initial position
v = repmat(lb,Np,1) + repmat( (ub-lb), Np,1).*rand(Np,D);	% Generation of initial velocity  

for p = 1:Np
	f(p) = prob(P(p,:));				% Evaluating the fitness function of the initial population
end

pbest = P;						% Initialize the personal best solutions
f_pbest = f;						% Initialize the fitness of the personal best solutions 

[f_gbest,ind] = min(f_pbest);				% Determining the best objective fitness function value
gbest = P(ind,:);					% Determining the best solution
BestFitIter(1) = f_gbest;				% Initializing Vector to store value of Global Best at the end of each iteration

for t = 1:T  
    
     w = wmin + (wmax-wmin)*0.95^(t-1);     		% Simmulated Annealing
     
     if t==key                              		% At midpoint, we swap values of acceleration coefficient
        c1 = 2.01;
        c2 = 1.99;
     end

	for p = 1:Np

		v(p,:) = w*v(p,:) + c1*rand(1,D).*(pbest(p,:)-P(p,:)) + c2*rand(1,D).*(gbest-P(p,:)); % Determine new velocity

		P(p,:) = P(p,:) + v(p,:);		% Update the position

		P(p,:) = max(P(p,:),lb);		% Bounding the violating variables to their lower bounds
		P(p,:) = min(P(p,:),ub);		% Bounding the violating variables to their upper bounds

		f(p) = prob(P(p,:));			% Determining the fitness of the new solution

		if f(p) < f_pbest(p)

			f_pbest(p) = f(p);		% updating the fitness function value of the personal best solution
			pbest(p,:) = P(p,:);		% updating the personal best solution

			if f_pbest(p) < f_gbest

			f_gbest = f_pbest(p);		% updating the fitness function value of the best solution
			gbest = pbest(p,:);		% updating the global best solution

            end
		end
	end

	BestFitIter(t+1) = f_gbest;			% Storing value of Global Best after each iteration
	disp(['Iteration ' num2str(t) ': Best fitness = ' num2str(BestFitIter(t+1))]); 	% displaying global best For each iteration
end

bestfitness = f_gbest	
bestsol = gbest

%% convergence with semilog plot 
subplot(1,2,1)
plot(0:T,BestFitIter);					% Plotting convergence curve 
xlabel('Iteration');
ylabel('Best fitness value')

subplot(1,2,2)
semilogy(0:T,BestFitIter);				% Plotting with y axis on log scale
xlabel('Iteration');
ylabel('Best fitness value')

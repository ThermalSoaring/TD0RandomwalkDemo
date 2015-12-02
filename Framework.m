function Framework()
% Problem to be solved:
% You start in the center of five states.
% Each time interval, you have a 50/50 chance of moving left/right
% If you end up to the right, you get a reward of 1
% If you end up to the left, you get a reward of 0
% We want to calculate the value of each state
% (Real answers: 1/6, 2/6, 3/6, 4/6, 5/6) (states 1, 2, 3, 4, 5)
% (This is assuming all we care about is eventual reward: set lambda close
% to 1).
% See here: https://webdocs.cs.ualberta.ca/~sutton/book/ebook/node62.html

%% Interesting things to note
% Setting alpha to be small yields good results after a long time (duh)
% Setting lambda to be large yields a very steady decrease in error to a
% small value
% Setting lambda to be small yields a spike downwards, followed by a
% gradual rise upwards to a reasonably high error value
% This is strange behaviour!
%%

% Uses TD(0) (lambda is zero)
% See here: https://webdocs.cs.ualberta.ca/~sutton/book/ebook/node61.html

% Set learning rate (higher is larger)
alpha = 0.1;

% Set how heavily we weight future success (vs reward now)
lambda = 0.99;
% If all we care about is eventual success, we make lambda about 1

% Store values to states (arbitary initial values)
V = ones(1,5);

% Our initial state is always state three (central state)
sInit = 3;

numTrials = 200; % Number of playing batches to average over
numIter = 200; % Number of times to play the game per batch
error = zeros(numTrials,numIter); % Rows store results from one learning batch
for j = 1:numTrials
    V = ones(1,5);
    for i = 1:numIter
        % Run one round of simulation
        V = simOneRound(sInit, V, alpha, lambda);
        
        % Find RMS error
        Vrat = V/V(5);
        ideal = [1/5 2/5 3/5 4/5 1];
        error(j,i) = sqrt(sum((Vrat - ideal).^2)); 
    end
end
errorAvg = mean(error); %Averages columns - averages batch
plot(errorAvg)
title('Performance of TD(0) State Value Estimation on Random Walk')
xlabel('Number of games played')
ylabel('Average RMS error')

end
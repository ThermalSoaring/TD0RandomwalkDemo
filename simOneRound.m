function [ V ] = simOneRound(sInit, V, alpha, lambda)
% Perform one run of simulation until a goal (on side or another) is reached

% Store 1 if terminal
done = 0;

s = sInit;

while(done == 0)
     reward = 0;
     flipResult = randi([0 1]);
     if (flipResult == 1) % Move right (desirable)
         if (s <= 4)
            sp = s +1; 
         else
            done = 1; 
            reward = 1;
         end
     else % Move left (undesirable)
         if (s >= 2)
             sp = s - 1; 
         else
             done = 1;
             reward = 0;
         end
     end   
     
     % Calculate the value of the next state
     if (done == 0)
         Vnext = V(sp);
     else
         Vnext = 0;
     end
     
     V(s) = V(s) + alpha*(reward + lambda*Vnext - V(s));
     
     % Move to next state
     s = sp;
end

end


% Eirini Donti 03119839
clc;
clear all;
close all;
rand("seed",1);

% 2nd Task


printf("for lambda = 1 client/min\n"); % λ = 1 πελάτης/min
P = zeros(1,11);
arrivals = zeros(1,11);
number_of_total_arrivals = 0; % Total Number of Arrivals
state = 0;                    % Current State of System
previous_mean_clients = 0;    % Previous Mean Clients
index = 0;
lambda = 1; # λ = 1 
mu = 5;
threshold = lambda/(lambda + mu); % Threshold λ/(λ+μ)
transitions = 0;                  % Transitions of the Simulation

while transitions >= 0
  transitions = transitions + 1;  % Increase Transition Step
  if mod(transitions,1000) == 0   % Check for Convergence Every 1000 Transitions
    index = index + 1;
    for i=1:1:length(arrivals)
        P(i) = arrivals(i)/number_of_total_arrivals; % Probability for Every State
    endfor
    
    mean_clients = 0;                                % Calculate the Mean Number of Clients
    for i=1:1:length(arrivals)
       mean_clients = mean_clients + (i-1).*P(i);
    endfor
    
    help_to_plot(index) = mean_clients;
        
    if abs(mean_clients - previous_mean_clients) < 0.00001 || transitions > 200000 % Test Convergence
      break;
    endif
    
    previous_mean_clients = mean_clients;
    
  endif
  
  random_number = rand(1);                    % Generate Random Number
  if state == 0 || random_number < threshold  % In Case of Arrival
    if state < 11
      number_of_total_arrivals = number_of_total_arrivals + 1;
      if transitions < 31
        printf("Current State = "); s = state
        printf("Next Transition - Arrival\n");
        printf("Total Arrivals in Current State = "); a = arrivals(state+1)
      endif
      arrivals(state + 1) = arrivals(state + 1) + 1; % Increase Number of Arrivals In Current State
      if state < 10
        state = state + 1;
      endif    
    endif   
  else                                        % In Case of departure
    if state != 0 % No Departure from Empty System
      if transitions < 31
        printf("Current state = "); s = state
        printf("Next transition - Departure\n");
        printf("Total Arrivals In Current State = "); a = arrivals(state+1)
      endif
        state = state - 1;
    endif
  endif
endwhile


#(i)
printf("Propabilities of Every State:\n");
for i=1:1:length(arrivals)
  P(i)
endfor

#(ii)
printf("Blocking Propability = "); p_bl = P(11)

# (a)
x=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
figure;
bar(x,P,0.3,"r");
title("Probabilities (λ=1)");
xlabel("State");

#(iii) or (b)
figure;
plot(help_to_plot,"r","linewidth",1.4);
title("Mean Number of Clients in Queue Simulation for lambda = 1");
xlabel("Transitions (In Thousands)");
ylabel("Mean Number of Clients");
hold on;
grid on;

#(iv)
average_delay_time = mean_clients/(lambda*(1-P(11)));
printf("Mean Delay Time = "); delay = average_delay_time

rand("seed",1);

% λ = 5 πελάτες/min 

printf("for lambda = 5 clients/min\n"); % λ = 5 πελάτες/min
P = zeros(1,11);
arrivals = zeros(1,11);
number_of_total_arrivals = 0; % Total Number of Arrivals
state = 0;                    % Current State of System
previous_mean_clients = 0;    % Previous Mean Clients
index = 0;
lambda = 5; # λ = 5 
mu = 5;
threshold = lambda/(lambda + mu); % Threshold λ/(λ+μ)
transitions = 0;                  % Transitions of the Simulation

while transitions >= 0
  transitions = transitions + 1;  % Increase Transition Step
  if mod(transitions,1000) == 0   % Check for Convergence Every 1000 Transitions
    index = index + 1;
    for i=1:1:length(arrivals)
        P(i) = arrivals(i)/number_of_total_arrivals; % Probability for Every State
    endfor
    
    mean_clients = 0;                                % Calculate the Mean Number of Clients
    for i=1:1:length(arrivals)
       mean_clients = mean_clients + (i-1).*P(i);
    endfor
    
    help_to_plot(index) = mean_clients;
        
    if abs(mean_clients - previous_mean_clients) < 0.00001 || transitions > 200000 % Test Convergence
      break;
    endif
    
    previous_mean_clients = mean_clients;
    
  endif
  
  random_number = rand(1);                    % Generate Random Number
  if state == 0 || random_number < threshold  % In Case of Arrival
    if state < 11
      number_of_total_arrivals = number_of_total_arrivals + 1;
      if transitions < 31
        printf("Current State = "); s = state
        printf("Next Transition - Arrival\n");
        printf("Total Arrivals in Current State = "); a = arrivals(state+1)
      endif
      arrivals(state + 1) = arrivals(state + 1) + 1; % Increase Number of Arrivals In Current State
      if state < 10
        state = state + 1;
      endif    
    endif   
  else                                        % In Case of departure
    if state != 0 % No Departure from Empty System
      if transitions < 31
        printf("Current state = "); s = state
        printf("Next transition - Departure\n");
        printf("Total Arrivals In Current State = "); a = arrivals(state+1)
      endif
        state = state - 1;
    endif
  endif
endwhile


#(i)
printf("Propabilities of Every State:\n");
for i=1:1:length(arrivals)
  P(i)
endfor

#(ii)
printf("Blocking Propability = "); p_bl = P(11)

# (a)
x=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
figure;
bar(x,P,0.3,"r");
title("Probabilities (λ=5)");
xlabel("State");

#(iii) or (b)
figure;
plot(help_to_plot,"r","linewidth",1.4);
title("Mean Number of Clients in Queue Simulation for lambda = 5");
xlabel("Transitions (In Thousands)");
ylabel("Mean Number of Clients");
hold on;
grid on;

#(iv)
average_delay_time = mean_clients/(lambda*(1-P(11)));
printf("Mean Delay Time = "); delay = average_delay_time

rand("seed",1);

# λ = 10 πελάτες/min 

printf("for lambda = 10 clients/min\n"); % λ = 10 πελάτες/min
P = zeros(1,11);
arrivals = zeros(1,11);
number_of_total_arrivals = 0; % Total Number of Arrivals
state = 0;                    % Current State of System
previous_mean_clients = 0;    % Previous Mean Clients
index = 0;
lambda = 10; # λ = 10 
mu = 5;
threshold = lambda/(lambda + mu); % Threshold λ/(λ+μ)
transitions = 0;                  % Transitions of the Simulation

while transitions >= 0
  transitions = transitions + 1;  % Increase Transition Step
  if mod(transitions,1000) == 0   % Check for Convergence Every 1000 Transitions
    index = index + 1;
    for i=1:1:length(arrivals)
        P(i) = arrivals(i)/number_of_total_arrivals; % Probability for Every State
    endfor
    
    mean_clients = 0;                                % Calculate the Mean Number of Clients
    for i=1:1:length(arrivals)
       mean_clients = mean_clients + (i-1).*P(i);
    endfor
    
    help_to_plot(index) = mean_clients;
        
    if abs(mean_clients - previous_mean_clients) < 0.00001 || transitions > 200000 % Test Convergence
      break;
    endif
    
    previous_mean_clients = mean_clients;
    
  endif
  
  random_number = rand(1);                    % Generate Random Number
  if state == 0 || random_number < threshold  % In Case of Arrival
    if state < 11
      number_of_total_arrivals = number_of_total_arrivals + 1;
      if transitions < 31
        printf("Current State = "); s = state
        printf("Next Transition - Arrival\n");
        printf("Total Arrivals in Current State = "); a = arrivals(state+1)
      endif
      arrivals(state + 1) = arrivals(state + 1) + 1; % Increase Number of Arrivals In Current State
      if state < 10
        state = state + 1;
      endif    
    endif   
  else                                        % In Case of departure
    if state != 0 % No Departure from Empty System
      if transitions < 31
        printf("Current state = "); s = state
        printf("Next transition - Departure\n");
        printf("Total Arrivals In Current State = "); a = arrivals(state+1)
      endif
        state = state - 1;
    endif
  endif
endwhile


#(i)
printf("Propabilities of Every State:\n");
for i=1:1:length(arrivals)
  P(i)
endfor

#(ii)
printf("Blocking Propability = "); p_bl = P(11)

# (a)
x=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
figure;
bar(x,P,0.3,"r");
title("Probabilities (λ=10)");
xlabel("State");

#(iii) or (b)
figure;
plot(help_to_plot,"r","linewidth",1.4);
title("Mean Number of Clients in Queue Simulation for lambda = 10");
xlabel("Transitions (In Thousands)");
ylabel("Mean Number of Clients");
hold on;
grid on;

#(iv)
average_delay_time = mean_clients/(lambda*(1-P(11)));
printf("Mean Delay Time = "); delay = average_delay_time



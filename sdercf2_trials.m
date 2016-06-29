% This code is used to run trials of the comprehensive shortest distance
% model with counter flow and reaction time

% generate people and randomize their order in the matrix
seed = [];
for person=1:5400
    seed(person, 1) = 90 + floor((90-person)/90);
    seed(person, 2) = mod(person, 90) + 6;
    seed(person, 3) = normrnd(30, 10);
    seed(person, 4) = randsample(100,1);
end
idx = randperm(size(seed,1));
p = seed(idx, :);

% create walls
walls = [];
for i=1:100
    walls = [walls; [i 1]];
    walls = [walls; [1 i]];
    walls = [walls; [100 i]];
    walls = [walls; [i 100]];
end

% create exits
exits = [];
for i=40:60
    exits = [exits; [1 i]];
end

% create counter-flow destinations
cf = [];
for i=40:60
    cf = [cf; [99 i]];
end

time = 90;
cp = 20;

[escaped_total,escaped_deriv,heat] = sdercf2([100,100],walls, exits, p, cf, cp, time, true);
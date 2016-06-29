% This code is used to run trials of the shortest distance escape model

% generate people and randomize their order in the matrix
seed = [];
for person=1:5400
    seed(person, 1) = 90 + floor((90-person)/90);
    seed(person, 2) = mod(person, 90) + 6;
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

time = 300;
[total,deriv,heat] = sdem([100,100],walls, exits, p, time, true);

% create a heatmap of where people traveled
figure(1)
imagesc(heat);
colormap(jet)
axis equal
colorbar
xlim([0,100]);
title('Congestion')

% plot the number of escaped people vs time
figure(2)
plot(1:time, total);
xlabel('Time');
ylabel('Total Evacuated');
title('Number of People Evacuated over Time');

% plot the number of people escaping at each second
figure(3)
plot(1:time, deriv);
xlabel('Time');
ylabel('People Evacuating Per Unit of Time');
title('People Evacuating Derivative');

% bar chart sometimes looks better for derivative
figure(4)
bar(deriv);
xlabel('Time');
ylabel('People Evacuating');
title('People Evacuating Derivative');

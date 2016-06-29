% This code is used to run trials of the comprehensive shortest distance
% model with counter flow and reaction time

% generate people and randomize their order in the matrix
seed = [];
for person=1:5400
    seed(person, 1) = 90 + floor((90-person)/90);
    seed(person, 2) = mod(person, 90) + 6;
    % seed(person, 3) = normrnd(30, 10);
    seed(person, 3) = 0;
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

time = 500;

%%

cp = 0;
[total1,deriv1,heat1] = sdercf([100,100],walls, exits, p, cf, cp, time, false);
disp('1');
cp = 5;
[total2,deriv2,heat2] = sdercf([100,100],walls, exits, p, cf, cp, time, false);
disp('2');
cp = 10;
[total3,deriv3,heat3] = sdercf([100,100],walls, exits, p, cf, cp, time, false);
disp('3');
cp = 20;
[total4,deriv4,heat4] = sdercf([100,100],walls, exits, p, cf, cp, time, false);
disp('Done');
%%
figure(1)
subplot(2,2,1)
imagesc(heat1);
colormap(jet)
axis equal
colorbar
title('No Counter Flow')
xlim([0,100])
subplot(2,2,2)
imagesc(heat2);
colormap(jet)
axis equal
colorbar
title('5% Counter Flow')
xlim([0,100])
subplot(2,2,3)
imagesc(heat3);
colormap(jet)
axis equal
colorbar
title('10% Counter Flow')
xlim([0,100])
subplot(2,2,4)
imagesc(heat4);
colormap(jet)
axis equal
colorbar
title('20% Counter Flow')
xlim([0,100])

figure(2)
plot(total1)
hold on
plot(total2)
hold on
plot(total3)
hold on
plot(total4)
legend('No Counter Flow', '5% Counter Flow', '10% Counter Flow', '20% Counter Flow')
title('Counter Flow and Total Escaped')
xlabel('Time')
ylabel('Total Escaped')

figure(3)
plot(deriv1)
hold on
plot(deriv2)
hold on
plot(deriv3)
hold on
plot(deriv4)
legend('No Counter Flow', '5% Counter Flow', '10% Counter Flow', '20% Counter Flow')
title('Counter Flow and Rate of Escape')
xlabel('Time')
ylabel('Rate of Escape')

%%

cp = 0;
for i=1:5400
    p(i,3) = normrnd(40, 5);
end
[total5,deriv5,heat5] = sdercf([100,100],walls, exits, p, cf, cp, time, false);
disp('1');
for i=1:5400
    p(i,3) = normrnd(40, 10);
end
[total6,deriv6,heat6] = sdercf([100,100],walls, exits, p, cf, cp, time, false);
disp('2');
for i=1:5400
    p(i,3) = normrnd(40, 20);
end
[total7,deriv7,heat7] = sdercf([100,100],walls, exits, p, cf, cp, time, false);
disp('3');

%%
figure(1)
subplot(2,2,1)
imagesc(heat1);
colormap(jet)
axis equal
colorbar
title('No Reaction')
xlim([0,100])
subplot(2,2,2)
imagesc(heat5);
colormap(jet)
axis equal
colorbar
title('N(40,5)')
xlim([0,100])
subplot(2,2,3)
imagesc(heat6);
colormap(jet)
axis equal
colorbar
title('N(40,10)')
xlim([0,100])
subplot(2,2,4)
imagesc(heat7);
colormap(jet)
axis equal
colorbar
title('N(40,20)')
xlim([0,100])

figure(2)
plot(total1)
hold on
plot(total5)
hold on
plot(total6)
hold on
plot(total7)
legend('No Reaction', 'N(40,5)', 'N(40,10)', 'N(40,20)')
title('Reaction Time and Total Escaped')
xlabel('Time')
ylabel('Total Escaped')

figure(3)
plot(deriv1)
hold on
plot(deriv5)
hold on
plot(deriv6)
hold on
plot(deriv7)
legend('No Reaction', 'N(40,5)', 'N(40,10)', 'N(40,20)')
title('Reaction Time and Rate of Escape')
xlabel('Time')
ylabel('Rate of Escape')

%%
cp = 0;
for i=1:5400
    p(i,3) = normrnd(40, 5);
end
[total8,deriv8,heat8] = sdercf2([100,100],walls, exits, p, cf, cp, time, false);
disp('1');
for i=1:5400
    p(i,3) = normrnd(40, 10);
end
[total9,deriv9,heat9] = sdercf2([100,100],walls, exits, p, cf, cp, time, false);
disp('2');
for i=1:5400
    p(i,3) = normrnd(40, 20);
end
[total10,deriv10,heat10] = sdercf2([100,100],walls, exits, p, cf, cp, time, false);
disp('3');

%%
figure(1)
subplot(2,2,1)
imagesc(heat1);
colormap(jet)
axis equal
colorbar
title('No Reaction')
xlim([0,100])
subplot(2,2,2)
imagesc(heat8);
colormap(jet)
axis equal
colorbar
title('N(40,5)')
xlim([0,100])
subplot(2,2,3)
imagesc(heat9);
colormap(jet)
axis equal
colorbar
title('N(40,10)')
xlim([0,100])
subplot(2,2,4)
imagesc(heat10);
colormap(jet)
axis equal
colorbar
title('N(40,20)')
xlim([0,100])

figure(2)
plot(total1)
hold on
plot(total8)
hold on
plot(total9)
hold on
plot(total10)
legend('No Reaction', 'N(40,5)', 'N(40,10)', 'N(40,20)')
title('Reaction Time and Total Escaped')
xlabel('Time')
ylabel('Total Escaped')

figure(3)
plot(deriv1)
hold on
plot(deriv8)
hold on
plot(deriv9)
hold on
plot(deriv10)
legend('No Reaction', 'N(40,5)', 'N(40,10)', 'N(40,20)')
title('Reaction Time and Rate of Escape')
xlabel('Time')
ylabel('Rate of Escape')

%%

% HISTOGRAM OF DERIVATIVES FOR RANDOM REACTION

subplot(2,2,1)
histogram(deriv1)
title('Immediate Reaction')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,2)
histogram(deriv5)
title('N(40,5)')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,3)
histogram(deriv6)
title('N(40,10)')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,4)
histogram(deriv7)
title('N(40,20)')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])

%%

% HISTOGRAM OF DERIVATIVES FOR STATIONARY REACTION

subplot(2,2,1)
histogram(deriv1)
title('Immediate Reaction')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,2)
histogram(deriv8)
title('N(40,5)')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,3)
histogram(deriv9)
title('N(40,10)')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,4)
histogram(deriv10)
title('N(40,20)')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])

%%

% HISTOGRAM OF DERIVATIVES FOR COUNTER FLOW

subplot(2,2,1)
histogram(deriv1)
title('No Counter Flow')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,2)
histogram(deriv2)
title('5% Counter Flow')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,3)
histogram(deriv3)
title('10% Counter Flow')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
subplot(2,2,4)
histogram(deriv4)
title('20% Counter Flow')
xlabel('Rate of Evacuation')
ylabel('Occurences')
xlim([-1,22])
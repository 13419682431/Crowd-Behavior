function [escaped_total, escaped_deriv, heat] = re(grid, walls, exits, p, time, visualization)

% This function simulates a crowd of people evacuating a building 
% based on random selection
%
% ------------------------ PARAMETERS ---------------------------------
% GRID: 1x2 array [m,n] where m is the height and n is the width
% WALLS: Nx2 array where each row contains the coordinates for a wall point
% EXITS: Nx2 array where each row contains the coordinates for an exit
%       point
% P: information about the people to simulate (location and start)
% TIME: duration of simulation
% VISUALIZATION: true or false; determines if visualization is created

% initialize grid
height = grid(1);
width = grid(2);
A = ones(height,width);

% intialize heatmap
heat = zeros(height,width);

% build the perimeters
wall = size(walls,1);
for i=1:wall
    A(walls(i,1),walls(i,2)) = 0;
end

% build the exits
exit = size(exits,1);
for i=1:exit
    A(exits(i,1),exits(i,2)) = 1;
end

% draw starting positions
people = size(p,1);
for j=1:people
    A(p(j,1), p(j,2)) = 0;
end

% array to record the number of people escaping
escaped = 0;
escaped_total = [];
escaped_deriv = [];

% implement the simulation 
for i=1:time
    
    if visualization
        visualize(A,10);
    end
    
    m = size(p,1);
    escaping = 0;
    
    % iterate over each person to determine how they move
    for obj=1:m
        
        h = p(obj, 1);
        w = p(obj, 2);
        
        % delete old position
        A(h,w) = 1;
        
        % randomly select one of the 6 possible directions
        d = randsample(8,1);
        
        % find new position
        if d==1 &&  A(h-1,w) == 1
            p(obj, 1) = h - 1;
        elseif d==2 && A(h+1,w) == 1
            p(obj, 1) = h + 1;
        elseif d==3 && A(h,w-1) == 1
            p(obj, 2) = w - 1;
        elseif d==4 && A(h,w+1) == 1
            p(obj, 2) = w + 1;
        elseif d==5 && A(h+1,w+1) == 1
            p(obj, 1) = h + 1;
            p(obj, 2) = w + 1;
        elseif d==6 && A(h-1,w+1) == 1
            p(obj, 1) = h - 1;
            p(obj, 2) = w + 1;
        elseif d==7 && A(h-1,w-1) == 1
            p(obj, 1) = h - 1;
            p(obj, 2) = w - 1;
        elseif d==8 && A(h+1,w-1) == 1
            p(obj, 1) = h + 1;
            p(obj, 2) = w - 1;
        end
        
        % write new position
        A(p(obj, 1), p(obj, 2)) = 0;
        
    end
    
    % find those who have escaped
    for obj=1:m
        if p(m-obj+1, 1) == 1
            A(p(m-obj+1, 1), p(m-obj+1, 2)) = 1;
            p(m-obj+1, :) = [];
            escaped = escaped + 1;
            escaping = escaping + 1;
        end
    end
    
    escaped_total = [escaped_total; escaped];
    escaped_deriv = [escaped_deriv; escaping];
    
end

end 
function [escaped_total,escaped_deriv,heat] = sdercf2(grid, walls, exits, p, cf, cp, time, visualization)

% This function simulates crowd evacuation from a building where the
% behavior of the individual entails moving in a direction that minimizes
% distance from an exit point. Each individual agent has 9 possible
% positions to move to, and he will pick the available location that has the smallest
% distance to the exit. If two or more such points exist, the person will
% randomly select from the available options. Additionally, each person has
% a reaction time, only after which that person will begin to move toward
% the exit. Before this time, the agents remain still. Lastly, there
% are a certain percentage of the crowd that is moving in the opposite
% direction to another location
%
% ------------------------ PARAMETERS ---------------------------------
% GRID: 1x2 array [m,n] where m is the height and n is the width
% WALLS: Nx2 array where each row contains the coordinates for a wall point
% EXITS: Nx2 array where each row contains the coordinates for an exit
%       point
% P: information about the people to simulate (location and start)
% CF: contains the location that counter-flow agents are going toward
% CP: percentage of people that move counter-flow
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

for i = 1:time
    
    % create visualization if desired
    if visualization
        visualize(A,10);
    end
    
    m = size(p,1);
    escaping = 0;
    
    % iterate over each person to determine how they move
    for obj=1:m
        
        % store height and width for easier access later
        h = p(obj, 1);
        w = p(obj, 2);
        
        % update heat map
        heat(h,w) = heat(h,w) + 1;
        
        % delete old position
        A(h,w) = 1;
    
        % REACTION TIME -------------------------------------------------
        if i < p(obj, 3)

            % do nothing

        % COUNTER FLOW AGENTS ------------------------------------------
        elseif p(obj, 4) <= cp
            
            % find new possible positions
            possible = [];
            if (A(h-1,w) == 1) possible = [possible; [-1,0]]; end
            if (A(h+1,w) == 1) possible = [possible; [1,0]]; end
            if (A(h,w-1) == 1) possible = [possible; [0,-1]]; end
            if (A(h,w+1) == 1) possible = [possible; [0,1]]; end
            if (A(h-1,w+1) == 1) possible = [possible; [-1,1]]; end
            if (A(h+1,w+1) == 1) possible = [possible; [1,1]]; end
            if (A(h+1,w-1) == 1) possible = [possible; [1,-1]]; end
            if (A(h-1,w-1) == 1) possible = [possible; [-1,-1]]; end
            possible = [possible; [0,0]];

            ins = size(possible,1);
            smallest = 1000000;
            ids = [];

            % iterate over points and possible directions to calculate
            % which offers the most improvement to destination
            numcfs = size(cf,1);
            for point=1:numcfs
                cfh = cf(point,1);
                cfw = cf(point,2);
                for k=1:ins
                    distance = abs(h+possible(k,1)-cfh)^2 + (abs(w+possible(k,2) - cfw))^2;
                    if distance < smallest
                        smallest = distance;
                        ids = k;
                    elseif distance == smallest
                        ids = [ids; k];
                    else 
                        % ignore
                    end 
                end
            end

            % select direction that leads to smallest distance or pick a random
            % direction if there are multiple equally desirable directions
            temp = size(ids,1);
            d=[];
            if temp > 0
                d = possible(ids(randsample(temp,1)), :);
            else
                d(1) = 0;
                d(2) = 0;
            end

            % update position
            p(obj, 1) = h + d(1);
            p(obj, 2) = w + d(2);
            
        % SHORTEST DISTANCE TO EXIT ------------------------------------
        else 
            % find new possible positions
            possible = [];
            if (A(h-1,w) == 1) possible = [possible; [-1,0]]; end
            if (A(h+1,w) == 1) possible = [possible; [1,0]]; end
            if (A(h,w-1) == 1) possible = [possible; [0,-1]]; end
            if (A(h,w+1) == 1) possible = [possible; [0,1]]; end
            if (A(h-1,w+1) == 1) possible = [possible; [-1,1]]; end
            if (A(h+1,w+1) == 1) possible = [possible; [1,1]]; end
            if (A(h+1,w-1) == 1) possible = [possible; [1,-1]]; end
            if (A(h-1,w-1) == 1) possible = [possible; [-1,-1]]; end
            possible = [possible; [0,0]];

            ins = size(possible,1);
            smallest = 1000000;
            ids = [];

            % iterate over exit points and possible directions to calculate
            % which offers the most improvement
            numexits = size(exits,1);
            for point=1:numexits
                exith = exits(point,1);
                exitw = exits(point,2);
                for k=1:ins
                    distance = abs(h+possible(k,1)-exith)^2 + (abs(w+possible(k,2) - exitw))^2;
                    if distance < smallest
                        smallest = distance;
                        ids = k;
                    elseif distance == smallest
                        ids = [ids; k];
                    else 
                        % ignore
                    end 
                end
            end

            % select direction that leads to smallest distance or pick a random
            % direction if there are multiple equally desirable directions
            temp = size(ids,1);
            d=[];
            if temp > 0
                d = possible(ids(randsample(temp,1)), :);
            else
                d(1) = 0;
                d(2) = 0;
            end

            % update position
            p(obj, 1) = h + d(1);
            p(obj, 2) = w + d(2);
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
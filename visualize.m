function visualize(A,scale)

% function referenced by all the other models

[m,n] = size(A);
B = ones(m*scale,n*scale);

for r=1:100
    for c=1:100
        if A(r,c) == 0
            for x=0:scale-1
                for y=0:scale-1
                    B(scale*r - x, scale*c - y) = 0;
                end
            end
        end
    end
end
imshow(B)
pause(0.1)
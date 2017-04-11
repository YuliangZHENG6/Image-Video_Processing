function X = ordered_threshold(Y, s)
    
    X = Y;
    % create the paving table
    [row, col] = size(Y);
    row_times_S = ceil(row/6);
    col_times_S = ceil(col/6);
    S = repmat(s, row_times_S, col_times_S);
    
    % Compare and threshold
    for i = 1:1:row
        for j = 1:1:col
            if Y(i,j) > S(i,j)
                X(i,j) = 255;
            else
                X(i,j) = 0;
            end
        end
    end

end

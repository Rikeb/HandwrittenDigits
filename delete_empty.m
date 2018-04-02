function out = delete_empty(in)
    low_ind = -1;
    high_ind = 0;
    for j = 1:size(in, 2)
        if sum(in(:, j)) ~= 0
            if low_ind == -1
                low_ind = j;
            end
            high_ind = j;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if low_ind == -1 || high_ind == 0
        in = in(:, 1:4);
        in = 1 - in;
        warning('empty image')
    else
        in = in(:, low_ind:high_ind);
    end
    
    
    low_ind = -1;
    high_ind = 0;
    for j = 1:size(in, 1)
        if sum(in(j, :)) ~= 0
            if low_ind == -1
                low_ind = j;
            end
            high_ind = j;
        end
    end
    if low_ind == -1 || high_ind == 0
        in = in(:, 1:4);
        in = 1 - in;
        low_ind = 1;
        high_ind = 4;
        warning('empty image')
    end
    if strcmp(class(in), 'logical')
        in = in(low_ind:high_ind, :);
    else
        in = im2bw(in(low_ind:high_ind, :));
    end
    
    out = in;
end
function imSets = preprocessing(imOrigin, resize, Angle)
    if nargin == 2
        Angle = 'test';
    end

    l = bwlabel(imOrigin);
    stats = regionprops(l);
    areas = cat(1, stats.Area);
    
    % Eliminating small parts in the image
    if length(areas) < 4
        index = find(areas == max(areas));
        l(l ~= index) = 0;
        l(l == index) = 1;
    else
        sort_a = sort(areas, 'descend');
        index = find(areas == sort_a(1));
        l(l == index) = 1;
        index = find(areas == sort_a(1));
        l(l == index) = 1;

        l(l ~= 1) = 0;
    end
    
    % Eliminating empty lines
    temp = delete_empty(medfilt2(l, [3 3]));
    
    if isstr(Angle)
        % reshape the image
        imSets = reshape(imresize(temp, resize, 'bilinear'), 1, prod(resize));
    else
        % rotate, reshape, return
        len = length(Angle);
        if(isempty(find(Angle == 0, 1)))
            len = len + 1;
        end

        imSets = zeros(len, resize(1)*resize(2));

        imSets(1, :) = reshape(imresize(temp, resize, 'bilinear'), 1, prod(resize));

        rown = 2;
        for angle = Angle
            if angle ~= 0
                temp2 = imrotate(temp, angle, 'bilinear');
                temp2 = delete_empty(temp2);
                imSets(rown, :) = reshape(imresize(temp2, resize, 'bilinear'), 1, prod(resize));
                rown = rown + 1;
            end
        end
    end
    
    
%     len = length(Angle);
%     if(isempty(find(Angle == 0, 1)))
%         len = len + 1;
%     end
%     
%     imSets = zeros(len, resize(1)*resize(2));
%     
%     imSets(1, :) = reshape(imresize(temp, resize, 'bilinear'), 1, prod(resize));
%     
%     rown = 2;
%     for angle = Angle
%         if angle ~= 0
%             temp2 = imrotate(temp, angle, 'bilinear');
%             temp2 = delete_empty(temp2);
%             imSets(rown, :) = reshape(imresize(temp2, resize, 'bilinear'), 1, prod(resize));
%             rown = rown + 1;
%         end
%     end
    
%     for i = 1:length(imSets)
%         imSets(i) = imresize(imSets(i), resize, 'bilinear');
%     end
    
    % temp = imresize(delete_empty(temp), resize, 'bilinear');
    
end
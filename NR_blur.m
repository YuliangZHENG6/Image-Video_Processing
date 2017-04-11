function [blur_index_ver,blur_index_hor] = NR_blur(Y)


Edge_v=edge(Y,'sobel','vertical');
Edge_h=edge(Y,'sobel','horizontal');


[row, col] = size(Y);
Y = double(Y);

NonZero= find(Edge_h == 1);
EdgeNum = length(NonZero);

% For horizontal blur: scan for each row
H = [];
index = 0;
for i = 1:1:row
    data = Y(i,:);
    [pksMax, locsMax] = findpeaks(data);
    [pksMin, locsMin] = findpeaks(-data);
    for j = 1:1:col
        if Edge_h(i,j) == 1
            index = index+1;
            [minMax, posMax] = min(abs(locsMax - j*ones(size(locsMax))));
            [minMin, posMin] = min(abs(locsMin - j*ones(size(locsMin))));
             u = abs(locsMax(posMax) - locsMin(posMin));
             H=[H,u];
        end
    end
end

blur_index_hor = sum(H)/size(H,2);

% For vertical blur: scan for each column

NonZero= find(Edge_v == 1);
EdgeNum = length(NonZero);
V =[];

index = 1;
for i = 1:1:col
    data = Y(:,i);
    [pksMax, locsMax] = findpeaks(data);
    [pksMin, locsMin] = findpeaks(-data);
    for j = 1:1:row
        if Edge_v(j,i) == 1
            index = index+1;
            [minMax, posMax] = min(abs(locsMax - j*ones(size(locsMax))));
            [minMin, posMin] = min(abs(locsMin - j*ones(size(locsMin))));
             u = abs(locsMax(posMax) - locsMin(posMin));
             V=[V,u];
        end
    end
end

blur_index_ver = sum(V)/size(V,2);

end

function y = compass_operator(x, T)

k0=[-3 -3 5 ; -3 0 5 ; -3 -3 5];
k1=[-3 5 5 ; -3 0 5 ; -3 -3 -3]
% alpha= 45*pi/180;
% R=[1 0 0;0 cos(alpha) -sin(alpha);0 sin(alpha) cos(alpha)];

K = cell(8,1);
Y=cell(8,1);

K{1,1} = k0;
K{2,1}=k1;

Y{1,1}=conv2(x,k0);
Y{2,1}=conv2(x,k1);

for i = 3:2:7
    K{i,1} =rot90(K{i-2,1});
    Y{i,1}=conv2(x,K{i,1});   
end


for i = 4:2:8
    K{i,1} =rot90(K{i-2,1});
    Y{i,1}=conv2(x,K{i,1});   
end


[row, col] = size(Y{1,1});

Y1=Y{1,1};
Y2=Y{2,1};
Y3=Y{3,1};
Y4=Y{4,1};
Y5=Y{5,1};
Y6=Y{6,1};
Y7=Y{7,1};
Y8=Y{8,1};

for i = 1:1:row
    for j = 1:1:col
        y(i,j)=max([Y1(i,j),Y2(i,j),Y3(i,j),Y4(i,j),Y5(i,j),Y6(i,j),Y7(i,j),Y8(i,j)]);
    end
end

y = y(2:row-1, 2:col-1);

y_max = max(max(y));

y = (y./y_max)*255;

position1 =find(y<T);
y(position1)=0;

position2 = find(y >= T);
y(position2)=255;


    
    
end

function Y = refocusA(imag, X, A)

[num1, num2, row, col, channel] = size(imag);

N = 15;

K=1:row;
L=1:col;

step = (A - 1)/2;
% center = ceil(A/2);
center = 8;

for i = (center - floor(step)):1:(center + ceil(step)) 
    p_i = X*(-1/2 + (i-1)/(N-1));
    for j = (center - floor(step)):1:(center + ceil(step)) 
        p_j = X*(-1/2 + (j-1)/(N-1));
                for c = 1:1:channel
                    K_new = K+p_i;
                    L_new = L+p_j;
                    [K_new, L_new] = ndgrid(K_new, L_new);
                    a = squeeze(imag(i,j,:,:,c));
                    V(i,j,:,:,c) = interpn(im2double(a),K_new,L_new,'linear',0);
                end
    end
end

O = zeros(1,1,row,col,channel);
for i = (center - floor(step)):1:(center + ceil(step)) 
    for j = (center - floor(step)):1:(center + ceil(step)) 
        O = O + V(i,j,:,:,:);
    end
end

O = squeeze(O);

O = O./max(max(max(O)));

Y = O;

end

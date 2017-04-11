function Y = refocus(imag, X)

[num1, num2, row, col, channel] = size(imag);

N = 15;

K=1:row;
L=1:col;
pi = [];
pj = [];

for i = 1:1:num1
    p_i = X*(-1/2 + (i-1)/(N-1));
    pi(1,i) = p_i;
    for j = 1:1:num2
        p_j = X*(-1/2 + (j-1)/(N-1));
        pj(1,j) = p_j;
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
for i = 1:1:num1
    for j = 1:1:num2
        O = O + V(i,j,:,:,:);
    end
end

O = squeeze(O);

O = O./max(max(max(O)));
Y=O;

end

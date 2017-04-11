function Y = err_diff(X, D)


Y=double(zeros(size(X)));

%normalization of the  error diffusion matrix
D=D./sum(D(:));

[rows, cols]=size(X);

[rows_d,cols_d]=size(D);

%Zero padding needed at the border of the image
border_x= floor(cols_d/2);
border_y=rows_d-1;

X=[X;zeros(border_y,cols)];
X=double([zeros(size(X,1),border_x), X,zeros(size(X,1),border_x)]);

for i=1:rows
    for j=1+border_x:1:cols+border_x
        err=X(i,j);
        if X(i,j)>128
            Y(i,j-border_x)=255;
            err=err-255;
        end
        X(i:i+border_y,j-border_x:j+border_x)=X(i:i+border_y,j-border_x:j+border_x) + double(err).*D;
    end
end

end




function X = quantization(Y, n)
    stepsize = 256/n;
    X = Y;
    for i = 1:1:n
        position = find((stepsize*(i-1)) <= Y &  Y < (stepsize*i));
        X(position) = (i-1);
%         X(position) = (i-1)*stepsize;
    end

%    stepsize = 256/n;
%    X=floor(double(Y)./stepsize).*stepsize;
end

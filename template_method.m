function y = template_method(g1, g2, x, norm,T)

    a1 = conv2(x,g1);
    [r,c] = size(a1);
    a1 = a1(2:r-1, 2: c-1);
    
    a2 = conv2(x,g2);
    [r,c] = size(a2);
    a2 = a2(2:r-1, 2: c-1);

if(norm ==1)
    
    y=sqrt(a1.^2 + a2.^2);
       
end

if(norm==2)
    y=abs(a1)+ abs(a2);
end

position1 =find(y<T);
y(position1)=0;

position2 = find(y >= T);
y(position2)=255;


end

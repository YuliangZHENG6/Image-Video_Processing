function y = laplace_operator(x, s, T )


LOG= fspecial('log', 2*ceil(3*s) +1 ,s);

y=conv2(LOG,x);

y_max = max(max(y));

y = y.*255./y_max;


ind=cell(size(x,1)*size(x,2),1);
[row,col]=size(x);

n=0;
for i=1:1:row
    for j=1:1:col;
       if(y(i,j)*y(i+1,j)<0 && abs(y(i,j)+y(i+1,j))>T)
           n=n+1;
           if(y(i,j)<0 )
               %y(i,j)=255;
               ind{n,1}=[i,j]; 
           else
               %y(i+1,j)=255;
               ind{n,1}=[i+1,j];
           end
           
       
    end
    end

end

for i=1:1:row
    for j=1:1:col;
       if(y(i,j)*y(i,j+1)<0 && abs(y(i,j)+y(i+1,j))>T)
           n=n+1;
           if(y(i,j)<0)
               %y(i,j)=255;
               ind{n,1}=[i,j]; 
           else
               %y(i+1,j)=255;
               ind{n,1}=[i,j+1];
           end
                 
    end
    end

end

y=zeros(size(x,1),size(x,2));

m=1;
while(isempty(ind{m,1})==false)
    p = ind{m,1};
    a=p(1,1);
    b=p(1,2);
    y(a,b)=255;
    m=m+1;
end

    


end 


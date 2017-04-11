function y = frei_chen(x,T)



f0= (1/(2*sqrt(2))).*[1 sqrt(2) 1; 0 0 0 ;-1 -sqrt(2) -1];
f1= f0';
f2= (1/(2*sqrt(2))).*[0 -1 sqrt(2);1 0 -1;-sqrt(2) 1 0];
f3= (1/(2*sqrt(2))).*[sqrt(2) -1 0 ; -1 0 1; 0 1 -sqrt(2)];
f4=0.5.*[0 1 0; -1 0 -1 ; 0 1 0 ];
f5=0.5.* [-1 0 1 ; 0 0 0; 1 0 -1];
f6=(1/6).*[1 -2 1 ; -2 4 -2 ; 1 -2 1];
f7= (1/6).*[-2 1 -2 ; 1 4 1 ; -2 1 -2];
f8= (1/3).*[1 1 1; 1 1 1; 1 1 1];

y0=conv2( x, f0);
[row,col]=size(y0);
y0= y0(2:row-1,2:col-1);
y0_new=y0.^2;


y1=conv2( x, f1);
[row,col]=size(y1);
y1= y1(2:row-1,2:col-1);
y1_new=y1.^2;

y2=conv2( x, f2);
[row,col]=size(y2);
y2= y2(2:row-1,2:col-1);
y2_new=y2.^2;

y3=conv2( x, f3);
[row,col]=size(y3);
y3= y3(2:row-1,2:col-1);
y3_new=y3.^2;

y4=conv2( x, f4);
[row,col]=size(y4);
y4= y4(2:row-1,2:col-1);
y4_new=y4.^2;

y5=conv2( x, f5);
[row,col]=size(y5);
y5= y5(2:row-1,2:col-1);
y5_new=y5.^2;

y6=conv2( x, f6);
[row,col]=size(y6);
y6= y6(2:row-1,2:col-1);
y6_new=y6.^2;

y7=conv2( x, f7);
[row,col]=size(y7);
y7= y7(2:row-1,2:col-1);
y7_new=y7.^2;

y8=conv2( x, f8);
[row,col]=size(y8);
y8= y8(2:row-1,2:col-1);
y8_new=y8.^2;

m= y0_new + y1_new;
s= y0_new + y1_new + y2_new + y3_new + y4_new + y5_new + y6_new + y7_new + y8_new ;

y= sqrt(m./s);

y_max = max(max(y));

y = y.*255./y_max;

position1 =find(y<T);
y(position1)=0;

position2 = find(y >= T);
y(position2)=255;

end



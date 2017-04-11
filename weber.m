function [A] = weber(L1, L2, Lb)

 Matrix_L1 = L1.*ones(160, 80);
 Matrix_L2 = L2.*ones(160, 80);
 % the up and down part of the Lb
 Matrix_Lb_1 = Lb.*ones(220, 600);
 % the left and right part of the Lb
 Matrix_Lb_2 = Lb.*ones(160,220);
 
 A = [Matrix_Lb_1; Matrix_Lb_2, Matrix_L1, Matrix_L2, Matrix_Lb_2; Matrix_Lb_1];
 

end

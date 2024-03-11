% zlicza sumę stanów, z uwzględnieniem poprawki na stan q2

function [neighbors_sum, max_sum] = NeighboursSum(q1,q2,x,y)
    sum = 0;
    max_sum_temp = 0;
    no_security_measures = 1;
    self_protecting = 0.7;
    protecting_others = 0.3;
    
    [w,k] = size(q1);
    
    if x>1 
        if q2(x-1,y)==0 %q2 no security measures
            sum = sum+no_security_measures*q1(x-1,y);
        elseif q2(x-1,y)==1 %q2 self protecting
            sum = sum+self_protecting*q1(x-1,y);
        elseif q2(x-1,y)==2 %q2 protecting others
            sum = sum+protecting_others*q1(x-1,y);
        end
        max_sum_temp = max_sum_temp+1;
    end
    if y>1 
        if q2(x,y-1)==0
            sum = sum+no_security_measures*q1(x,y-1);
        elseif q2(x,y-1)==1
            sum = sum+self_protecting*q1(x,y-1);
        elseif q2(x,y-1)==2
            sum = sum+protecting_others*q1(x,y-1);
        end
        max_sum_temp = max_sum_temp+1;
    end
    if x<w  
        if q2(x+1,y)==0
            sum = sum+no_security_measures*q1(x+1,y);
        elseif q2(x+1,y)==1
            sum = sum+self_protecting*q1(x+1,y);
        elseif q2(x+1,y)==2
            sum = sum+protecting_others*q1(x+1,y);    
        end
        max_sum_temp = max_sum_temp+1;
    end
    if y<k 
        if q2(x,y+1)==0
            sum = sum+no_security_measures*q1(x,y+1);
        elseif q2(x,y+1)==1
            sum = sum+self_protecting*q1(x,y+1);
        elseif q2(x,y+1)==2
            sum = sum+protecting_others*q1(x,y+1);   
        end
        max_sum_temp = max_sum_temp+1;
    end
    if x>1 && y>1 
        if q2(x-1,y-1)==0
            sum = sum+no_security_measures*q1(x-1,y-1);
        elseif q2(x-1,y-1)==1
            sum = sum+self_protecting*q1(x-1,y-1);
        elseif q2(x-1,y-1)==2
            sum = sum+protecting_others*q1(x-1,y-1);    
        end
    end
    if x>1 && y<k 
        if q2(x-1,y+1)==0
            sum = sum+no_security_measures*q1(x-1,y+1);
        elseif q2(x-1,y+1)==1
            sum = sum+self_protecting*q1(x-1,y+1);
        elseif q2(x-1,y+1)==2
            sum = sum+protecting_others*q1(x-1,y+1);    
        end
        max_sum_temp = max_sum_temp+1;
    end
    if x<w && y>1 
        if q2(x+1,y-1)==0
            sum = sum+no_security_measures*q1(x+1,y-1);
        elseif q2(x+1,y-1)==1
            sum = sum+self_protecting*q1(x+1,y-1);
        elseif q2(x+1,y-1)==2
            sum = sum+protecting_others*q1(x+1,y-1);    
        end
        max_sum_temp = max_sum_temp+1;
    end
    if x<w && y<k
        if q2(x+1,y+1)==0
            sum = sum+no_security_measures*q1(x+1,y+1);
        elseif q2(x+1,y+1)==1
             sum = sum+self_protecting*q1(x+1,y+1);
        elseif q2(x+1,y+1)==2
             sum = sum+protecting_others*q1(x+1,y+1);   
        end
        max_sum_temp = max_sum_temp+1;
    end
    
neighbors_sum = sum;
max_sum = max_sum_temp;
   
end
  
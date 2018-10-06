function dydt = odefcn(t,y,tau,prod_term,slope,abs_flag)
if abs_flag
    if (y<.001 && slope<0) || (y>.999 && slope>0)
        dydt=0;
    else
        dydt = 1/tau*slope*abs(prod_term-y);
       
    end
else
    dydt = 1/tau*(prod_term-y);

end


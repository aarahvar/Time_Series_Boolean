
function [T_b,TF_d,TF_s,TF_b,y_out,timespan_Tb]= Convert_Binary2Analog(TF,Logic_Output,Y0,timespan,windowSize,Range_divider_thr,Use_Smoothed_Curve,...
    Anti_Log,plot_ts_flag,Plot_Hill_Mesh_Flag,Use_Hill_Flag,normalized_hill_flag,n,k,tau,abs_flag,shift,Noise_Level)


[T_b,TF_d,TF_s,TF_b,timespan_Tb]=Find_Target_Slop(TF,windowSize,Range_divider_thr,Logic_Output,Use_Smoothed_Curve,Anti_Log,plot_ts_flag,timespan,shift);
T_d = 2*T_b-1;
synthetic_term = Interpolate_Production_Term(Logic_Output,TF,Plot_Hill_Mesh_Flag,Use_Hill_Flag,normalized_hill_flag,n,k);


nTime     = length(timespan);
y_out    = zeros(nTime, length(Y0));
y_out(1, :) = Y0;
y0=Y0;
for iTime = 2:nTime-1
    if abs_flag
        [~, y_] = ode45(@(t,y) odefcn(t,y,tau, synthetic_term(iTime),T_d(iTime),abs_flag), timespan(iTime-1:iTime), y0+Noise_Level*(rand(1)-.5));
    else
        [~, y_] = ode45(@(t,y) odefcn(t,y,tau, synthetic_term(iTime),[],abs_flag), timespan(iTime-1:iTime), y0+Noise_Level*(rand(1)-.5));
    end
    y0       = y_(end, :);
    y_out(iTime, :) = y0;
end

y_out = [NaN(shift,1);y_out];


end
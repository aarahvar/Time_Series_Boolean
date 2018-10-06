function [T_b,TF_d,TF_s,TF_b,y_out,timespan_Tb] = Generate_Target_ts(TF,Logic_Output,Y0,timespan,windowSize,...
    Range_divider_thr,Use_Smoothed_Curve,Anti_Log,plot_ts_flag,Plot_Hill_Mesh_Flag,Use_Hill_Flag,normalized_hill_flag,...
    n,k,tau,abs_flag,Normalize_Input_Flag,shift,Noise_Level)

Num_TF = length(TF);

if Anti_Log
    for i=1:Num_TF
        TF(i).TF=2.^TF(i).TF;
    end
end

for i=1:Num_TF
    if Normalize_Input_Flag %Nomalize beteen [0 1]
        TF(i).TF = (TF(i).TF-min(TF(i).TF))/(max(TF(i).TF)-min(TF(i).TF));
    else %Only normal maximum to one
        TF(i).TF = TF(i).TF/max(TF(i).TF);
    end
    TF(i).mean = mean(TF(i).TF);
end



%Find the slope of the target gene based on the Logic_Output vector
[T_b,TF_d,TF_s,TF_b,y_out,timespan_Tb]= Convert_Binary2Analog(TF,Logic_Output,Y0,timespan,windowSize,...
    Range_divider_thr,Use_Smoothed_Curve,Anti_Log,plot_ts_flag,Plot_Hill_Mesh_Flag,Use_Hill_Flag,normalized_hill_flag,n,k,tau,abs_flag,shift,Noise_Level);

% Mean_T_Real = mean(T_real_ts);
% y_out = y_out-mean(y_out)+Mean_T_Real;

y_out = (y_out-min(y_out(1+shift:end-1)));
y_out = y_out/max(y_out(1+shift:end-1));


figure(10)
hold on
subplot(313)
% plot(timespan(1:end-1),[T_real_ts(1:end-1)],'marker','.','markersize',10)
plot(timespan_Tb,y_out,'marker','.','markersize',10)
ylabel('T')
xlim([timespan(1) timespan(end)]);


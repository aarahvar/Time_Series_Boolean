function  [T_b,TF_d,TF_s,TF_b,timespan_Tb]=Find_Target_Slop(TF,windowSize,Range_divider_thr,Logic_Output,Use_Smoothed_Curve,Anti_Log,plot_flag,timespan,shift)

Num_TF = length(TF);
N = size(TF(1).TF,1);

% TF_d(1:Num_TF).TF_d = [];
% TF_s(1:Num_TF).TF_s = [];
% TF_b(1:Num_TF).TF_b = [];

for i=1:length(TF)
    [TF_d(i).TF_d,TF_s(i).TF_s] = up_discretize(TF(i).TF,windowSize,Range_divider_thr,Use_Smoothed_Curve);
    
    if Use_Smoothed_Curve
        TF(i).TF = TF_s(i).TF_s;
        TF(i).TF = TF(i).TF/max(TF(i).TF);
    end
    if Anti_Log
        TF_d(i).TF_d=(TF_d(i).TF_d+1)/2;
    end
    
    TF_b(i).TF_b = (TF_d(i).TF_d==1);
    
end




%% Calculate the logical operation between the time series
N_b = length(TF_b(1).TF_b);

b = dec2bin([0:length(Logic_Output)- 1])=='1';

T_b = zeros(N_b,1);

for indx = find(Logic_Output)
    sub_T = ones(N_b,1);
    for j=1:Num_TF
        if b(indx,j)==1
            sub_T = sub_T & TF_b(j).TF_b;
        else
            sub_T = sub_T & ~TF_b(j).TF_b;
        end
    end
    T_b = T_b | sub_T;
    
end

T_b = [NaN(shift,1);T_b];
diff_t = diff(timespan);
diff_t = diff_t(1);
timespan_Tb = [timespan timespan(end)+diff_t:diff_t:timespan(end)+(shift*diff_t)];

%T = (~TF_b(1).TF_b & ~TF_b(2).TF_b)% |(TF_b(1).TF_b & ~TF_b(2).TF_b) ;


if plot_flag
    figure(10)
    clf
    for i=1:Num_TF
        
        subplot(Num_TF+1,1,i);
        plot(timespan,[TF(i).TF],'marker','.','markersize',10)
        hold on
        plot(timespan,[(TF_d(i).TF_d+1)/2],'linewidth',2);
        eval(['ylabel(''TF_' num2str(i) ''')']);
        xlim([timespan(1) timespan_Tb(end)]);
        if i==1
           title(['Logic:  ' num2str(Logic_Output)])
        end
    end
    
    subplot(Num_TF+1,1,Num_TF+1);
    hold on
    %plot(timespan_Tb(1:end-1),T_b,'r','linewidth',2);
    xlim([timespan(1) timespan_Tb(end)]);
    
    
    %linkaxes([ax1,ax2,ax3],'xy')
end

if ~exist('gene_names_std')
    load('DTA_data');
end

TF1_name = 'fkh2';
TF2_name = 'ndd1';
T_name = 'hof1';


% % %Loregic: Direct AND
% TF1_name = 'gcn4';
% TF2_name = 'gln3';
% T_name = 'idp1';
% 

% TF1_name = 'put3';
% TF2_name = 'ixr1';
% T_name = 'irc19';

% TF1_name = 'swi4';
% TF2_name = 'rnr1';
% T_name = 'irc19';
% % 
total_flag = 1;
ts_set_number = 1;

% Gene_Index = geneStd2Num({TF1_name,TF2_name,T_name});
% 
% if length(Gene_Index)==3
%     m=0;
%     for ii = Gene_Index(1:end-1)'
%         m=m+1;
%         
%         %eval like: TF(m).TF = expr1( ii,:)  (it could be expr1 or expr2)
%         if total_flag
%             eval(['TF(m).TF = expr' num2str(ts_set_number) '( ii,:);']);
%         else
%             eval(['TF(m).TF = syn' num2str(ts_set_number) '( ii,:);']);
%         end
%         TF(m).TF = TF(m).TF(1:end)';
%         
%         
%     end
% end

% %Extract the time series of the measured target gene time
% if total_flag
%     eval(['T_real_ts = expr' num2str(ts_set_number) '( Gene_Index(end),:);']);
% else
%     eval(['T_real_ts = syn' num2str(ts_set_number) '( Gene_Index(end),:);']);
% end
% T_real_ts = T_real_ts(1:end)';
% T_real_ts = T_real_ts/max(T_real_ts);
% 
% timespan = 0:5:205;

timespan = 0:5:1000;
N_t = length(timespan);
%TF(1).TF = sin(2*pi*timespan./(55+(2*(rand(1,N_t)-.5))));
TF(1).TF = sin(2*pi*timespan/(55)+(2*pi*.15*(rand(1,N_t)-.5)));
TF(2).TF = sin(2*pi*(timespan+randperm(59,1))/(60)+(2*pi*.15*(rand(1,N_t)-.5)));


% TF(1).TF = Gene.E2F1.Value(1,42:88)';
% TF(2).TF = Gene.CCNF.Value(42:88)';
% % TF(2).TF = Gene.CCNA2.Value(42:88)';
% t1 = 0:46;


Noise_Level = .7 ; 

Anti_Log = 0  ;
Use_Smoothed_Curve =0  ;
normalized_hill_flag = 0;
Normalize_Input_Flag = 1;
Use_Hill_Flag = 1;
Plot_Hill_Mesh_Flag = 0;
Logic_Output = [0 0 1 0];

n= 4   ;
k=.5;
abs_flag = 0 ;

tau = 5   ;


windowSize = 2;
Range_divider_thr = 10;
shift = 2 ;
Num_TF = length(TF);

plot_ts_flag = 1;

Y0= .8*rand+.1;%T_real_ts(shift+1);

[T_b,TF_d,TF_s,TF_b,y_out,timespan_Tb] = Generate_Target_ts(TF,Logic_Output,Y0,timespan,windowSize,...
    Range_divider_thr,Use_Smoothed_Curve,Anti_Log,plot_ts_flag,Plot_Hill_Mesh_Flag,Use_Hill_Flag,...
    normalized_hill_flag,n,k,tau,abs_flag,Normalize_Input_Flag,shift,Noise_Level);


%Discretize T_real_ts to identify the logic
[T_d,T_s] = up_discretize(y_out,windowSize,Range_divider_thr,Use_Smoothed_Curve);
T_b = (T_d==1)+0;
T_b(isnan(T_d)) = NaN;
%plot(timespan_Tb,T_s,'g','linewidth',2);
plot(timespan_Tb,T_b,'r','linewidth',2);
ylim([0  1])
ax(1) = subplot(311);
ax(2) = subplot(312);
ax(3) = subplot(313);
linkaxes(ax,'x');



% [TF_d1,~] = discretize_thr(TF(1).TF,windowSize,Range_divider_thr);
% [TF_d2,~] = discretize_thr(TF(2).TF,windowSize,Range_divider_thr);
% [T_d,~] = discretize_thr(T,windowSize,Range_divider_thr);


% plot((TF1_b & TF2_b)*2-1,'g')

clc
%00
ind = find(~TF_b(1).TF_b & ~TF_b(2).TF_b);
count00=hist(T_b(ind'),[0 1]);
display(['00: ' num2str(count00)]);
%01
ind = find(~TF_b(1).TF_b & TF_b(2).TF_b);
count01=hist(T_b(ind'),[0 1]);
display(['01: ' num2str(count01)]);


%10
ind = find(TF_b(1).TF_b & ~TF_b(2).TF_b);
count10=hist(T_b(ind'),[0 1]);
display(['10: ' num2str(count10)]);


%11
ind = find(TF_b(1).TF_b & TF_b(2).TF_b);
count11=hist(T_b(ind'),[0 1]);
display(['11: ' num2str(count11)]);

display('***************************')
[~,out_11] = max(count11);
out_11 = out_11-1;
[~,out_10] = max(count10);
out_10 = out_10-1;
[~,out_01] = max(count01);
out_01 = out_01-1;
[~,out_00] = max(count00);
out_00 = out_00-1;


Logic_Output
display(['00: ' num2str(out_00)]);
display(['01: ' num2str(out_01)]);
display(['10: ' num2str(out_10)]);
display(['11: ' num2str(out_11)]);

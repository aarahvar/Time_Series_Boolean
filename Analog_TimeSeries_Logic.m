% if ~exist('Gene')
if ~exist('Gene')
    load('Gene');
end

 figure(3);
 clf

%gene = Gene.E2F1.Value(1,41:108)';
gene = Gene.CCNF.Value(41:108)';

plot(gene)
hold on

windowSize = 2;
Range_divider_thr = 60;


[Discretized,ts_smoothes] = up_discretize(gene,windowSize,Range_divider_thr);

plot([Discretized(1);Discretized],'linewidth',2);
%plot(sign(gene(3:end)),'g')
%plot(y)

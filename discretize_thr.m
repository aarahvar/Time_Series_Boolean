function [Discretized,ts_smoothes] = discretize_thr(ts,windowSize,Range_divider_thr)

ts=ts(:);
b = (1/windowSize)*ones(1,windowSize);
ts_smoothes = filter(b,1,ts);

range = max(ts-min(ts));
thr = range/Range_divider_thr;

ts_diff = diff(ts_smoothes);
no_change_index = find(abs(ts_diff)<thr);

if (~isempty(no_change_index) && no_change_index(1)==1)
    no_change_index(1)=[];
end

mean_ts = mean(ts);

Discretized = 2*(ts>mean_ts)-1;

end

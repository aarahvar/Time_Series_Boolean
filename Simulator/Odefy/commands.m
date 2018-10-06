
%%
InitOdefy
model = ExpressionsToOdefy({'I1 = <>', 'I2 = <>',...
'A = ~D', 'B = A && I1', ...
'C = B || E', 'D = C', 'E = ~I1 && I2', 'F = E || G',...
'G = F'});
Simulate(model);
%%
InitOdefy

model = ExpressionsToOdefy({'I1 = <>', 'I2 = F',...
'A = ~D', 'B = A && I1', ...
'C = B || E', 'D = C', 'E = I1 && I2', 'F = ~E'});

Simulate(model);
%%
InitOdefy

model = ExpressionsToOdefy({'I1 = <>', 'I2 = F',...
'A = ~D', 'B = A && I1', ...
'C = B || ~E', 'D = C', 'E = I1 && I2', 'F = ~E'});

Simulate(model);

%%
%I2-> B <-A

InitOdefy

model = ExpressionsToOdefy({'I1 = <>', 'I2 = F',...
'A = ~D', 'B = A && I2', ...
'C = B || ~E', 'D = C', 'E = I1 && I2', 'F = ~E'});

Simulate(model);

%%
%~I2-> B <-~A

InitOdefy

model = ExpressionsToOdefy({'I1 = <>', 'I2 = F',...
'A = ~D', 'B = ~A && ~I2', ...
'C = B || ~E', 'D = C', 'E = I1 && I2', 'F = ~E'});

Simulate(model);
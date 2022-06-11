clear all;

% Set seed to Cesar's birthday for replicability
rng (1207100);


% Saffran 1996 with standard decay and activation threhold
testTransitions.Saffran1996_Std_WithThreshold = arrayfun (@(i) run_simulation('saffran1996', 45, 0.2, .65, 1, 'tw', true), 1:1000);
testTransitions.Saffran1996_Std_WithThreshold = [[testTransitions.Saffran1996_Std_WithThreshold.words]' [testTransitions.Saffran1996_Std_WithThreshold.partWordsBCD]' [testTransitions.Saffran1996_Std_WithThreshold.partWordsCDE]'];

% Saffran 1996 with standard decay but without activation threhold
testTransitions.Saffran1996_Std_NoThreshold = arrayfun (@(i) run_simulation('saffran1996', 45, 0.2, .65, 1, 'tw', false), 1:1000);
testTransitions.Saffran1996_Std_NoThreshold = [[testTransitions.Saffran1996_Std_NoThreshold.words]' [testTransitions.Saffran1996_Std_NoThreshold.partWordsBCD]' [testTransitions.Saffran1996_Std_NoThreshold.partWordsCDE]'];

% Saffran 1996 with no decay and activation threhold
testTransitions.Saffran1996_None_WithThreshold = arrayfun (@(i) run_simulation ('saffran1996', 45, 0.2, .65, 1, 'none', true), 1:1000);
testTransitions.Saffran1996_None_WithThreshold = [[testTransitions.Saffran1996_None_WithThreshold.words]' [testTransitions.Saffran1996_None_WithThreshold.partWordsBCD]' [testTransitions.Saffran1996_None_WithThreshold.partWordsCDE]'];

% Saffran 1996 with no decay but without activation threhold
testTransitions.Saffran1996_None_NoThreshold = arrayfun (@(i) run_simulation ('saffran1996', 45, 0.2, .65, 1, 'none', false), 1:1000);
testTransitions.Saffran1996_None_NoThreshold = [[testTransitions.Saffran1996_None_NoThreshold.words]' [testTransitions.Saffran1996_None_NoThreshold.partWordsBCD]' [testTransitions.Saffran1996_None_NoThreshold.partWordsCDE]'];

% Saffran 1996 with complete decay and activation threhold
testTransitions.Saffran1996_Complete_WithThreshold = arrayfun (@(i) run_simulation ('saffran1996', 45, 0.2, .65, 1, 'complete', true), 1:1000);
testTransitions.Saffran1996_Complete_WithThreshold = [[testTransitions.Saffran1996_Complete_WithThreshold.words]' [testTransitions.Saffran1996_Complete_WithThreshold.partWordsBCD]' [testTransitions.Saffran1996_Complete_WithThreshold.partWordsCDE]'];

% Saffran 1996 with complete decay but without activation threhold
testTransitions.Saffran1996_Complete_NoThreshold = arrayfun (@(i) run_simulation ('saffran1996', 45, 0.2, .65, 1, 'complete', false), 1:1000);
testTransitions.Saffran1996_Complete_NoThreshold = [[testTransitions.Saffran1996_Complete_NoThreshold.words]' [testTransitions.Saffran1996_Complete_NoThreshold.partWordsBCD]' [testTransitions.Saffran1996_Complete_NoThreshold.partWordsCDE]'];

% % Endress & Mehler with standard decay and activation threhold
% This seems to work, no longer needed
% testTransitions.EM = arrayfun (@(i) run_simulation ('endressmehler', 45, 0.2, .65, 1, 'tw', true), 1:1000);
% testTransitions.EM = [[testTransitions.EM.words]' [testTransitions.EM.partWordsBCD]' [testTransitions.EM.phantomWords]'];





% For laziness, save results and open them in R to create less ugly figures
% https://uk.mathworks.com/matlabcentral/answers/447171-how-to-convert-mat-data-file-to-r



save 'tw_weights.mat' testTransitions;


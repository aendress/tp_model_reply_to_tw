function [transitionWeights] = run_simulation (experiment, nRepPerWord, beta, ltp_thres,epochs, decayType, useThresholdForInternalActivation)

%%% FUNCTION DEFINITIONS START %%%


    function [vec] = number2vec (n, nNeurons)
        % Concvert a decimal number into a binary vector of size nNeurons
        % 
        % Example: number2vec (2, 3) = [0 1 0]

        vec = zeros (1, nNeurons);
        vec(n) = 1;

    end % number2vec

    function [transitions] = get_adjacent_transitions (words)
        % Extract transitions among adjacent syllables in trisyllabic words
        % Could use nchoosek

        transitions = cellfun (@(w) [w(1:2); w(2:3)], words, 'UniformOutput', false);

        transitions = vertcat (transitions{:});

    end % get_adjacent_transitions


    function [transitionWeights] = get_weights_for_transitions (W, transitions)
        % Extract weights correspond to transitions between syllables
        % Arguments
        %   W: matrix
        %   transitions: ?x2 matrix corresponding to transition indices
        %   between sylables

        % Make sure weight is symmetrical

        if (~isequal(W, W'))
            error ('Weight matrix is not symmetrical')
        end


        transitionWeights = arrayfun (@(i) W(transitions(i, 1), transitions(i, 2)), 1:size (transitions, 1));

        transitionWeights = mean (transitionWeights);

    end % get_weights_for_transitions

    function [words, testTransitions, stream] = define_languages (experiment, nRepPerWord)
        % Define words, part-words, phantom-words and the relevant
        % transitions
        % Arguments: 
        %   experiment: saffran1996|endressmehler
        %   nRepPerWord: number of repetitions per word in the stream

        if nargin < 2
            nRepPerWord = 2;
        end


        % Define words and test items
        switch experiment

            case 'saffran1996'
                % Saffran 1996: tupiro, golabu, bidaku, padoti
                words = {...
                    1:3,
                    4:6,
                    7:9,
                    10:12};

                partWordsBCD = {...
                    2:4,
                    5:7,
                    8:10,
                    [11 12 1]};

                partWordsCDE = {...
                    3:5,
                    6:8,
                    9:11,
                    [12 1 2]};


            case 'endressmehler'

                words = {...
                    [1 2 7],
                    [8 2 3],
                    [1 9 3],
                    [4 5 7],
                    [8 5 6],
                    [4 9 6]};

                partWordsCDE = {...
                    [7 8 2],
                    [3 1 9],
                    [3 4 5],
                    [7 8 5],
                    [6 4 9],
                    [6 1 2]};

                phantomWords = {...
                    1:3,
                    4:6};

                testTransitions.phantomWords = get_adjacent_transitions (phantomWords);


            otherwise
                error ('unknown experiment');
        end

        % Get the number of neurons
        nNeurons = max (horzcat (words{:}));

        % Transform words from (decimal) numbers to binary vectors
        % Each word is a 3 x 1 cell
        wordsBin = cellfun (@(currentWord) ...
            arrayfun(@(currentSyll) number2vec (currentSyll, nNeurons), currentWord, 'UniformOutput', false)', ...
            words, 'UniformOutput', false);


        % Repeat words for stream
        stream = repmat (wordsBin, nRepPerWord, 1);
        % Shuffle stream
        stream = stream (randperm (size (stream, 1)));
        % Convert to matrix
        stream = cellfun (@(word) vertcat (word{:}), stream, 'UniformOutput', false);
        stream = vertcat (stream{:});


        % Get critical transitions for test
        testTransitions.words = get_adjacent_transitions (words);
        testTransitions.partWordsBCD = get_adjacent_transitions (partWordsBCD);
        testTransitions.partWordsCDE = get_adjacent_transitions (partWordsCDE);


    end % define_languages

%%% FUNCTION DEFINITIONS END %%%

% Now do stuff

[words, testTransitions, stream] = define_languages (experiment, nRepPerWord);
W = TW_hebb_ltd_forget(stream,beta,ltp_thres,epochs,decayType,useThresholdForInternalActivation);

% Upper triangular
% W = triu (W)

transitionWeights.words = get_weights_for_transitions (W, testTransitions.words);
transitionWeights.partWordsBCD = get_weights_for_transitions (W, testTransitions.partWordsBCD);
transitionWeights.partWordsCDE = get_weights_for_transitions (W, testTransitions.partWordsCDE);

if (strcmpi (experiment, 'endressmehler'))

    transitionWeights.phantomWords = get_weights_for_transitions (W, testTransitions.phantomWords);

end

end



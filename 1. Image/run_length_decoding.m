% L.B.I.P Thilakasiri - E/16/367

% Contents:- Run Length Decoding

function [arr] = run_length_decoding(init)

% Gets the Huffman Decoded Array as the Input and 
% Returns the Run Length Decoded [400,400] Matrix
% [400,400] is the Image Size
    
    % Making a List of the Elements of the Original Array 
    elements = [];
    for i = 1:2:length(init)
        elements = [elements init(i)];
    end
    
    % Making a List of the Occurences of the Elements
    occurences = [];
    for j = 2:2:length(init)
        occurences = [occurences init(j)];
    end
    
    % Arranging it to Create the Decoded Image
    arr = [];
    for k = 1:length(occurences)
        oc = occurences(k);
        el = elements(k);
        for l = 1:oc
            arr = [arr el];
        end
    end
    arr = reshape(arr,[400,400]);
end

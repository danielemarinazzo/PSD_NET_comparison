function AEC = AEC_noorth(a)
% a is a filtered multichannel signal (time x channels)

N = size(a, 2);
AEC = zeros(N, N);

% Compute amplitude envelope using analytic method
amp = zeros(size(a));
for ch = 1:N
    amp(:, ch) = envelope(a(:, ch), 1, 'analytic');
end

% Compute pairwise AEC
for i = 1:N
    for j = i+1:N
        AEC1 = abs(corrcoef(amp(:,i), amp(:,j)));
        AEC(i,j) = AEC1(1,2);
        AEC(j,i) = AEC(i,j);  % symmetry
    end
end
end

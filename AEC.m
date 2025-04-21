function AEC = AEC_new(a)
% a is a filtered multichannel signal (time x channels)

N = size(a, 2);
AEC = zeros(N, N);

% Compute envelope per channel
amp = zeros(size(a));
for ch = 1:N
    amp(:, ch) = envelope(a(:, ch), 1, 'analytic');
end

for i = 1:N
    for j = i+1:N
        % i -> j
        ort1 = orthog_timedomain(a(:,i), a(:,j));
        amp_ort1 = envelope(ort1, 1, 'analytic');
        AEC1 = abs(corrcoef(amp_ort1, amp(:,i)));

        % j -> i
        ort2 = orthog_timedomain(a(:,j), a(:,i));
        amp_ort2 = envelope(ort2, 1, 'analytic');
        AEC2 = abs(corrcoef(amp_ort2, amp(:,j)));

        AEC_mean = (AEC1(1,2) + AEC2(1,2)) / 2;

        AEC(i,j) = AEC_mean;
        AEC(j,i) = AEC_mean;  % symmetry
    end
end
end

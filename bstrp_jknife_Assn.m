LSAT = [576 635 558 578 666 580 555 661 651 605 653 575 545 572 594];
GPA = [339 330 281 303 344 307 300 343 336 313 312 274 276 288 296];

R = corrcoef(LSAT, GPA);
R = R(1, 2)

B = 2000;
n = 15;

% bootstrap estimate of standard error and bias of R
R_b = [];
for b  = 1:B
    i = datasample(1:n, n);
    LSAT_b = LSAT(i);
    GPA_b = GPA(i);
    temp = corrcoef(LSAT_b, GPA_b);
    R_b(b) = temp(1, 2);
end
se_bs = std(R_b);
bias_bs = mean(R_b - R);

%jackknife estimate of std error and bias of R
I = 1:n;
for i = 1:n
    LSAT_i = LSAT(I ~= i);
    GPA_i = GPA(I ~= i);
    temp = corrcoef(LSAT_i, GPA_i);
    R_j(i) = temp(1, 2);
end
se_j = sqrt((n - 1)/n * sum((R_j - mean(R_j)).^2));
bias_j = (n-1) * (mean(R_j) - R);

%bootstrap t confidence interval for R
alpha = 0.05;
test = [];
R_b1 = [];
indices = [];
for b = 1:B
    i = datasample(1:n, n);
    LSAT_b = LSAT(i);
    GPA_b = GPA(i);
    temp = corrcoef(LSAT_b, GPA_b);
    R_b(b) = temp(1, 2);
    theta_hats(b) = R_b(b);
    indices(b,:) = i(:);
    % to estimate std error of R_b(b)
    for b1 = 1:200
        i1 = datasample(1:n, n);
        LSAT_b1 = LSAT_b(i1);
        GPA_b1 = GPA_b(i1);
        temp1 = corrcoef(LSAT_b1, GPA_b1);
        R_b1(b1) = temp1(1, 2);
    end
    test(b) = std(R_b1);
    t(b) = (R_b(b) - R) / std(R_b1);
end
samp = [];
% jack-knife ( after bootstrap for estimating se(se(R)) )
for i = 1:n
    k = 1;
    for j = 1:B
        if ~ismember(i,indices(j,:))
            samp(k) = R_b(j);
            k = k + 1;
        end
    end
    se_jack(i) = std(samp);
end
jack_after_boot_stderr = sqrt((n-1) * mean((se_jack - mean(se_jack)).^2))
t_sorted = sort(t);
theta_hats_soted = sort(theta_hats);
q = quantile(theta_hats_soted, 1-(alpha/2));
for i = 1:length(theta_hats_soted)
    %theta_hats_soted(i)
    if q < theta_hats_soted(i)
        break;
    end
end
basic_boot_lb_for_R = 2*R - theta_hats_soted(i)
q = quantile(theta_hats_soted, (alpha/2));
for i = 1:length(theta_hats_soted)
    %theta_hats_soted(i)
    if q < theta_hats_soted(i)
        break;
    end
end
basic_boot_ub_for_R = 2*R - theta_hats_soted(i)
se_bs = std(R_b);
t1 = t_sorted(round(length(t) * (1 - 0.5 * alpha)));
t2 = t_sorted(round(length(t) * (0.5 * alpha)));
CI_lower = R - t1 * se_bs
CI_upper = R - t2 * se_bs
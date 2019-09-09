function [] = que1_t()
    % H0: mu = 100
    % H1: mu != 100
    n = 20;
    alpha = 0.05
    z = tinv(alpha/2,n-1);
    mu0 = 500;
    sigma = 100;
    m = 10000;
    p = zeros(m,1);
    for i = 1:m
        x = normrnd(mu0,sigma,[n 1]);
        s2 = ((1/(n-1))*sum((x - mean(x)).^2));
        s2 = (s2/n)^(0.5);
        if mean(x) >= (z*s2 + mu0) && mean(x) <= (-z*s2 + mu0)
            p(i) = 1;
        end
    end
    estimated_alpha = 1 - mean(p)
end
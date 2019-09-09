function [] = que2_t(mu_H1,n)
    %H0: mu = 100
    %H1: mu != 100
    %n = 20;
    alpha = 0.05;
    z = tinv(alpha/2,n-1);
    mu_H0 = 100;
    sigma = 10;
    m = 10000;
    p = zeros(m,1);
    for i = 1:m
        x = normrnd(mu_H1,sigma,[n 1]);
        s2 = ((1/(n-1))*sum((x - mean(x)).^2));
        s2 = (s2/n)^(0.5);
        left_lim = mu_H0 + z*s2;
        rt_lim = mu_H0 - z*s2 ;
        if mean(x) >= left_lim && mean(x) <= rt_lim
            p(i) = 1;
        end
    end
    estimated_beta = mean(p)
end
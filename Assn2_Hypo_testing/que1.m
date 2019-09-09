function [] = que1()
    % H0: mu = 100
    % H1: mu != 100
    n = 20;
    alpha = 0.05;
    z = norminv([0+(alpha/2) 1-(alpha/2)])
    mu0 = 100;
    sigma = 10;
    m = 10000;
    p = zeros(m,1);
    for i = 1:m
        x = normrnd(mu0,sigma,[n 1]);
        s2 = ((1/(n-1))*sum((x - mean(x)).^2));
        s2 = (s2/n)^(0.5);
        if mean(x) >= (z(1)*s2 + mu0) && mean(x) <= (z(2)*s2 + mu0)
            p(i) = 1;
        end
    end
    ans = mean(p)
end
function [] = ex_normal_skewness()
    m = 10000;
    n = [10 20 30 50 100 500];
    reject = zeros(length(n),1);
    for i = 1:length(n)
        cv(i) = qnorm(.975,0,sqrt(6/n(i)));
    end
    for i = 1:length(n)
        sktests = zeros(m,1);
        for j =1:m
           x = normrnd(0,1,[n(i) 1]);
           m3 = mean((x - mean(x)).^3);
           m2 = mean((x - mean(x)).^2);
           val = m3/(m2^1.5);
           if norm(val) >= cv(i)
               sktests(j) = 1;
           end
        end
        reject(i) = mean(sktests);
    end
    for i = 1:length(n)
            fprintf('n = %d and type I error rate = %d\n',n(i),reject(i));
    end
end
           
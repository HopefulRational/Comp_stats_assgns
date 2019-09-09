function[Res] = sample_pt_exp_dist(lambda,n)
u = rand(1);
for i = 1:n
    u = rand(1);
    Res(i) = ((-1/lambda)*(log(u)));
end
hist(Res);
end
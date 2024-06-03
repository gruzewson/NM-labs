

a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;

[n_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @estimate_execution_time);
[n_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @estimate_execution_time);


figure;
subplot(2,1,1);
plot(1:length(xtab_bisection), xtab_bisection);
hold on;
plot(1:length(xtab_secant), xtab_secant);
xlabel('iterations');
ylabel('N');
title('Iterations vs N');
legend('Bisection Method', 'Secant Method');
grid on;

subplot(2,1,2);
semilogy(1:length(xdif_bisection), xdif_bisection);
hold on;
semilogy(1:length(xdif_secant), xdif_secant);
xlabel('iterations');
ylabel('difference');
title('Iterations vs Difference');
legend('Bisection Method', 'Secant Method');
grid on;

print -dpng zadanie8.png 


function time_delta = estimate_execution_time(N)
M = 5000; % [s]
if N <= 0
    error("N can't be <= 0")
end
t = (N^(16/11) + N^((pi)^2/8))/1000;
time_delta = t - M;

end

function [xsolution, ysolution, iterations, xtab, xdif] = bisection_method(a, b, max_iterations, ytolerance, fun)
    xsolution = [];
    ysolution = [];
    iterations = [];
    xtab = [];
    xdif = [];

    for iterations = 1:max_iterations
        xsolution = (a + b) / 2;
        xtab = [xtab; xsolution];

        if iterations > 2
            xdif = [xdif; abs(xtab(iterations) - xtab(iterations-1))];
        end

        if abs(fun(xsolution)) < ytolerance
            break;
        elseif fun(a) * fun(xsolution) < 0
            b = xsolution;
        else
            a = xsolution;
        end
    end

    ysolution = fun(xsolution);
end

function [xsolution, ysolution, iterations, xtab, xdif] = secant_method(a, b, max_iterations, ytolerance, fun)
    xsolution = [];
    ysolution = [];
    iterations = [];
    xtab = [];
    xdif = [];

    for iterations = 1:max_iterations
        xsolution = b - (fun(b)*(b - a))/(fun(b) - fun(a));
        xtab = [xtab; xsolution];
        if iterations > 1
            xdif = [xdif; abs(xtab(iterations) - xtab(iterations-1))];
        end

        if abs(fun(xsolution)) < ytolerance
            break;
        end
        a = b;
        b = xsolution;
    end

    ysolution = fun(xsolution);
end

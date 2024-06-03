function plot_counts_mean(counts_mean)
    figure;
    plot(counts_mean);
    title('counts mean  Plot');
    xlabel('circles');
    ylabel('average tries');
    print -dpng zadanie5.png 
end
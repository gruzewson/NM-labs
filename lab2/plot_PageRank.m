function plot_PageRank(r)
figure;
    bar(r);
    title('Page rank');
    xlabel('x');
    ylabel('y');
    print -dpng zadanie7.png 
end
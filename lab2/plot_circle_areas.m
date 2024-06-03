function plot_circle_areas(circle_areas)
    figure;
    plot(circle_areas);
    title('Circle Areas Plot');
    xlabel('Circle Index');
    ylabel('Area');
    print -dpng zadanie3.png 
end
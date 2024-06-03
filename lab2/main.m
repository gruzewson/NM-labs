clear all
close all
format compact

n_max = 200;
a = 10;
r_max = 2; 
d = 0.85;

[circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
%disp(circles);

%figure;
hold on
for i = 1:n_max
    plot_circle(circles(1, i), circles(2, i), circles(3, i), a); 
end
hold off
print -dpng zadanie1.png 

plot_circle_areas(circle_areas);
plot_counts_mean(counts_mean);

[numer_indeksu, Edges, I, B, A, b, r] = page_rank()
plot_PageRank(r)

function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    index_number = 193589;
    L1 = 9;
    circle_areas = zeros(1, n_max);
    rand_counts = zeros(1, n_max);
    counts_mean = zeros(1, n_max);
    
    for column = 1:n_max
        counter = 0;
        while true
            counter = counter + 1;
            X = rand() * a;
            Y = rand() * a;
            R = rand() * r_max;
            if X - R >= 0 && X + R <= a && Y - R >= 0 && Y + R <= a 
                intersect = false;
                for i = 1:column-1
                    if norm([X; Y] - circles(2:3, i)) < R + circles(1, i)
                        intersect = true;
                        break;
                    end
                end
                if intersect == false
                    circles(:, column) = [R; X; Y];
                    if column > 1
                        circle_areas(column) = cumsum(circle_areas(column-1)) + pi * R^2;
                    else
                        circle_areas(column) = pi * R^2;
                    end
                    break;
                end
            end
        end
        rand_counts(column) = counter;
        counts_mean(column) = mean(rand_counts(1:column));
    end
end

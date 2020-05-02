function [cost] = compute_cost_pc(points, centroids)
  NC = size (centroids, 1);
  nr_p = size (points, 1);
	points_in_group = zeros (1, NC);
  cost = 0;
  for i = 1 : nr_p
    min_d = 100000000;
    for j = 1 : NC
      d = norm (points(i, :) - centroids(j, :), 2);
      if d < min_d
        min_d = d;
      endif
    endfor
    cost = cost + min_d;
  endfor
endfunction


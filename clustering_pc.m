function [centroids cluster] = clustering_pc(points, NC)
  nr_c = size (points, 2); %nr de coloane ale lui points/dimensiuni
  nr_p = size (points, 1); %nr puncte
  centroids = zeros (NC, nr_c);
  suma = zeros (NC, nr_c);
  points_in_cluster = zeros (NC, 1);
  
  for i = 0 : NC - 1
    for j = 1 : nr_p
      modulo = mod (j, NC);
      if modulo == i + 1 || ( i == NC - 1 && modulo == 0 )
        suma(i + 1, :) = suma(i + 1, :) + points(j, :);
        points_in_cluster(i + 1) = points_in_cluster(i + 1) + 1;
      endif
    endfor
    centroids(i + 1, :) = suma(i + 1, :)./points_in_cluster(i + 1);
   endfor
  %end initialisation
  
  prev = centroids;
  
  while 1
    points_in_group = zeros (1, NC);
    suma = zeros(NC, nr_c);
    for i = 1 : nr_p
      min_d = 100000000;
      closest = 1;
      for j = 1 : NC
        d = norm(points(i, :)-centroids(j, :), 2);
        if d < min_d
          min_d = d;
          closest = j;
        endif
      endfor
      points_in_group(closest) = points_in_group(closest) + 1;
      suma(closest, :) = suma(closest, :) + points(i, :);
    endfor
    for i = 1 : NC
      if points_in_group(i) ~= 0
        centroids(i, :) = suma(i, :) ./ points_in_group(i);
      endif
      if points_in_group(i) == 0
        centroids(i, :) = prev(i, :);
      endif
    endfor
    if abs (prev - centroids) == 0
      break;
    endif
    prev = centroids;
  endwhile
endfunction

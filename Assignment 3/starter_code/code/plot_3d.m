function plot_3d(points, camera)
    figure
    hold on;
    scatter3(points(:,1),points(:,2),points(:,3))
    scatter3([0, camera(1,1)], [0, camera(2,1)], [0, camera(3,1)], 'green');
    hold off;
end
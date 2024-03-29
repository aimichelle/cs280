function [points, rec_err] = find_3d_points(matches, P1, P2)
    points = zeros(size(matches,1), 3);
    A = zeros(4, 4);
    err_total = 0;
    for n = 1:size(matches, 1)
        A = [matches(n,1:1)*P1(3,1)-P1(1,1), matches(n,1:1)*P1(3,2)-P1(1,2), matches(n,1:1)*P1(3,3)-P1(1,3), matches(n,1:1)*P1(3,4)-P1(1,4);
             matches(n,2:2)*P1(3,1)-P1(2,1), matches(n,2:2)*P1(3,2)-P1(2,2), matches(n,2:2)*P1(3,3)-P1(2,3), matches(n,2:2)*P1(3,4)-P1(2,4);
             matches(n,3:3)*P2(3,1)-P2(1,1), matches(n,3:3)*P2(3,2)-P2(1,2), matches(n,3:3)*P2(3,3)-P2(1,3), matches(n,3:3)*P2(3,4)-P2(1,4);
             matches(n,4:4)*P2(3,1)-P2(2,1), matches(n,4:4)*P2(3,2)-P2(2,2), matches(n,4:4)*P2(3,3)-P2(2,3), matches(n,4:4)*P2(3,4)-P2(2,4)];
        [U, S, V] = svd(A);
        point = V(:, end);
        points(n, :) = (point(1:3,1)./point(4,1)).';
        
        % Calculate error
        p1 = P1 * point;
        p1 = p1(1:2,:)./p1(3,1);
        p2 = P2 * point;
        p2 = p2(1:2,:)./p2(3,1);
        err_total = err_total + sqrt((matches(n,1:1)-p1(1,:)).^2 + (matches(n,2:2)-p1(2,:)).^2) + sqrt((matches(n,3:3)-p2(1,:)).^2 + (matches(n,4:4)-p2(2,:)).^2);
    end
    rec_err = err_total/(size(matches,1)*2);

end

